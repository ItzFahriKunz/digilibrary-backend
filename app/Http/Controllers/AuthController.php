<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;

class AuthController extends Controller
{
    /**
     * Handle Google Login / Register via Firebase ID Token
     */
    public function googleLogin(Request $request)
    {
        $request->validate([
            'token' => 'required|string',
        ]);

        $idToken = $request->input('token');
        $email = null;
        $name = null;
        $avatar = null;
        $firebaseUid = null;

        try {
            // 1. Verifikasi ID Token via Google OAuth / Firebase endpoint
            $response = Http::get("https://oauth2.googleapis.com/tokeninfo?id_token={$idToken}");

            if ($response->successful()) {
                $payload = $response->json();
                $email = $payload['email'] ?? null;
                $name = $payload['name'] ?? ($payload['email'] ?? 'Google User');
                $avatar = $payload['picture'] ?? null;
                $firebaseUid = $payload['sub'] ?? ($payload['user_id'] ?? null);
            } else {
                // Fallback: Decode JWT payload jika Google endpoint mengembalikan format khusus Firebase
                $parts = explode('.', $idToken);
                if (count($parts) === 3) {
                    $jwtPayload = json_decode(base64_decode(strtr($parts[1], '-_', '+/')), true);
                    if ($jwtPayload && isset($jwtPayload['email'])) {
                        $email = $jwtPayload['email'];
                        $name = $jwtPayload['name'] ?? explode('@', $email)[0];
                        $avatar = $jwtPayload['picture'] ?? null;
                        $firebaseUid = $jwtPayload['user_id'] ?? ($jwtPayload['sub'] ?? null);
                    }
                }
            }

            if (!$email) {
                return response()->json([
                    'status'  => 'error',
                    'message' => 'Token Firebase tidak valid atau tidak memuat email.',
                ], 401);
            }

            // 2. Simpan atau Update User di Database MySQL
            $user = User::updateOrCreate(
                ['email' => $email],
                [
                    'name'         => $name,
                    'firebase_uid' => $firebaseUid,
                    'avatar'       => $avatar,
                ]
            );

            // 3. Buat Sanctum API Token untuk sesi autentikasi Laravel
            $sanctumToken = $user->createToken('auth-token')->plainTextToken;

            return response()->json([
                'status'  => 'success',
                'message' => 'Login Google berhasil disimpan ke database!',
                'data'    => [
                    'user'  => $user,
                    'token' => $sanctumToken,
                ],
            ]);

        } catch (\Exception $e) {
            Log::error('Google Login Exception: ' . $e->getMessage());

            return response()->json([
                'status'  => 'error',
                'message' => 'Terjadi kesalahan pada server saat memproses login.',
                'error'   => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Get Current Authenticated User Info
     */
    public function me(Request $request)
    {
        return response()->json([
            'status' => 'success',
            'user'   => $request->user(),
        ]);
    }
}
