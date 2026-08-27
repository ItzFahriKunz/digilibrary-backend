<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\AuthController;

// Endpoint Google Auth via Firebase ID Token
Route::post('/auth/google', [AuthController::class, 'googleLogin']);

// Endpoint Protected untuk ambil data user saat ini
Route::middleware('auth:sanctum')->group(function () {
    Route::get('/auth/me', [AuthController::class, 'me']);
    Route::get('/user', function (Request $request) {
        return $request->user();
    });
});


