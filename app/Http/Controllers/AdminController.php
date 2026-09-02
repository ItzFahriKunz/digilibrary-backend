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

        // 2. Tren Aktivitas Membaca 7 Hari Terakhir
        $dailyTrend = [];
        $dayNames = ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab'];
        for ($i = 6; $i >= 0; $i--) {
            $date = Carbon::today()->subDays($i);
            $dayOfWeek = $dayNames[$date->dayOfWeek];
            $count = ReadingLog::whereDate('read_at', $date)->count();
            
            $dailyTrend[] = [
                'day'       => $dayOfWeek,
                'date'      => $date->format('d M'),
                'count'     => $count,
                'is_today'  => $i === 0,
            ];
        }

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

    public function storeUser(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'name'     => 'required|string|max:150',
            'email'    => 'required|email|unique:users,email',
            'password' => 'required|string|min:6',
            'role'     => 'required|in:admin,guru,siswa',
            'kelas'    => 'nullable|string|max:50',
        ]);

        $user = User::create([
            'name'     => $validated['name'],
            'email'    => $validated['email'],
            'password' => Hash::make($validated['password']),
            'role'     => $validated['role'],
            'kelas'    => $validated['kelas'] ?? null,
        ]);

        return response()->json([
            'status'  => 'success',
            'message' => 'Pengguna baru berhasil ditambahkan',
            'data'    => $user,
        ], 201);
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
            'name'     => 'sometimes|required|string|max:150',
            'email'    => 'sometimes|required|email|unique:users,email,' . $id,
            'role'     => 'sometimes|required|in:admin,guru,siswa',
            'kelas'    => 'nullable|string|max:50',
            'password' => 'nullable|string|min:6',
        ]);

        if (!empty($validated['password'])) {
            $validated['password'] = Hash::make($validated['password']);
        } else {
            unset($validated['password']);
        }

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