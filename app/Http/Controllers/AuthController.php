<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\ReadingLog;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;

class AuthController extends Controller
{
    /**
     * Handle Email & Password Login
     */
    public function login(Request $request)
    {
        $request->validate([
            'email'    => 'required|email',
            'password' => 'required|string',
        ]);

        $user = User::where('email', $request->email)->first();

        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Email atau kata sandi salah.',
            ], 401);
        }

        $sanctumToken = $user->createToken('auth-token')->plainTextToken;

        return response()->json([
            'status'  => 'success',
            'message' => 'Login berhasil!',
            'data'    => [
                'user'              => $user,
                'token'             => $sanctumToken,
                'is_profile_complete' => $user->isProfileComplete(),
            ],
        ]);
    }

    /**
     * Handle User Registration
     */
    public function register(Request $request)
    {
        $request->validate([
            'name'     => 'required|string|max:150',
            'email'    => 'required|email|unique:users,email',
            'password' => 'required|string|min:6',
        ]);

        $user = User::create([
            'name'     => $request->name,
            'email'    => $request->email,
            'password' => Hash::make($request->password),
            'role'     => 'siswa',
        ]);

        $sanctumToken = $user->createToken('auth-token')->plainTextToken;

        return response()->json([
            'status'  => 'success',
            'message' => 'Pendaftaran akun berhasil!',
            'data'    => [
                'user'              => $user,
                'token'             => $sanctumToken,
                'is_profile_complete' => false,
            ],
        ], 201);
    }

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
            $response = Http::get("https://oauth2.googleapis.com/tokeninfo?id_token={$idToken}");

            if ($response->successful()) {
                $payload = $response->json();
                $email = $payload['email'] ?? null;
                $name = $payload['name'] ?? ($payload['email'] ?? 'Google User');
                $avatar = $payload['picture'] ?? null;
                $firebaseUid = $payload['sub'] ?? ($payload['user_id'] ?? null);
            } else {
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

            $user = User::updateOrCreate(
                ['email' => $email],
                [
                    'name'         => $name,
                    'firebase_uid' => $firebaseUid,
                    'avatar'       => $avatar,
                ]
            );

            $sanctumToken = $user->createToken('auth-token')->plainTextToken;

            return response()->json([
                'status'  => 'success',
                'message' => 'Login Google berhasil!',
                'data'    => [
                    'user'              => $user,
                    'token'             => $sanctumToken,
                    'is_profile_complete' => $user->isProfileComplete(),
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
     * Lengkapi Profil Pengguna (Nama + Kelas)
     */
    public function completeProfile(Request $request)
    {
        $request->validate([
            'name'  => 'required|string|max:150',
            'kelas' => 'nullable|string|max:50',
        ]);

        $user = $request->user();
        $user->update([
            'name'  => $request->name,
            'kelas' => $request->kelas,
        ]);

        return response()->json([
            'status'  => 'success',
            'message' => 'Profil berhasil dilengkapi!',
            'data'    => $user->fresh(),
        ]);
    }

    /**
     * Riwayat Baca User
     */
    public function readingHistory(Request $request)
    {
        $logs = ReadingLog::with('book:id,judul,slug,cover_path,file_path,penulis,jenjang,total_halaman')
            ->where('user_id', $request->user()->id)
            ->orderBy('read_at', 'desc')
            ->limit(20)
            ->get();

        return response()->json([
            'status' => 'success',
            'data'   => $logs,
        ]);
    }

    /**
     * Get Current Authenticated User Info
     */
    public function me(Request $request)
    {
        $user = $request->user();

        return response()->json([
            'status' => 'success',
            'data'   => [
                'user'              => $user,
                'is_profile_complete' => $user->isProfileComplete(),
            ],
        ]);
    }

    /**
     * Logout & Revoke Tokens
     */
    public function logout(Request $request)
    {
        if ($request->user()) {
            $request->user()->currentAccessToken()->delete();
        }

        return response()->json([
            'status'  => 'success',
            'message' => 'Berhasil keluar akun.',
        ]);
    }
}
