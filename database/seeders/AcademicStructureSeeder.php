<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\TahunAjaran;
use App\Models\Kelas;
use App\Models\SiswaKelas;
use App\Models\WaliKelas;
use App\Models\User;
use App\Models\Book;

class AcademicStructureSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // 1. Inisialisasi Tahun Ajaran Aktif
        $tahunAjaran = TahunAjaran::firstOrCreate(
            ['label' => '2025/2026'],
            [
                'tanggal_mulai'   => '2025-07-15',
                'tanggal_selesai' => '2026-06-25',
                'status'          => 'aktif',
            ]
        );

        // 2. Inisialisasi 24 Rombel SD Standar (1A - 6D)
        $rombelLetters = ['A', 'B', 'C', 'D'];
        $kelasMap = [];

        for ($tingkat = 1; $tingkat <= 6; $tingkat++) {
            foreach ($rombelLetters as $letter) {
                $code = "{$tingkat}{$letter}";
                $kelasObj = Kelas::firstOrCreate(
                    [
                        'tingkat'         => $tingkat,
                        'nama_rombel'     => $code,
                        'tahun_ajaran_id' => $tahunAjaran->id,
                    ]
                );
                $kelasMap[$code] = $kelasObj;
                $kelasMap["Kelas {$code}"] = $kelasObj;
                $kelasMap[strtolower($code)] = $kelasObj;
                $kelasMap[strtolower("Kelas {$code}")] = $kelasObj;
            }
        }

        // Helper normalisasi string kelas
        $normalize = function ($str) {
            if (!$str) return null;
            $s = trim(str_ireplace('kelas', '', $str));
            $s = preg_replace('/\s+/', '', $s);
            return strtoupper($s);
        };

        // 3. Migrasikan / Sinkronkan Data Guru ke Wali Kelas
        $teachers = User::where('role', 'guru')->get();
        $nipCounter = 198205122008011001;

        foreach ($teachers as $teacher) {
            if (empty($teacher->nip)) {
                $teacher->nip = (string) $nipCounter++;
                $teacher->save();
            }

            $cleanCode = $normalize($teacher->kelas);
            if ($cleanCode && isset($kelasMap[$cleanCode])) {
                $targetKelas = $kelasMap[$cleanCode];

                WaliKelas::updateOrCreate(
                    [
                        'kelas_id'        => $targetKelas->id,
                        'tahun_ajaran_id' => $tahunAjaran->id,
                    ],
                    [
                        'user_id' => $teacher->id,
                    ]
                );
            }
        }

        // 4. Migrasikan / Sinkronkan Data Siswa ke Siswa Kelas
        $students = User::where('role', 'siswa')->get();
        $nisCounter = 20250001;

        foreach ($students as $student) {
            if (empty($student->nis)) {
                $student->nis = (string) ($nisCounter + $student->id);
                $student->save();
            }

            $cleanCode = $normalize($student->kelas);
            if ($cleanCode && isset($kelasMap[$cleanCode])) {
                $targetKelas = $kelasMap[$cleanCode];

                SiswaKelas::updateOrCreate(
                    [
                        'user_id'         => $student->id,
                        'tahun_ajaran_id' => $tahunAjaran->id,
                    ],
                    [
                        'kelas_id' => $targetKelas->id,
                        'status'   => 'aktif',
                    ]
                );
            }
        }

        // 5. Kaitkan buku yang belum memiliki uploaded_by ke Admin pertama
        $firstAdmin = User::where('role', 'admin')->first();
        if ($firstAdmin) {
            Book::whereNull('uploaded_by')->update([
                'uploaded_by' => $firstAdmin->id,
            ]);
        }
    }
}
