<?php

namespace App\Http\Controllers;

use App\Models\Book;
use App\Models\Category;
use App\Models\ReadingLog;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class AdminController extends Controller
{
    /**
     * Dashboard statistik agregat perpustakaan digital dengan data diagram & tren.
     */
    public function stats(): JsonResponse
    {
        $totalBooks = Book::count();
        $totalCategories = Category::count();
        $totalUsers = User::count();
        $totalReads = (int) Book::sum('total_dibaca');
        
        $readsToday = ReadingLog::whereDate('read_at', today())->count();
        $readsThisWeek = ReadingLog::where('read_at', '>=', now()->subDays(7))->count();

        // 1. Platform breakdown (Web vs Mobile) & Percentage
        $webReads = ReadingLog::where('platform', 'web')->count();
        $mobileReads = ReadingLog::where('platform', 'mobile')->count();
        $totalLogCount = $webReads + $mobileReads;
        $webPercent = $totalLogCount > 0 ? round(($webReads / $totalLogCount) * 100) : 55;
        $mobilePercent = $totalLogCount > 0 ? round(($mobileReads / $totalLogCount) * 100) : 45;

        // 2. Tren Aktivitas Membaca Multi-Periode (7 Hari, 30 Hari, 1 Tahun)
        $dayNames = ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab'];
        $monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];

        // A. 7 Hari Terakhir
        $trend7d = [];
        for ($i = 6; $i >= 0; $i--) {
            $date = Carbon::today()->subDays($i);
            $count = ReadingLog::whereDate('read_at', $date)->count();
            $trend7d[] = [
                'day'       => $dayNames[$date->dayOfWeek],
                'label'     => $dayNames[$date->dayOfWeek] . ' (' . $date->format('d/m') . ')',
                'date'      => $date->format('d M'),
                'count'     => $count,
                'is_today'  => $i === 0,
            ];
        }

        // B. 30 Hari Terakhir
        $trend30d = [];
        for ($i = 29; $i >= 0; $i--) {
            $date = Carbon::today()->subDays($i);
            $count = ReadingLog::whereDate('read_at', $date)->count();
            $trend30d[] = [
                'label'     => $date->format('d M'),
                'date'      => $date->format('Y-m-d'),
                'count'     => $count,
                'is_today'  => $i === 0,
            ];
        }

        // C. 12 Bulan Terakhir
        $trend1y = [];
        for ($i = 11; $i >= 0; $i--) {
            $monthDate = Carbon::today()->startOfMonth()->subMonths($i);
            $start = $monthDate->copy()->startOfMonth();
            $end = $monthDate->copy()->endOfMonth();
            $count = ReadingLog::whereBetween('read_at', [$start, $end])->count();
            $trend1y[] = [
                'label'     => $monthNames[$monthDate->month - 1] . ' ' . $monthDate->format('y'),
                'month'     => $monthNames[$monthDate->month - 1],
                'year'      => $monthDate->year,
                'count'     => $count,
                'is_current'=> $i === 0,
            ];
        }

        $dailyTrend = $trend7d;

        // 3. Distribusi Buku per Kategori
        $categoryStats = Category::withCount('books')
            ->withSum('books', 'total_dibaca')
            ->orderBy('books_count', 'desc')
            ->limit(6)
            ->get()
            ->map(function ($c) {
                return [
                    'id'          => $c->id,
                    'nama'        => $c->nama,
                    'tipe'        => $c->tipe,
                    'books_count' => $c->books_count,
                    'reads_count' => (int) ($c->books_sum_total_dibaca ?? 0),
                ];
            });

        // 4. Buku Terpopuler (Top 5)
        $popularBooks = Book::with('category')
            ->orderBy('total_dibaca', 'desc')
            ->limit(5)
            ->get();

        // 5. Log Aktivitas Pembacaan Terbaru
        $recentLogs = ReadingLog::with(['book:id,judul,slug,cover_path', 'user:id,name,email,avatar,role,kelas'])
            ->orderBy('read_at', 'desc')
            ->limit(10)
            ->get();

        return response()->json([
            'status' => 'success',
            'message' => 'Statistik dashboard berhasil diambil',
            'data' => [
                'summary' => [
                    'total_books'      => $totalBooks,
                    'total_categories' => $totalCategories,
                    'total_users'      => $totalUsers,
                    'total_reads'      => $totalReads,
                    'reads_today'      => $readsToday,
                    'reads_this_week'  => $readsThisWeek,
                ],
                'platform_stats' => [
                    'web'            => $webReads,
                    'mobile'         => $mobileReads,
                    'web_percent'    => $webPercent,
                    'mobile_percent' => $mobilePercent,
                    'total_logs'     => $totalLogCount,
                ],
                'user_distribution' => [
                    'siswa' => User::where('role', 'siswa')->count(),
                    'guru'  => User::where('role', 'guru')->count(),
                    'admin' => User::where('role', 'admin')->count(),
                    'total' => $totalUsers,
                ],
                'reading_trends' => [
                    '7d'  => $trend7d,
                    '30d' => $trend30d,
                    '1y'  => $trend1y,
                ],
                'daily_trend'       => $dailyTrend,
                'category_stats'    => $categoryStats,
                'popular_books'     => $popularBooks,
                'recent_logs'       => $recentLogs,
            ],
        ]);
    }

    /**
     * Menambah judul buku baru (Mendukung upload PDF fisik & Gambar Cover).
     */
    public function storeBook(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'category_id'   => 'required|exists:categories,id',
            'judul'         => 'required|string|max:255',
            'penulis'       => 'required|string|max:150',
            'penerbit'      => 'nullable|string|max:150',
            'jenjang'       => 'required|string|max:100',
            'tingkat_kelas' => 'nullable|integer|min:1|max:6',
            'deskripsi'     => 'nullable|string',
            'cover_path'    => 'nullable|string',
            'file_path'     => 'nullable|string',
            'cover_file'    => 'nullable|file|image|max:10240',
            'pdf_file'      => 'nullable|file|mimes:pdf|max:51200',
            'total_halaman' => 'nullable|integer|min:1',
            'rating'        => 'nullable|numeric|min:1|max:5',
        ]);

        // Handle upload file PDF fisik jika dilampirkan
        if ($request->hasFile('pdf_file')) {
            $pdfPath = $request->file('pdf_file')->store('books', 'public');
            $validated['file_path'] = $pdfPath;
        }

        // Handle upload file gambar cover jika dilampirkan
        if ($request->hasFile('cover_file')) {
            $coverPath = $request->file('cover_file')->store('covers', 'public');
            $validated['cover_path'] = asset('storage/' . $coverPath);
        }

        $slug = Str::slug($validated['judul']) . '-' . Str::random(5);

        $book = Book::create(array_merge($validated, [
            'slug' => $slug,
            'penerbit' => $validated['penerbit'] ?? 'Pusat Perbukuan Kemendikdasmen',
            'is_active' => true,
        ]));

        return response()->json([
            'status' => 'success',
            'message' => 'Buku baru berhasil ditambahkan beserta file PDF',
            'data' => $book->load('category'),
        ], 201);
    }

    /**
     * Memperbarui data buku & opsi unggah ulang PDF/Cover.
     */
    public function updateBook(Request $request, int $id): JsonResponse
    {
        $book = Book::find($id);

        if (!$book) {
            return response()->json([
                'status' => 'error',
                'message' => 'Buku tidak ditemukan',
            ], 404);
        }

        $validated = $request->validate([
            'category_id'   => 'sometimes|required|exists:categories,id',
            'judul'         => 'sometimes|required|string|max:255',
            'penulis'       => 'sometimes|required|string|max:150',
            'penerbit'      => 'nullable|string|max:150',
            'jenjang'       => 'sometimes|required|string|max:100',
            'tingkat_kelas' => 'nullable|integer|min:1|max:6',
            'deskripsi'     => 'nullable|string',
            'cover_path'    => 'nullable|string',
            'file_path'     => 'nullable|string',
            'cover_file'    => 'nullable|file|image|max:10240',
            'pdf_file'      => 'nullable|file|mimes:pdf|max:51200',
            'total_halaman' => 'nullable|integer|min:1',
            'rating'        => 'nullable|numeric|min:1|max:5',
            'is_active'     => 'nullable|boolean',
        ]);

        if ($request->hasFile('pdf_file')) {
            $pdfPath = $request->file('pdf_file')->store('books', 'public');
            $validated['file_path'] = $pdfPath;
        }

        if ($request->hasFile('cover_file')) {
            $coverPath = $request->file('cover_file')->store('covers', 'public');
            $validated['cover_path'] = asset('storage/' . $coverPath);
        }

        $book->update($validated);

        return response()->json([
            'status' => 'success',
            'message' => 'Data buku berhasil diperbarui',
            'data' => $book->fresh()->load('category'),
        ]);
    }

    /**
     * Menghapus buku.
     */
    public function destroyBook(int $id): JsonResponse
    {
        $book = Book::find($id);

        if (!$book) {
            return response()->json([
                'status' => 'error',
                'message' => 'Buku tidak ditemukan',
            ], 404);
        }

        $book->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Buku berhasil dihapus',
        ]);
    }

    /*
    |--------------------------------------------------------------------------
    | User Management APIs
    |--------------------------------------------------------------------------
    */

    public function users(Request $request): JsonResponse
    {
        $query = User::withCount('readingLogs');

        if ($request->filled('role') && $request->role !== 'all') {
            $query->where('role', $request->role);
        }

        if ($request->filled('search')) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('name', 'like', "%{$search}%")
                  ->orWhere('email', 'like', "%{$search}%")
                  ->orWhere('kelas', 'like', "%{$search}%");
            });
        }

        $users = $query->orderBy('created_at', 'desc')->get();

        return response()->json([
            'status' => 'success',
            'data'   => $users,
        ]);
    }

    public function showUser(int $id): JsonResponse
    {
        $user = User::withCount('readingLogs')
            ->with(['readingLogs' => function ($q) {
                $q->with('book:id,judul,slug,cover_path')
                  ->orderBy('read_at', 'desc')
                  ->limit(10);
            }])
            ->find($id);

        if (!$user) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Pengguna tidak ditemukan',
            ], 404);
        }

        return response()->json([
            'status' => 'success',
            'data'   => $user,
        ]);
    }

        /**
     * Sanitasi kelas untuk guru: jika kosong atau bernilai "none"/"tidak ada", kembalikan null.
     * Jika format valid (misal "4A" atau "Kelas 4A"), kembalikan "Kelas 4A".
     */
    protected function sanitizeGuruKelas(?string $raw): ?string
    {
        if (!$raw) return null;
        $trimmed = trim($raw);
        $lower = strtolower($trimmed);
        if (in_array($lower, ['none', 'tidak ada', 'belum ditugaskan', '-', 'null', ''])) {
            return null;
        }
        $cleanCode = strtoupper(trim(preg_replace('/^Kelas\s+/i', '', $trimmed)));
        return "Kelas {$cleanCode}";
    }

    /**
     * Sanitasi kelas untuk siswa.
     */
    protected function sanitizeSiswaKelas(?string $raw): ?string
    {
        if (!$raw) return null;
        $trimmed = trim($raw);
        $lower = strtolower($trimmed);
        if (in_array($lower, ['none', 'tidak ada', 'belum ditugaskan', '-', 'null', ''])) {
            return null;
        }
        $cleanCode = strtoupper(trim(preg_replace('/^Kelas\s+/i', '', $trimmed)));
        return "Kelas {$cleanCode}";
    }

    /**
     * Cek apakah kelas sudah memiliki wali kelas guru lain.
     */
    protected function checkWaliKelasConflict(string $kelas, ?int $excludeUserId = null): ?User
    {
        $cleanCode = strtoupper(trim(preg_replace('/^Kelas\s+/i', '', $kelas)));
        $variants = [
            $cleanCode,
            "Kelas {$cleanCode}",
            strtolower($cleanCode),
            "kelas {$cleanCode}",
        ];

        $query = User::where('role', 'guru')
            ->where(function ($q) use ($variants) {
                $q->whereIn('kelas', $variants);
            });

        if ($excludeUserId) {
            $query->where('id', '!=', $excludeUserId);
        }

        return $query->first();
    }

    public function storeUser(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'name'     => 'required|string|max:150',
            'email'    => 'required|email|unique:users,email',
            'password' => 'nullable|string|min:6',
            'role'     => 'required|in:admin,guru,siswa',
            'kelas'    => 'nullable|string|max:50',
        ]);

        $role = $validated['role'];
        $kelas = $validated['kelas'] ?? null;

        // Normalisasi dan validasi kelas untuk Guru, Siswa, dan Admin
        if ($role === 'admin') {
            $kelas = null;
        } elseif ($role === 'guru') {
            $kelas = $this->sanitizeGuruKelas($kelas);
            if ($kelas) {
                $conflict = $this->checkWaliKelasConflict($kelas);
                if ($conflict) {
                    return response()->json([
                        'status'  => 'error',
                        'message' => "{$kelas} sudah memiliki wali kelas atas nama \"{$conflict->name}\". Setiap kelas hanya berhak memiliki satu wali kelas.",
                    ], 422);
                }
            }
        } elseif ($role === 'siswa') {
            $kelas = $this->sanitizeSiswaKelas($kelas);
        }

        $tempPassword = !empty($validated['password']) 
            ? $validated['password'] 
            : 'Perpus' . rand(10000, 99999);

        $user = User::create([
            'name'     => $validated['name'],
            'email'    => $validated['email'],
            'password' => Hash::make($tempPassword),
            'role'     => $role,
            'kelas'    => $kelas,
        ]);

        $userData = $user->toArray();
        $userData['generated_password'] = empty($validated['password']) ? $tempPassword : null;

        return response()->json([
            'status'  => 'success',
            'message' => 'Pengguna baru berhasil ditambahkan',
            'data'    => $userData,
        ], 201);
    }

    public function resetUserPassword(int $id): JsonResponse
    {
        $user = User::find($id);

        if (!$user) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Pengguna tidak ditemukan',
            ], 404);
        }

        $tempPassword = 'Siswa' . rand(10000, 99999);
        $user->password = Hash::make($tempPassword);
        $user->save();

        return response()->json([
            'status'  => 'success',
            'message' => 'Kata sandi pengguna ' . $user->name . ' berhasil direset secara otomatis.',
            'data'    => [
                'user_id'            => $user->id,
                'name'               => $user->name,
                'email'              => $user->email,
                'temporary_password' => $tempPassword,
            ]
        ]);
    }

        public function updateUser(Request $request, int $id): JsonResponse
    {
        $user = User::find($id);

        if (!$user) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Pengguna tidak ditemukan',
            ], 404);
        }

        $validated = $request->validate([
            'name'        => 'sometimes|required|string|max:150',
            'role'        => 'sometimes|required|in:admin,guru,siswa',
            'kelas'       => 'nullable|string|max:50',
            'password'    => 'nullable|string|min:6',
            'avatar_file' => 'nullable|file|image|max:5120',
            'avatar'      => 'nullable|string',
        ]);

        $effectiveRole = $validated['role'] ?? $user->role;

        if ($request->has('kelas') || isset($validated['role'])) {
            $rawKelas = $request->input('kelas', $user->kelas);

            if ($effectiveRole === 'admin') {
                $validated['kelas'] = null;
            } elseif ($effectiveRole === 'guru') {
                $kelas = $this->sanitizeGuruKelas($rawKelas);
                if ($kelas) {
                    $conflict = $this->checkWaliKelasConflict($kelas, $user->id);
                    if ($conflict) {
                        return response()->json([
                            'status'  => 'error',
                            'message' => "{$kelas} sudah memiliki wali kelas atas nama \"{$conflict->name}\". Setiap kelas hanya berhak memiliki satu wali kelas.",
                        ], 422);
                    }
                }
                $validated['kelas'] = $kelas;
            } elseif ($effectiveRole === 'siswa') {
                $validated['kelas'] = $this->sanitizeSiswaKelas($rawKelas);
            }
        }

        if ($request->hasFile('avatar_file')) {
            $path = $request->file('avatar_file')->store('avatars', 'public');
            $validated['avatar'] = asset('storage/' . $path);
        } elseif ($request->filled('avatar')) {
            $validated['avatar'] = $request->avatar;
        }

        if (!empty($validated['password'])) {
            $validated['password'] = Hash::make($validated['password']);
        } else {
            unset($validated['password']);
        }

        // Jangan izinkan modifikasi email demi menjaga keamanan akun
        unset($validated['email']);

        $user->update($validated);

        return response()->json([
            'status'  => 'success',
            'message' => 'Data pengguna berhasil diperbarui',
            'data'    => $user->fresh(),
        ]);
    }

    public function destroyUser(int $id): JsonResponse
    {
        $user = User::find($id);

        if (!$user) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Pengguna tidak ditemukan',
            ], 404);
        }

        if ($user->email === 'admin@digilibrary.sch.id') {
            return response()->json([
                'status'  => 'error',
                'message' => 'Akun admin utama tidak boleh dihapus.',
            ], 403);
        }

        $user->delete();

        return response()->json([
            'status'  => 'success',
            'message' => 'Pengguna berhasil dihapus',
        ]);
    }
}