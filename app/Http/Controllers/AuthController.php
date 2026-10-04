<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\ReadingLog;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Password;
use Illuminate\Support\Facades\Mail;
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
        $idToken = $request->input('token') ?? $request->input('id_token');

        if (!$idToken) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Token autentikasi Google (token / id_token) wajib diisi.',
            ], 422);
        }

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
                $avatar = $payload['picture'] ?? $request->input('avatar') ?? null;
                $firebaseUid = $payload['sub'] ?? ($payload['user_id'] ?? null);
            } else {
                $parts = explode('.', $idToken);
                if (count($parts) === 3) {
                    $jwtPayload = json_decode(base64_decode(strtr($parts[1], '-_', '+/')), true);
                    if ($jwtPayload && isset($jwtPayload['email'])) {
                        $email = $jwtPayload['email'];
                        $name = $jwtPayload['name'] ?? explode('@', $email)[0];
                        $avatar = $jwtPayload['picture'] ?? $request->input('avatar') ?? null;
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

    /**
     * Update User Profile (Nama, Kelas, Avatar)
     */
    public function updateProfile(Request $request)
    {
        $user = $request->user();

        $request->validate([
            'name'   => 'required|string|max:150',
            'kelas'  => 'nullable|string|max:50',
            'nis'    => 'nullable|string|max:30',
            'nisn'   => 'nullable|string|max:30',
            'nip'    => 'nullable|string|max:30',
        ]);

        $avatarPath = $user->avatar;

        // Jika pengguna meminta menghapus foto profil (kembali ke inisial abjad)
        if ($request->input('remove_avatar') == '1' || $request->boolean('remove_avatar')) {
            if ($user->avatar && str_starts_with($user->avatar, '/storage/avatars/')) {
                $oldFile = str_replace('/storage/', '', $user->avatar);
                Storage::disk('public')->delete($oldFile);
            }
            $avatarPath = null;
        } elseif ($request->hasFile('avatar_file')) {
            $request->validate([
                'avatar_file' => 'image|mimes:jpeg,png,jpg,webp,gif|max:3072',
            ]);
            if ($user->avatar && str_starts_with($user->avatar, '/storage/avatars/')) {
                $oldFile = str_replace('/storage/', '', $user->avatar);
                Storage::disk('public')->delete($oldFile);
            }
            $path = $request->file('avatar_file')->store('avatars', 'public');
            $avatarPath = '/storage/' . $path;
        } elseif ($request->filled('avatar')) {
            // Jika memilih avatar preset string / URL
            $avatarPath = $request->avatar;
        }

        // KEAMANAN KETAT:
        // Role dan Kelas TIDAK BISA diubah sembarangan oleh user biasa melalui formulir profil!
        // Hak penugasan kelas dan penetapan wali kelas mutlak dipegang oleh Administrator melalui Panel Admin.
        $newKelas = $user->kelas;
        if ($user->role === 'admin') {
            $newKelas = null;
        }

        $updateData = [
            'name'   => $request->name,
            'kelas'  => $newKelas,
            'avatar' => $avatarPath,
        ];

        if ($request->has('nis')) {
            $updateData['nis'] = $request->input('nis') ? trim($request->input('nis')) : null;
        }
        if ($request->has('nisn')) {
            $updateData['nisn'] = $request->input('nisn') ? trim($request->input('nisn')) : null;
        }
        if ($request->has('nip')) {
            $updateData['nip'] = $request->input('nip') ? trim($request->input('nip')) : null;
        }

        $user->update($updateData);

        return response()->json([
            'status'  => 'success',
            'message' => 'Profil berhasil diperbarui!',
            'data'    => $user->fresh(),
        ]);
    }

    /**
     * Update Password Pengguna Terotentikasi
     */
    public function updatePassword(Request $request)
    {
        $user = $request->user();
        $hasPassword = !empty($user->password);

        if ($hasPassword) {
            $request->validate([
                'current_password'          => 'required|string',
                'new_password'              => 'required|string|min:6|confirmed',
            ]);

            if (!Hash::check($request->current_password, $user->password)) {
                return response()->json([
                    'status'  => 'error',
                    'message' => 'Kata sandi saat ini tidak sesuai.',
                ], 422);
            }
        } else {
            $request->validate([
                'new_password' => 'required|string|min:6|confirmed',
            ]);
        }

        $user->update([
            'password' => Hash::make($request->new_password),
        ]);

        return response()->json([
            'status'       => 'success',
            'message'      => $hasPassword ? 'Kata sandi berhasil diubah!' : 'Kata sandi berhasil dibuat! Sekarang Anda juga bisa masuk dengan email dan kata sandi.',
            'has_password' => true,
        ]);
    }

    /**
     * Request Token / Kode Lupa Password
     */
    public function forgotPassword(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
        ]);

        $user = User::where('email', $request->email)->first();

        if (!$user) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Akun dengan alamat email tersebut tidak ditemukan.',
            ], 404);
        }

        // Buat 6-digit kode OTP reset
        $token = strval(rand(100000, 999999));

        DB::table('password_reset_tokens')->updateOrInsert(
            ['email' => $request->email],
            [
                'token'      => $token,
                'created_at' => now(),
            ]
        );

        Log::info("Password reset OTP generated for {$request->email}. Code: {$token}");

        try {
            Mail::send('emails.reset-password-otp', [
                'user'  => $user,
                'token' => $token,
            ], function ($message) use ($user) {
                $message->to($user->email)
                        ->subject('Kode Verifikasi Reset Kata Sandi - Digilibrary');
            });
            Log::info("Email OTP reset password berhasil dikirim ke {$user->email}");
        } catch (\Throwable $th) {
            Log::error("Gagal kirim email OTP ke {$user->email}: " . $th->getMessage());
            return response()->json([
                'status'  => 'error',
                'message' => 'Gagal mengirim email: ' . $th->getMessage(),
            ], 500);
        }

        return response()->json([
            'status'     => 'success',
            'message'    => 'Kode verifikasi 6 digit telah dikirim ke email ' . $user->email . '. Silakan periksa kotak masuk atau folder Spam.',
        ]);
    }

        /**
     * Verifikasi Kode OTP Reset Password
     */
    public function verifyOtp(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'token' => 'required|string',
        ]);

        $record = DB::table('password_reset_tokens')
            ->where('email', $request->email)
            ->first();

        if (!$record || $record->token !== trim($request->token)) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Kode verifikasi salah atau tidak valid.',
            ], 422);
        }

        // Cek kedaluwarsa (60 menit)
        if (now()->diffInMinutes($record->created_at) > 60) {
            DB::table('password_reset_tokens')->where('email', $request->email)->delete();
            return response()->json([
                'status'  => 'error',
                'message' => 'Kode verifikasi telah kedaluwarsa. Silakan minta kode baru.',
            ], 422);
        }

        return response()->json([
            'status'  => 'success',
            'message' => 'Kode verifikasi valid! Silakan atur kata sandi baru Anda.',
        ]);
    }

    /**
     * Reset Password Menggunakan Token / Kode OTP
     */
    public function resetPassword(Request $request)
    {
        $request->validate([
            'email'                 => 'required|email',
            'token'                 => 'required|string',
            'password'              => 'required|string|min:6|confirmed',
        ]);

        $record = DB::table('password_reset_tokens')
            ->where('email', $request->email)
            ->first();

        if (!$record || $record->token !== trim($request->token)) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Kode verifikasi tidak valid atau salah.',
            ], 422);
        }

        // Cek kedaluwarsa (60 menit)
        if (now()->diffInMinutes($record->created_at) > 60) {
            DB::table('password_reset_tokens')->where('email', $request->email)->delete();
            return response()->json([
                'status'  => 'error',
                'message' => 'Kode verifikasi telah kedaluwarsa. Silakan minta kode baru.',
            ], 422);
        }

        $user = User::where('email', $request->email)->first();

        if (!$user) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Pengguna tidak ditemukan.',
            ], 404);
        }

        $user->update([
            'password' => Hash::make($request->password),
        ]);

        // Hapus token yang telah digunakan
        DB::table('password_reset_tokens')->where('email', $request->email)->delete();

        return response()->json([
            'status'  => 'success',
            'message' => 'Kata sandi berhasil diperbarui! Silakan masuk dengan kata sandi baru Anda.',
        ]);
    }
}
