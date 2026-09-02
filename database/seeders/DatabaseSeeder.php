<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // 1. Akun Admin Perpustakaan
        User::updateOrCreate(
            ['email' => 'admin@digilibrary.sch.id'],
            [
                'name' => 'Admin Perpustakaan',
                'password' => Hash::make('admin123'),
                'role' => 'admin',
                'kelas' => null,
                'firebase_uid' => null,
                'avatar' => null,
            ]
        );

        // 2. Akun Guru SD
        User::updateOrCreate(
            ['email' => 'guru@digilibrary.sch.id'],
            [
                'name' => 'Ibu Sari (Guru Kelas 4)',
                'password' => Hash::make('guru123'),
                'role' => 'guru',
                'kelas' => 'Kelas 4',
                'firebase_uid' => null,
                'avatar' => null,
            ]
        );

        // 3. Akun Siswa SD
        User::updateOrCreate(
            ['email' => 'siswa@digilibrary.sch.id'],
            [
                'name' => 'Budi Santoso',
                'password' => Hash::make('siswa123'),
                'role' => 'siswa',
                'kelas' => 'Kelas 4',
                'firebase_uid' => null,
                'avatar' => null,
            ]
        );

        // Panggil seeder kategori & buku resmi SIBI Kemendikdasmen
        $this->call([
            CategorySeeder::class,
            BookSeeder::class,
            ReadingLogSeeder::class,
        ]);
    }
}