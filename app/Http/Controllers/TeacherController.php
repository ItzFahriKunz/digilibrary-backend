<?php

namespace App\Http\Controllers;

use App\Models\Book;
use App\Models\ReadingLog;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class TeacherController extends Controller
{
    /**
     * Daftar 24 kelas standar Sekolah Dasar (Kelas 1 - 6, Sub A - D).
     */
    public static function get24Classes(): array
    {
        $classes = [];
        foreach ([1, 2, 3, 4, 5, 6] as $grade) {
            foreach (['A', 'B', 'C', 'D'] as $sub) {
                $classes[] = "{$grade}{$sub}";
            }
        }
        return $classes;
    }

    /**
     * Helper normalisasi kode kelas (misal "Kelas 4A" atau "4a" -> "4A").
     */
    protected function normalizeClass(?string $raw): ?string
    {
        if (!$raw) return null;
        $trimmed = trim($raw);
        if (in_array(strtolower($trimmed), ['none', 'tidak ada', 'belum ditugaskan', '-', 'null', ''])) {
            return null;
        }
        $clean = strtoupper(trim(preg_replace('/^Kelas\s+/i', '', $trimmed)));
        return in_array($clean, self::get24Classes()) ? $clean : null;
    }

    /**
     * Dasbor Pemantauan Kelas.
     * - Guru (Wali Kelas): HANYA dapat memantau satu kelas binaannya sendiri.
     * - Admin: Dapat memantau seluruh 24 jajaran kelas SD.
     */
    public function overview(Request $request): JsonResponse
    {
        $user = $request->user();
        $isAdmin = $user?->role === 'admin';

        // Guru HANYA memantau kelas binaannya sendiri!
        if (!$isAdmin) {
            $rawClass = $user?->kelas;
            $normalizedClass = $this->normalizeClass($rawClass);

            if (!$normalizedClass) {
                return response()->json([
                    'status'  => 'success',
                    'message' => 'Akun Anda terdaftar sebagai Guru namun belum memiliki penugasan kelas binaan.',
                    'data'    => [
                        'has_assigned_class'     => false,
                        'is_admin'               => false,
                        'current_class'          => null,
                        'teacher_assigned_class' => null,
                        'stats' => [
                            'total_students'         => 0,
                            'active_students'        => 0,
                            'average_progress'       => 0,
                            'total_books_read'       => 0,
                            'total_duration_minutes' => 0,
                        ],
                        'leaderboard'     => [],
                        'students'        => [],
                        'classes_summary' => [],
                    ],
                ]);
            }
            $currentClass = $normalizedClass;
        } else {
            // Admin bebas memantau kelas manapun dari 24 kelas
            $requestedClass = $request->get('kelas');
            $currentClass = ($requestedClass ? $this->normalizeClass($requestedClass) : null)
                ?? ($user?->kelas ? $this->normalizeClass($user->kelas) : null)
                ?? '4A';
        }

        $teacherAssignedClass = ($user?->kelas ? $this->normalizeClass($user->kelas) : null);

        // Varian nama kelas untuk query pencarian di database (misal "4A" atau "Kelas 4A")
        $classVariants = [
            $currentClass,
            "Kelas {$currentClass}",
            strtolower($currentClass),
            "kelas {$currentClass}"
        ];

        // 1. Ambil data Wali Kelas untuk kelas ini
        $waliKelas = User::where('role', 'guru')
            ->where(function ($q) use ($classVariants) {
                $q->whereIn('kelas', $classVariants);
            })
            ->select('id', 'name', 'email', 'avatar', 'kelas')
            ->first();

        // 2. Ambil seluruh siswa di kelas ini
        $students = User::where('role', 'siswa')
            ->where(function ($q) use ($classVariants) {
                $q->whereIn('kelas', $classVariants);
            })
            ->select('id', 'name', 'email', 'avatar', 'kelas', 'created_at')
            ->get();

        $studentIds = $students->pluck('id')->toArray();

        // 3. Ambil log membaca untuk seluruh siswa di kelas ini
        $readingLogs = ReadingLog::with(['book:id,judul,slug,cover_path,total_halaman,penulis'])
            ->whereIn('user_id', $studentIds)
            ->orderBy('read_at', 'desc')
            ->get();

        // Kelompokkan log per siswa
        $logsByStudent = $readingLogs->groupBy('user_id');

        $studentsData = [];
        $totalClassProgress = 0;
        $activeStudentsCount = 0;
        $classUniqueBookIds = [];

        foreach ($students as $student) {
            $studentLogs = $logsByStudent->get($student->id, collect());
            
            $booksReadMap = [];
            $totalDurationSeconds = 0;
            $latestReadAt = null;

            foreach ($studentLogs as $log) {
                $totalDurationSeconds += (int) $log->durasi_detik;
                if (!$latestReadAt || Carbon::parse($log->read_at)->gt(Carbon::parse($latestReadAt))) {
                    $latestReadAt = $log->read_at;
                }

                if (!$log->book) continue;

                $bookId = $log->book_id;
                $classUniqueBookIds[$bookId] = true;

                $totalHalaman = max(1, (int) ($log->book->total_halaman ?: 1));
                $halamanTerakhir = (int) $log->halaman_terakhir;
                $pct = min(100, (int) round(($halamanTerakhir / $totalHalaman) * 100));

                if (!isset($booksReadMap[$bookId])) {
                    $booksReadMap[$bookId] = [
                        'book_id'           => $bookId,
                        'judul'             => $log->book->judul,
                        'slug'              => $log->book->slug,
                        'cover_url'         => $log->book->cover_url,
                        'penulis'           => $log->book->penulis,
                        'total_halaman'     => $totalHalaman,
                        'halaman_terakhir'  => $halamanTerakhir,
                        'progress_percent'  => $pct,
                        'durasi_detik'      => (int) $log->durasi_detik,
                        'last_read_at'      => $log->read_at,
                    ];
                } else {
                    if ($pct > $booksReadMap[$bookId]['progress_percent']) {
                        $booksReadMap[$bookId]['progress_percent'] = $pct;
                        $booksReadMap[$bookId]['halaman_terakhir'] = $halamanTerakhir;
                    }
                    $booksReadMap[$bookId]['durasi_detik'] += (int) $log->durasi_detik;
                }
            }

            $booksList = array_values($booksReadMap);
            $booksCount = count($booksList);

            $avgProgress = 0;
            if ($booksCount > 0) {
                $sumPct = array_sum(array_column($booksList, 'progress_percent'));
                $avgProgress = (int) round($sumPct / $booksCount);
                $activeStudentsCount++;
            }
            $totalClassProgress += $avgProgress;

            $status = 'Belum Membaca';
            if ($avgProgress >= 80 && $booksCount >= 3) {
                $status = 'Sangat Aktif';
            } elseif ($booksCount >= 1) {
                $status = 'Cukup Aktif';
            }

            $studentsData[] = [
                'id'                     => $student->id,
                'name'                   => $student->name,
                'email'                  => $student->email,
                'avatar'                 => $student->avatar,
                'kelas'                  => "Kelas {$currentClass}",
                'books_count'            => $booksCount,
                'avg_progress_percent'   => $avgProgress,
                'total_duration_minutes' => (int) round($totalDurationSeconds / 60),
                'last_read_at'           => $latestReadAt,
                'status'                 => $status,
                'books'                  => $booksList,
            ];
        }

        // Leaderboard: Urutkan siswa dari buku terbanyak dibaca & progres tertinggi
        $leaderboard = $studentsData;
        usort($leaderboard, function ($a, $b) {
            if ($b['books_count'] !== $a['books_count']) {
                return $b['books_count'] <=> $a['books_count'];
            }
            if ($b['avg_progress_percent'] !== $a['avg_progress_percent']) {
                return $b['avg_progress_percent'] <=> $a['avg_progress_percent'];
            }
            return $b['total_duration_minutes'] <=> $a['total_duration_minutes'];
        });

        foreach ($leaderboard as $idx => &$item) {
            $rank = $idx + 1;
            $item['rank'] = $rank;
            if ($rank === 1 && $item['books_count'] > 0) {
                $item['badge'] = 'Bintang Literasi #1';
            } elseif ($rank === 2 && $item['books_count'] > 0) {
                $item['badge'] = 'Juara Baca #2';
            } elseif ($rank === 3 && $item['books_count'] > 0) {
                $item['badge'] = 'Juara Baca #3';
            } else {
                $item['badge'] = null;
            }
        }
        unset($item);

        $topReaders = array_values(array_filter($leaderboard, fn($s) => $s['books_count'] > 0));
        $podium = array_slice($topReaders, 0, 5);

        $totalStudents = count($students);
        $classAvgProgress = $totalStudents > 0 ? (int) round($totalClassProgress / $totalStudents) : 0;
        $totalClassMinutes = array_sum(array_column($studentsData, 'total_duration_minutes'));

        // 4. Ringkasan 24 kelas HANYA diperlukan untuk Administrator
        $classesSummary = [];
        if ($isAdmin) {
            $all24 = self::get24Classes();
            $teachersAll = User::where('role', 'guru')->get();
            $studentsAll = User::where('role', 'siswa')->get();

            foreach ($all24 as $code) {
                $grade = (int) substr($code, 0, 1);
                $sub = substr($code, 1, 1);

                $matchVariants = [$code, "Kelas {$code}", strtolower($code), "kelas {$code}"];

                $countStudents = $studentsAll->filter(function ($s) use ($matchVariants) {
                    return in_array($s->kelas, $matchVariants);
                })->count();

                $wali = $teachersAll->first(function ($t) use ($matchVariants) {
                    return in_array($t->kelas, $matchVariants);
                });

                $classesSummary[] = [
                    'code'           => $code,
                    'grade'          => $grade,
                    'sub'            => $sub,
                    'name'           => "Kelas {$code}",
                    'total_students' => $countStudents,
                    'wali_kelas'     => $wali ? $wali->name : null,
                    'is_my_class'    => $teacherAssignedClass === $code,
                    'is_current'     => $currentClass === $code,
                ];
            }
        }

        return response()->json([
            'status' => 'success',
            'message' => "Data pemantauan Kelas {$currentClass} berhasil dimuat",
            'data' => [
                'has_assigned_class' => true,
                'is_admin'           => $isAdmin,
                'current_class' => [
                    'code'           => $currentClass,
                    'name'           => "Kelas {$currentClass}",
                    'grade'          => (int) substr($currentClass, 0, 1),
                    'sub'            => substr($currentClass, 1, 1),
                    'wali_kelas'     => $waliKelas ? [
                        'id'     => $waliKelas->id,
                        'name'   => $waliKelas->name,
                        'email'  => $waliKelas->email,
                        'avatar' => $waliKelas->avatar,
                    ] : null,
                    'is_my_assigned' => $teacherAssignedClass === $currentClass,
                ],
                'teacher_assigned_class' => $teacherAssignedClass ? "Kelas {$teacherAssignedClass}" : null,
                'stats' => [
                    'total_students'         => $totalStudents,
                    'active_students'        => $activeStudentsCount,
                    'average_progress'       => $classAvgProgress,
                    'total_books_read'       => count($classUniqueBookIds),
                    'total_duration_minutes' => $totalClassMinutes,
                ],
                'leaderboard'     => $podium,
                'students'        => $studentsData,
                'classes_summary' => $classesSummary,
            ],
        ]);
    }

    /**
     * Memperbarui kelas binaan (Wali Kelas) - khusus Admin atau rotasi wali.
     */
    public function updateMyClass(Request $request): JsonResponse
    {
        $user = $request->user();
        if ($user?->role !== 'admin') {
            return response()->json([
                'status'  => 'error',
                'message' => 'Hanya Administrator yang memiliki wewenang untuk menetapkan atau mengubah penugasan wali kelas.',
            ], 403);
        }

        $request->validate([
            'kelas'   => 'nullable|string',
            'user_id' => 'required|integer|exists:users,id',
        ]);

        $targetUser = User::find($request->user_id);
        if ($targetUser->role !== 'guru') {
            return response()->json([
                'status'  => 'error',
                'message' => 'Penugasan wali kelas hanya berlaku untuk akun berstatus Guru.',
            ], 422);
        }

        $raw = $request->input('kelas');
        $trimmed = trim($raw ?? '');
        if (!$raw || in_array(strtolower($trimmed), ['none', 'tidak ada', 'belum ditugaskan', '-', 'null', ''])) {
            $targetUser->kelas = null;
            $targetUser->save();

            return response()->json([
                'status'  => 'success',
                'message' => "Penugasan wali kelas untuk {$targetUser->name} berhasil dikosongkan (Belum Ditugaskan).",
                'data'    => [
                    'user'       => $targetUser->fresh(),
                    'kelas_code' => null,
                ],
            ]);
        }

        $cleanClass = $this->normalizeClass($raw);
        if (!$cleanClass) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Format kelas tidak valid. Pilih dari 24 kelas standar SD (1A - 6D).',
            ], 422);
        }

        // Validasi tidak bertabrakan dengan guru lain
        $existing = User::where('role', 'guru')
            ->where('id', '!=', $targetUser->id)
            ->whereIn('kelas', [$cleanClass, "Kelas {$cleanClass}", strtolower($cleanClass), "kelas {$cleanClass}"])
            ->first();

        if ($existing) {
            return response()->json([
                'status'  => 'error',
                'message' => "Kelas {$cleanClass} sudah memiliki wali kelas atas nama \"{$existing->name}\". Setiap kelas hanya berhak memiliki satu wali kelas.",
            ], 422);
        }

        $targetUser->kelas = "Kelas {$cleanClass}";
        $targetUser->save();

        return response()->json([
            'status'  => 'success',
            'message' => "Kelas binaan {$targetUser->name} berhasil ditetapkan menjadi Kelas {$cleanClass}",
            'data'    => [
                'user'       => $targetUser->fresh(),
                'kelas_code' => $cleanClass,
            ],
        ]);
    }
}