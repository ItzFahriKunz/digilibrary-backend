<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\AuthController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\BookController;
use App\Http\Controllers\AdminController;

/*
|--------------------------------------------------------------------------
| Public Routes (Katalog, Autentikasi & Pembaca)
|--------------------------------------------------------------------------
*/

// Auth (Public)
Route::post('/auth/login', [AuthController::class, 'login']);
Route::post('/auth/register', [AuthController::class, 'register']);
Route::post('/auth/google', [AuthController::class, 'googleLogin']);

// Kategori Buku SIBI
Route::get('/categories', [CategoryController::class, 'index']);
Route::get('/categories/{slug}', [CategoryController::class, 'show']);

// Katalog Buku E-Book
Route::get('/books', [BookController::class, 'index']);
Route::get('/books/{slug}', [BookController::class, 'show']);
Route::post('/books/{id}/track-read', [BookController::class, 'trackRead']);
Route::get('/books/{id}/stream', [BookController::class, 'stream']);

// Dashboard Statistik & Manajemen Admin
Route::get('/admin/stats', [AdminController::class, 'stats']);
Route::post('/admin/books', [AdminController::class, 'storeBook']);
Route::put('/admin/books/{id}', [AdminController::class, 'updateBook']);
Route::delete('/admin/books/{id}', [AdminController::class, 'destroyBook']);

// Manajemen Pengguna (Admin)
Route::get('/admin/users', [AdminController::class, 'users']);
Route::post('/admin/users', [AdminController::class, 'storeUser']);
Route::put('/admin/users/{id}', [AdminController::class, 'updateUser']);
Route::delete('/admin/users/{id}', [AdminController::class, 'destroyUser']);

/*
|--------------------------------------------------------------------------
| Protected Sanctum Routes
|--------------------------------------------------------------------------
*/
Route::middleware('auth:sanctum')->group(function () {
    Route::get('/auth/me', [AuthController::class, 'me']);
    Route::post('/auth/logout', [AuthController::class, 'logout']);
    Route::put('/auth/complete-profile', [AuthController::class, 'completeProfile']);
    Route::get('/user/reading-history', [AuthController::class, 'readingHistory']);
    Route::get('/user', function (Request $request) {
        return $request->user();
    });
});