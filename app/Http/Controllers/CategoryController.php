<?php

namespace App\Http\Controllers;

use App\Models\Category;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class CategoryController extends Controller
{
    /**
     * Mengambil seluruh kategori (opsional filter tipe: pelajaran / bacaan).
     */
    public function index(Request $request): JsonResponse
    {
        $query = Category::withCount('books');

        if ($request->has('tipe') && in_array($request->tipe, ['pelajaran', 'bacaan'])) {
            $query->where('tipe', $request->tipe);
        }

        $categories = $query->orderBy('nama')->get();

        return response()->json([
            'status' => 'success',
            'message' => 'Daftar kategori berhasil diambil',
            'data' => $categories,
        ]);
    }

    /**
     * Detail kategori beserta daftar bukunya.
     */
    public function show(string $slug): JsonResponse
    {
        $category = Category::where('slug', $slug)
            ->with(['books' => function ($q) {
                $q->where('is_active', true)->orderBy('judul');
            }])
            ->first();

        if (!$category) {
            return response()->json([
                'status' => 'error',
                'message' => 'Kategori tidak ditemukan',
            ], 404);
        }

        return response()->json([
            'status' => 'success',
            'message' => 'Detail kategori berhasil diambil',
            'data' => $category,
        ]);
    }
}