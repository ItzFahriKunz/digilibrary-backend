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

        $book->increment('total_dibaca');

        $user = $request->user('sanctum') ?? auth('sanctum')->user();
        $log = ReadingLog::create([
            'user_id' => $user ? $user->id : null,
            'book_id' => $book->id,
            'platform' => in_array($request->platform, ['web', 'mobile']) ? $request->platform : 'web',
            'halaman_terakhir' => $request->get('halaman_terakhir', 1),
            'durasi_detik' => $request->get('durasi_detik', 0),
            'read_at' => now(),
        ]);

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