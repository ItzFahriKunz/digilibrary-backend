<?php

namespace Database\Seeders;

use App\Models\Category;
use Illuminate\Database\Seeder;

class CategorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $categories = [
            [
                'nama' => 'IPAS (Ilmu Pengetahuan Alam dan Sosial)',
                'slug' => 'ipas',
                'tipe' => 'pelajaran',
                'icon' => 'globe',
            ],
            [
                'nama' => 'Bahasa Indonesia',
                'slug' => 'bahasa-indonesia',
                'tipe' => 'pelajaran',
                'icon' => 'book',
            ],
            [
                'nama' => 'Matematika',
                'slug' => 'matematika',
                'tipe' => 'pelajaran',
                'icon' => 'calculator',
            ],
            [
                'nama' => 'Pendidikan Pancasila',
                'slug' => 'pendidikan-pancasila',
                'tipe' => 'pelajaran',
                'icon' => 'flag',
            ],
            [
                'nama' => 'Bahasa Inggris (My Next Words)',
                'slug' => 'bahasa-inggris',
                'tipe' => 'pelajaran',
                'icon' => 'globe',
            ],
            [
                'nama' => 'Seni Rupa & Prakarya',
                'slug' => 'seni-rupa',
                'tipe' => 'pelajaran',
                'icon' => 'palette',
            ],
            [
                'nama' => 'PJOK (Penjasorkes)',
                'slug' => 'pjok',
                'tipe' => 'pelajaran',
                'icon' => 'activity',
            ],
            [
                'nama' => 'Cerita & Fabel Bergambar',
                'slug' => 'cerita-fabel-bergambar',
                'tipe' => 'bacaan',
                'icon' => 'smile',
            ],
            [
                'nama' => 'Penguatan Karakter Anak',
                'slug' => 'penguatan-karakter-anak',
                'tipe' => 'bacaan',
                'icon' => 'heart',
            ],
            [
                'nama' => 'Literasi Budaya & Cerita Rakyat',
                'slug' => 'literasi-budaya-cerita-rakyat',
                'tipe' => 'bacaan',
                'icon' => 'bookmark',
            ],
            [
                'nama' => 'Literasi Sains & Lingkungan',
                'slug' => 'literasi-sains-lingkungan',
                'tipe' => 'bacaan',
                'icon' => 'sun',
            ],
        ];

        foreach ($categories as $category) {
            Category::updateOrCreate(
                ['slug' => $category['slug']],
                $category
            );
        }
    }
}