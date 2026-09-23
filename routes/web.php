<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes (API Server Status)
|--------------------------------------------------------------------------
*/

Route::get('/', function () {
    return response()->json([
        'app' => 'Digilibrary SD API Server',
        'status' => 'online',
        'timestamp' => now()->toIso8601String(),
    ]);
});
