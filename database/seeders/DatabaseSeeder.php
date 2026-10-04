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
                'nip' => '198001012005011001',
                'kelas' => null,
                'firebase_uid' => null,
                'avatar' => null,
            ]
        );

        // 2. Akun Guru SD (Wali Kelas 1A)
        User::updateOrCreate(
            ['email' => 'guru@digilibrary.sch.id'],
            [
                'name' => 'Ibu Sari, S.Pd.',
                'password' => Hash::make('guru123'),
                'role' => 'guru',
                'nip' => '198505122010012003',
                'kelas' => 'Kelas 1A',
                'firebase_uid' => null,
                'avatar' => null,
            ]
        );

        // 3. Akun Siswa SD (Kelas 1A)
        User::updateOrCreate(
            ['email' => 'siswa@digilibrary.sch.id'],
            [
                'name' => 'Budi Santoso',
                'password' => Hash::make('siswa123'),
                'role' => 'siswa',
                'nis' => '20250001',
                'kelas' => 'Kelas 1A',
                'firebase_uid' => null,
                'avatar' => null,
            ]
        );

        // Siswa tambahan kelas 1A untuk uji coba
        User::updateOrCreate(
            ['email' => 'siti@digilibrary.sch.id'],
            [
                'name' => 'Siti Rahma',
                'password' => Hash::make('siswa123'),
                'role' => 'siswa',
                'nis' => '20250002',
                'kelas' => 'Kelas 1A',
                'firebase_uid' => null,
                'avatar' => null,
            ]
        );

        User::updateOrCreate(
            ['email' => 'edo@digilibrary.sch.id'],
            [
                'name' => 'Edo Pratama',
                'password' => Hash::make('siswa123'),
                'role' => 'siswa',
                'nis' => '20250003',
                'kelas' => 'Kelas 1A',
                'firebase_uid' => null,
                'avatar' => null,
            ]
        );

        // Panggil seeder master kategori dan struktur akademik
        $this->call([
            CategorySeeder::class,
            AcademicStructureSeeder::class,
        ]);
    }
}
