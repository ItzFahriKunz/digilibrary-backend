<?php

namespace App\Http\Controllers;

use App\Models\Book;
use App\Models\ReadingLog;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class BookController extends Controller
{
    /**
     * Mengambil daftar katalog buku dengan filter pencarian & kategori.
     */
    public function index(Request $request): JsonResponse
    {
        $query = Book::with('category')->where('is_active', true);

        // Filter Kategori
        if ($request->filled('category_slug')) {
            $query->whereHas('category', function ($q) use ($request) {
                $q->where('slug', $request->category_slug);
            });
        } elseif ($request->filled('category_id')) {
            $query->where('category_id', $request->category_id);
        }

        // Filter Tipe Kategori (pelajaran / bacaan)
        if ($request->filled('tipe') && in_array($request->tipe, ['pelajaran', 'bacaan'])) {
            $query->whereHas('category', function ($q) use ($request) {
                $q->where('tipe', $request->tipe);
            });
        }

        // Filter Tingkat Kelas (1 s.d. 6)
        if ($request->filled('tingkat_kelas')) {
            $query->where('tingkat_kelas', $request->tingkat_kelas);
        }

        // Search Keyword
        if ($request->filled('search')) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('judul', 'like', "%{$search}%")
                  ->orWhere('penulis', 'like', "%{$search}%")
                  ->orWhere('deskripsi', 'like', "%{$search}%");
            });
        }

        // Sorting
        $sortBy = $request->get('sort_by', 'created_at');
        $sortOrder = $request->get('sort_order', 'desc');
        if (in_array($sortBy, ['created_at', 'total_dibaca', 'rating', 'judul'])) {
            $query->orderBy($sortBy, $sortOrder === 'asc' ? 'asc' : 'desc');
        }

        $perPage = $request->get('per_page', 24);
        $books = $query->paginate($perPage);

        return response()->json([
            'status' => 'success',
            'message' => 'Katalog buku berhasil diambil',
            'data' => $books,
        ]);
    }

    /**
     * Mengambil detail buku berdasarkan slug.
     */
    public function show(string $slug): JsonResponse
    {
        $book = Book::with('category')->where(function($q) use ($slug) {
            $q->where('id', $slug)->orWhere('slug', $slug);
        })->first();

        if (!$book) {
            return response()->json([
                'status' => 'error',
                'message' => 'Buku tidak ditemukan',
            ], 404);
        }

        return response()->json([
            'status' => 'success',
            'message' => 'Detail buku berhasil diambil',
            'data' => $book,
        ]);
    }

    /**
     * Mencatat statistik bacaan siswa (Realtime tracking untuk log & dashboard).
     */
    public function trackRead(Request $request, int $id): JsonResponse
    {
        $book = Book::find($id);

        if (!$book) {
            return response()->json([
                'status' => 'error',
                'message' => 'Buku tidak ditemukan',
            ], 404);
        }

        $user = $request->user('sanctum') ?? auth('sanctum')->user();
        $userId = $user ? $user->id : null;
        $logId = $request->input('log_id');
        // Mendukung penamaan field bahasa Indonesia (durasi_detik/halaman_terakhir) maupun Inggris (duration_seconds/page_number)
        $durasiDetik = (int) ($request->input('durasi_detik') ?? $request->input('duration_seconds') ?? 0);
        $halamanTerakhir = (int) ($request->input('halaman_terakhir') ?? $request->input('page_number') ?? 1);
        $platform = in_array($request->platform, ['web', 'mobile']) ? $request->platform : 'web';

        $log = null;

        // 1. Cek jika log_id dikirimkan dan log tersebut valid
        if ($logId) {
            $log = ReadingLog::where('id', $logId)
                ->where('book_id', $book->id)
                ->when($userId, fn($q) => $q->where('user_id', $userId))
                ->first();
        }

        // 2. Fallback: jika log_id belum ada / tidak terkirim, cek apakah user membaca buku yang sama dalam 30 menit terakhir
        if (!$log && $userId) {
            $log = ReadingLog::where('user_id', $userId)
                ->where('book_id', $book->id)
                ->where('read_at', '>=', now()->subMinutes(30))
                ->orderBy('id', 'desc')
                ->first();
        }

        if ($log) {
            // Perbarui sesi berjalan: jangan buat baris baru, jangan gandakan sesi, jangan re-increment total_dibaca
            $log->durasi_detik = max((int) $log->durasi_detik, $durasiDetik);
            if ($halamanTerakhir > 0) {
                $log->halaman_terakhir = $halamanTerakhir;
            }
            $log->read_at = now();
            $log->save();
        } else {
            // Sesi baru: baru kita buat baris log dan increment total_dibaca buku
            $book->increment('total_dibaca');

            $log = ReadingLog::create([
                'user_id' => $userId,
                'book_id' => $book->id,
                'platform' => $platform,
                'halaman_terakhir' => $halamanTerakhir,
                'durasi_detik' => $durasiDetik,
                'read_at' => now(),
            ]);
        }

        return response()->json([
            'status' => 'success',
            'message' => 'Sesi membaca berhasil dicatat',
            'data' => [
                'total_dibaca' => $book->fresh()->total_dibaca,
                'log_id' => $log->id,
            ],
        ]);
    }

    /**
     * Streaming file PDF terproteksi.
     */
    public function stream(int $id)
    {
        $book = Book::find($id);

        if (!$book || !$book->file_path) {
            return response()->json([
                'status' => 'error',
                'message' => 'File PDF belum ditentukan',
            ], 404);
        }

        // Cek path storage public
        $publicPath = storage_path('app/public/' . $book->file_path);
        $appPath = storage_path('app/' . $book->file_path);

        $targetPath = file_exists($publicPath) ? $publicPath : (file_exists($appPath) ? $appPath : null);

        if (!$targetPath) {
            return response()->json([
                'status' => 'error',
                'message' => 'File fisik PDF belum tersedia di server storage',
                'file_path' => $book->file_path,
            ], 404);
        }

        return response()->file($targetPath, [
            'Content-Type' => 'application/pdf',
            'Content-Disposition' => 'inline; filename="' . $book->slug . '.pdf"',
            'Accept-Ranges' => 'bytes',
        ]);
    }
}