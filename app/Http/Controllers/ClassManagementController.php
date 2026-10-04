<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\DB;
use App\Models\TahunAjaran;
use App\Models\Kelas;
use App\Models\SiswaKelas;
use App\Models\WaliKelas;
use App\Models\User;
use App\Models\ReadingLog;

class ClassManagementController extends Controller
{
    /**
     * Helper 24 Kode Rombel SD Standar (1A - 6D)
     */
    public static function get24RombelCodes(): array
    {
        $codes = [];
        foreach ([1, 2, 3, 4, 5, 6] as $grade) {
            foreach (['A', 'B', 'C', 'D'] as $sub) {
                $codes[] = [
                    'tingkat'     => $grade,
                    'nama_rombel' => "{$grade}{$sub}",
                ];
            }
        }
        return $codes;
    }

    /**
     * Pastikan 24 kelas SD selalu tersedia untuk tahun ajaran yang diberikan.
     */
    protected function ensure24ClassesForYear(TahunAjaran $ta): void
    {
        $existingCount = Kelas::where('tahun_ajaran_id', $ta->id)->count();
        if ($existingCount >= 24) return;

        foreach (self::get24RombelCodes() as $rombel) {
            Kelas::firstOrCreate(
                [
                    'tingkat'         => $rombel['tingkat'],
                    'nama_rombel'     => $rombel['nama_rombel'],
                    'tahun_ajaran_id' => $ta->id,
                ],
                [
                    'kuota_maksimal'  => 32,
                ]
            );
        }
    }

    /**
     * List seluruh kelas & tahun ajaran untuk Panel Admin
     * GET /api/admin/classes
     */
    public function index(Request $request): JsonResponse
    {
        // 1. Ambil atau inisialisasi Tahun Ajaran
        $allTahunAjaran = TahunAjaran::orderBy('tanggal_mulai', 'desc')->get();
        if ($allTahunAjaran->isEmpty()) {
            $defaultTa = TahunAjaran::create([
                'label'           => '2025/2026',
                'tanggal_mulai'   => '2025-07-15',
                'tanggal_selesai' => '2026-06-25',
                'status'          => 'aktif',
            ]);
            $allTahunAjaran = collect([$defaultTa]);
        }

        // Tentukan tahun ajaran target (berdasarkan request atau yang aktif)
        $selectedTaId = $request->query('tahun_ajaran_id');
        $currentTa = $selectedTaId
            ? $allTahunAjaran->firstWhere('id', (int) $selectedTaId)
            : ($allTahunAjaran->firstWhere('status', 'aktif') ?? $allTahunAjaran->first());

        if (!$currentTa) {
            $currentTa = $allTahunAjaran->first();
        }

        // Pastikan 24 rombel terisi untuk tahun ajaran ini
        $this->ensure24ClassesForYear($currentTa);

        // 2. Ambil data 24 kelas beserta relasi wali kelas dan siswa
        $classes = Kelas::where('tahun_ajaran_id', $currentTa->id)
            ->with(['waliKelas.user:id,name,email,avatar,nip', 'activeSiswa.user:id,name'])
            ->orderBy('tingkat', 'asc')
            ->orderBy('nama_rombel', 'asc')
            ->get()
            ->map(function ($k) {
                $totalSiswa = $k->activeSiswa->count();
                $kuota = $k->kuota_maksimal ?: 32;
                $wali = $k->waliKelas?->user;

                return [
                    'id'             => $k->id,
                    'tingkat'        => $k->tingkat,
                    'nama_rombel'    => $k->nama_rombel,
                    'full_name'      => "Kelas {$k->nama_rombel}",
                    'kuota_maksimal' => $kuota,
                    'total_siswa'    => $totalSiswa,
                    'sisa_kuota'     => max(0, $kuota - $totalSiswa),
                    'is_full'        => $totalSiswa >= $kuota,
                    'persen_terisi'  => min(100, round(($totalSiswa / max(1, $kuota)) * 100)),
                    'wali_kelas'     => $wali ? [
                        'id'     => $wali->id,
                        'name'   => $wali->name,
                        'email'  => $wali->email,
                        'avatar' => $wali->avatar,
                        'nip'    => $wali->nip,
                    ] : null,
                ];
            });

        // 3. Daftar seluruh Guru untuk opsi dropdown Wali Kelas
        $teachers = User::where('role', 'guru')
            ->select('id', 'name', 'email', 'avatar', 'nip', 'kelas')
            ->orderBy('name', 'asc')
            ->get()
            ->map(function ($t) use ($currentTa) {
                $assignedWali = WaliKelas::where('user_id', $t->id)
                    ->where('tahun_ajaran_id', $currentTa->id)
                    ->with('kelas')
                    ->first();

                return [
                    'id'               => $t->id,
                    'name'             => $t->name,
                    'email'            => $t->email,
                    'avatar'           => $t->avatar,
                    'nip'              => $t->nip,
                    'assigned_class'   => $assignedWali ? "Kelas {$assignedWali->kelas?->nama_rombel}" : null,
                    'is_assigned'      => (bool) $assignedWali,
                ];
            });

        // 4. Statistik Ringkas
        $totalAllStudents = SiswaKelas::where('tahun_ajaran_id', $currentTa->id)->where('status', 'aktif')->count();
        $totalAssignedWali = WaliKelas::where('tahun_ajaran_id', $currentTa->id)->count();

        return response()->json([
            'status' => 'success',
            'data'   => [
                'current_tahun_ajaran' => [
                    'id'              => $currentTa->id,
                    'label'           => $currentTa->label,
                    'tanggal_mulai'   => $currentTa->tanggal_mulai?->format('Y-m-d'),
                    'tanggal_selesai' => $currentTa->tanggal_selesai?->format('Y-m-d'),
                    'status'          => $currentTa->status,
                ],
                'tahun_ajaran_list'    => $allTahunAjaran->map(fn($ta) => [
                    'id'     => $ta->id,
                    'label'  => $ta->label,
                    'status' => $ta->status,
                ]),
                'stats'                => [
                    'total_classes'    => $classes->count(),
                    'total_students'   => $totalAllStudents,
                    'total_wali'       => $totalAssignedWali,
                    'unassigned_wali'  => max(0, 24 - $totalAssignedWali),
                ],
                'classes'              => $classes,
                'teachers'             => $teachers,
            ],
        ]);
    }

    /**
     * Rincian Siswa di Kelas Tertentu pada Tahun Ajaran yang Dipilih
     * GET /api/admin/classes/{id}/students
     */
    public function showStudents(Request $request, $id): JsonResponse
    {
        $kelas = Kelas::with(['tahunAjaran', 'waliKelas.user'])->findOrFail($id);

        $siswaKelasList = SiswaKelas::where('kelas_id', $kelas->id)
            ->where('tahun_ajaran_id', $kelas->tahun_ajaran_id)
            ->with('user')
            ->get();

        $studentIds = $siswaKelasList->pluck('user_id')->toArray();

        // Hitung progres literasi siswa di kelas ini
        $readingLogs = ReadingLog::whereIn('user_id', $studentIds)->get()->groupBy('user_id');

        $students = $siswaKelasList->map(function ($sk) use ($readingLogs) {
            $u = $sk->user;
            $logs = $readingLogs->get($sk->user_id, collect());
            $booksCount = $logs->where('is_completed', true)->count();
            $avgProgress = $logs->isNotEmpty() ? round($logs->avg('progress_percent')) : 0;
            $totalDuration = $logs->sum('duration_minutes');

            return [
                'siswa_kelas_id'   => $sk->id,
                'user_id'          => $u?->id,
                'name'             => $u?->name ?? 'Siswa Tidak Ditemukan',
                'email'            => $u?->email,
                'avatar'           => $u?->avatar,
                'nis'              => $u?->nis ?? '-',
                'nisn'             => $u?->nisn ?? '-',
                'status'           => $sk->status,
                'books_count'      => $booksCount,
                'avg_progress'     => $avgProgress,
                'total_duration'   => $totalDuration,
                'joined_at'        => $sk->created_at?->format('d M Y'),
            ];
        });

        // Siswa yang belum memiliki kelas di tahun ajaran ini
        $assignedStudentIds = SiswaKelas::where('tahun_ajaran_id', $kelas->tahun_ajaran_id)->pluck('user_id')->toArray();
        $unassignedStudents = User::where('role', 'siswa')
            ->whereNotIn('id', $assignedStudentIds)
            ->select('id', 'name', 'email', 'nis', 'nisn', 'avatar')
            ->orderBy('name', 'asc')
            ->limit(50)
            ->get();

        $kuota = $kelas->kuota_maksimal ?: 32;
        $totalSiswa = $students->count();

        return response()->json([
            'status' => 'success',
            'data'   => [
                'kelas' => [
                    'id'             => $kelas->id,
                    'tingkat'        => $kelas->tingkat,
                    'nama_rombel'    => $kelas->nama_rombel,
                    'full_name'      => "Kelas {$kelas->nama_rombel}",
                    'kuota_maksimal' => $kuota,
                    'total_siswa'    => $totalSiswa,
                    'sisa_kuota'     => max(0, $kuota - $totalSiswa),
                    'is_full'        => $totalSiswa >= $kuota,
                    'tahun_ajaran'   => $kelas->tahunAjaran?->label,
                    'wali_kelas'     => $kelas->waliKelas?->user ? [
                        'id'     => $kelas->waliKelas->user->id,
                        'name'   => $kelas->waliKelas->user->name,
                        'email'  => $kelas->waliKelas->user->email,
                        'nip'    => $kelas->waliKelas->user->nip,
                    ] : null,
                ],
                'students'            => $students,
                'unassigned_students' => $unassignedStudents,
            ],
        ]);
    }

    /**
     * Penetapan / Perubahan Wali Kelas oleh Admin
     * POST /api/admin/classes/{id}/assign-wali
     */
    public function assignWali(Request $request, $id): JsonResponse
    {
        $request->validate([
            'teacher_id' => 'nullable|integer|exists:users,id',
        ]);

        $kelas = Kelas::findOrFail($id);
        $teacherId = $request->input('teacher_id');

        DB::beginTransaction();
        try {
            if (!$teacherId) {
                // Jika mencopot wali kelas
                $oldWali = WaliKelas::where('kelas_id', $kelas->id)
                    ->where('tahun_ajaran_id', $kelas->tahun_ajaran_id)
                    ->first();

                if ($oldWali) {
                    $teacherUser = User::find($oldWali->user_id);
                    if ($teacherUser) {
                        $teacherUser->update(['kelas' => null]);
                    }
                    $oldWali->delete();
                }

                DB::commit();
                return response()->json([
                    'status'  => 'success',
                    'message' => "Wali kelas untuk Kelas {$kelas->nama_rombel} berhasil dikosongkan.",
                ]);
            }

            // Validasi role guru
            $teacher = User::where('id', $teacherId)->where('role', 'guru')->firstOrFail();

            // Cek apakah guru ini sudah memegang kelas lain di tahun ajaran yang sama
            $conflict = WaliKelas::where('user_id', $teacher->id)
                ->where('tahun_ajaran_id', $kelas->tahun_ajaran_id)
                ->where('kelas_id', '!=', $kelas->id)
                ->with('kelas')
                ->first();

            if ($conflict) {
                return response()->json([
                    'status'  => 'error',
                    'message' => "Guru '{$teacher->name}' saat ini sudah menjadi Wali Kelas {$conflict->kelas?->nama_rombel}. Satu guru hanya boleh membina 1 kelas per tahun ajaran.",
                ], 422);
            }

            // Tetapkan wali kelas
            WaliKelas::updateOrCreate(
                [
                    'kelas_id'        => $kelas->id,
                    'tahun_ajaran_id' => $kelas->tahun_ajaran_id,
                ],
                [
                    'user_id' => $teacher->id,
                ]
            );

            // Sinkronkan field kelas di users guru untuk backward-compatibility
            $teacher->update(['kelas' => "Kelas {$kelas->nama_rombel}"]);

            DB::commit();

            return response()->json([
                'status'  => 'success',
                'message' => "Guru '{$teacher->name}' berhasil ditetapkan sebagai Wali Kelas {$kelas->nama_rombel}!",
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'status'  => 'error',
                'message' => 'Gagal menetapkan wali kelas: ' . $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Update Kuota Maksimal Siswa Kelas
     * PUT /api/admin/classes/{id}/quota
     */
    public function updateQuota(Request $request, $id): JsonResponse
    {
        $request->validate([
            'kuota_maksimal' => 'required|integer|min:1|max:100',
        ]);

        $kelas = Kelas::findOrFail($id);
        $kelas->update([
            'kuota_maksimal' => (int) $request->kuota_maksimal,
        ]);

        return response()->json([
            'status'  => 'success',
            'message' => "Kapasitas kuota Kelas {$kelas->nama_rombel} berhasil diperbarui menjadi {$kelas->kuota_maksimal} siswa.",
            'data'    => $kelas,
        ]);
    }

    /**
     * Tambahkan / Pindahkan Siswa ke Kelas Ini
     * POST /api/admin/classes/{id}/students
     */
    public function addStudent(Request $request, $id): JsonResponse
    {
        $request->validate([
            'student_id' => 'required|integer|exists:users,id',
        ]);

        $kelas = Kelas::findOrFail($id);
        $student = User::where('id', $request->student_id)->where('role', 'siswa')->firstOrFail();

        $kuota = $kelas->kuota_maksimal ?: 32;
        $currentCount = SiswaKelas::where('kelas_id', $kelas->id)
            ->where('tahun_ajaran_id', $kelas->tahun_ajaran_id)
            ->where('status', 'aktif')
            ->count();

        if ($currentCount >= $kuota) {
            return response()->json([
                'status'  => 'error',
                'message' => "Kelas {$kelas->nama_rombel} telah mencapai batas kuota maksimal ({$kuota} siswa). Tidak dapat menambahkan siswa lagi.",
            ], 422);
        }

        DB::beginTransaction();
        try {
            SiswaKelas::updateOrCreate(
                [
                    'user_id'         => $student->id,
                    'tahun_ajaran_id' => $kelas->tahun_ajaran_id,
                ],
                [
                    'kelas_id' => $kelas->id,
                    'status'   => 'aktif',
                ]
            );

            $student->update(['kelas' => "Kelas {$kelas->nama_rombel}"]);

            DB::commit();

            return response()->json([
                'status'  => 'success',
                'message' => "Siswa '{$student->name}' berhasil dimasukkan ke Kelas {$kelas->nama_rombel}!",
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'status'  => 'error',
                'message' => 'Gagal menambahkan siswa ke kelas: ' . $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Keluarkan Siswa dari Kelas Ini
     * DELETE /api/admin/classes/{id}/students/{studentId}
     */
    public function removeStudent(Request $request, $id, $studentId): JsonResponse
    {
        $kelas = Kelas::findOrFail($id);
        $student = User::findOrFail($studentId);

        $record = SiswaKelas::where('user_id', $student->id)
            ->where('kelas_id', $kelas->id)
            ->where('tahun_ajaran_id', $kelas->tahun_ajaran_id)
            ->first();

        if ($record) {
            $record->delete();
        }

        $student->update(['kelas' => null]);

        return response()->json([
            'status'  => 'success',
            'message' => "Siswa '{$student->name}' berhasil dikeluarkan dari Kelas {$kelas->nama_rombel}.",
        ]);
    }

    /**
     * Tambah Tahun Ajaran Baru
     * POST /api/admin/academic-years
     */
    public function storeAcademicYear(Request $request): JsonResponse
    {
        $request->validate([
            'label'           => 'required|string|max:50|unique:tahun_ajaran,label',
            'tanggal_mulai'   => 'nullable|date',
            'tanggal_selesai' => 'nullable|date|after_or_equal:tanggal_mulai',
            'set_active'      => 'nullable|boolean',
        ]);

        DB::beginTransaction();
        try {
            $newTa = TahunAjaran::create([
                'label'           => trim($request->label),
                'tanggal_mulai'   => $request->tanggal_mulai,
                'tanggal_selesai' => $request->tanggal_selesai,
                'status'          => $request->boolean('set_active') ? 'aktif' : 'selesai',
            ]);

            if ($request->boolean('set_active')) {
                TahunAjaran::where('id', '!=', $newTa->id)->update(['status' => 'selesai']);
            }

            // Inisialisasi 24 kelas otomatis
            $this->ensure24ClassesForYear($newTa);

            DB::commit();

            return response()->json([
                'status'  => 'success',
                'message' => "Tahun Ajaran {$newTa->label} berhasil dibuat bersama 24 rombel kelas SD!",
                'data'    => $newTa,
            ], 201);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'status'  => 'error',
                'message' => 'Gagal menambahkan tahun ajaran: ' . $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Aktifkan Tahun Ajaran Tertentu
     * PUT /api/admin/academic-years/{id}/activate
     */
    public function activateAcademicYear(Request $request, $id): JsonResponse
    {
        $ta = TahunAjaran::findOrFail($id);

        DB::beginTransaction();
        try {
            TahunAjaran::where('id', '!=', $ta->id)->update(['status' => 'selesai']);
            $ta->update(['status' => 'aktif']);

            // Pastikan 24 rombel ada
            $this->ensure24ClassesForYear($ta);

            DB::commit();

            return response()->json([
                'status'  => 'success',
                'message' => "Tahun Ajaran {$ta->label} kini telah diaktifkan!",
                'data'    => $ta,
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'status'  => 'error',
                'message' => 'Gagal mengaktifkan tahun ajaran: ' . $e->getMessage(),
            ], 500);
        }
    }
}
