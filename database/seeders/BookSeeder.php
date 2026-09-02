<?php

namespace Database\Seeders;

use App\Models\Book;
use App\Models\Category;
use Illuminate\Database\Seeder;

class BookSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $catFabel = Category::where('slug', 'cerita-fabel-bergambar')->first();
        $catKarakter = Category::where('slug', 'penguatan-karakter-anak')->first();
        $catBudaya = Category::where('slug', 'literasi-budaya-cerita-rakyat')->first();
        $catSains = Category::where('slug', 'literasi-sains-lingkungan')->first();
        $catIpas = Category::where('slug', 'ipas')->first();
        $catIndo = Category::where('slug', 'bahasa-indonesia')->first();
        $catMtk = Category::where('slug', 'matematika')->first();
        $catPancasila = Category::where('slug', 'pendidikan-pancasila')->first();
        $catInggris = Category::where('slug', 'bahasa-inggris')->first();
        $catSeni = Category::where('slug', 'seni-rupa')->first();

        $books = [
            [
                'category_id' => $catFabel ? $catFabel->id : 1,
                'judul' => 'Si Bungsu Katak (The Youngest Frog)',
                'slug' => 'si-bungsu-katak',
                'penulis' => 'Pusat Perbukuan Kemendikdasmen',
                'penerbit' => 'Pusat Perbukuan Kemendikdasmen',
                'jenjang' => 'SD Kelas 1 - 3 (Pembaca Awal)',
                'tingkat_kelas' => null,
                'deskripsi' => 'Buku cerita fabel bilingual bergambar yang mendidik tentang keberanian, kasih sayang keluarga, dan petualangan katak kecil.',
                'cover_path' => 'https://images.unsplash.com/photo-1544717305-2782549b5136?w=600&auto=format&fit=crop&q=80',
                'file_path' => 'books/si-bungsu-katak.pdf',
                'total_halaman' => 36,
                'rating' => 4.9,
                'total_dibaca' => 128,
                'is_active' => true,
            ],
            [
                'category_id' => $catKarakter ? $catKarakter->id : 1,
                'judul' => 'Didan Mau Berbagi: Belajar Kebaikan Hati',
                'slug' => 'didan-mau-berbagi',
                'penulis' => 'Pusat Perbukuan Kemendikdasmen',
                'penerbit' => 'Pusat Perbukuan Kemendikdasmen',
                'jenjang' => 'SD Kelas 1 - 2 (Pembaca Awal)',
                'tingkat_kelas' => null,
                'deskripsi' => 'Kisah inspiratif Didan yang belajar indahnya berbagi mainan dan makanan kepada sahabat di sekolah.',
                'cover_path' => 'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?w=600&auto=format&fit=crop&q=80',
                'file_path' => 'books/didan-mau-berbagi.pdf',
                'total_halaman' => 28,
                'rating' => 5.0,
                'total_dibaca' => 95,
                'is_active' => true,
            ],
            [
                'category_id' => $catBudaya ? $catBudaya->id : 1,
                'judul' => 'Anak-Anak Teluk Bone: Mengenal Keragaman Nusantara',
                'slug' => 'anak-anak-teluk-bone',
                'penulis' => 'Pusat Perbukuan Kemendikdasmen',
                'penerbit' => 'Pusat Perbukuan Kemendikdasmen',
                'jenjang' => 'SD Kelas 3 - 5 (Pembaca Madya)',
                'tingkat_kelas' => null,
                'deskripsi' => 'Kumpulan cerita kehidupan anak-anak pesisir Teluk Bone dan 12 kisah menakjubkan keragaman budaya Indonesia.',
                'cover_path' => 'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=600&auto=format&fit=crop&q=80',
                'file_path' => 'books/anak-anak-teluk-bone.pdf',
                'total_halaman' => 64,
                'rating' => 4.9,
                'total_dibaca' => 140,
                'is_active' => true,
            ],
            [
                'category_id' => $catBudaya ? $catBudaya->id : 1,
                'judul' => 'Cerita Rakyat Nusantara: Aji Saka & Legenda Lainnya',
                'slug' => 'cerita-rakyat-nusantara-aji-saka',
                'penulis' => 'Pusat Perbukuan Kemendikdasmen',
                'penerbit' => 'Pusat Perbukuan Kemendikdasmen',
                'jenjang' => 'SD Semua Kelas',
                'tingkat_kelas' => null,
                'deskripsi' => 'Kisah kepahlawanan Aji Saka, asal-usul aksara Jawa, dan cerita hikmah nusantara yang sarat budi pekerti.',
                'cover_path' => 'https://images.unsplash.com/photo-1534447677768-be436bb09401?w=600&auto=format&fit=crop&q=80',
                'file_path' => 'books/cerita-rakyat-aji-saka.pdf',
                'total_halaman' => 84,
                'rating' => 4.8,
                'total_dibaca' => 110,
                'is_active' => true,
            ],
            [
                'category_id' => $catSains ? $catSains->id : 1,
                'judul' => 'Namaku Kali: Menjaga Kelestarian Sungai & Alam',
                'slug' => 'namaku-kali',
                'penulis' => 'Pusat Perbukuan Kemendikdasmen',
                'penerbit' => 'Pusat Perbukuan Kemendikdasmen',
                'jenjang' => 'SD Kelas 4 - 6 (Pembaca Mahir)',
                'tingkat_kelas' => null,
                'deskripsi' => 'Edukasi pengenalan ekosistem air tawar, siklus air hujan, dan pentingnya menjaga kebersihan sungai sekitar.',
                'cover_path' => 'https://images.unsplash.com/photo-1532094349884-543bc11b234d?w=600&auto=format&fit=crop&q=80',
                'file_path' => 'books/namaku-kali.pdf',
                'total_halaman' => 48,
                'rating' => 4.9,
                'total_dibaca' => 87,
                'is_active' => true,
            ],
            [
                'category_id' => $catKarakter ? $catKarakter->id : 1,
                'judul' => 'Aku Sudah Besar: Belajar Kebiasaan Mandiri',
                'slug' => 'aku-sudah-besar',
                'penulis' => 'Pusat Perbukuan Kemendikdasmen',
                'penerbit' => 'Pusat Perbukuan Kemendikdasmen',
                'jenjang' => 'SD Kelas 1 - 2 (Pembaca Awal)',
                'tingkat_kelas' => null,
                'deskripsi' => 'Buku bergambar penuh warna yang melatih anak merapikan tempat tidur, memakai seragam sendiri, dan percaya diri.',
                'cover_path' => 'https://images.unsplash.com/photo-1596495578065-6e0763fa1178?w=600&auto=format&fit=crop&q=80',
                'file_path' => 'books/aku-sudah-besar.pdf',
                'total_halaman' => 32,
                'rating' => 4.8,
                'total_dibaca' => 64,
                'is_active' => true,
            ],
            [
                'category_id' => $catIpas ? $catIpas->id : 1,
                'judul' => 'Ilmu Pengetahuan Alam & Sosial (IPAS) SD Kelas 4',
                'slug' => 'ipas-sd-kelas-4',
                'penulis' => 'Amalia Fitri, dkk.',
                'penerbit' => 'Pusat Perbukuan Kemendikdasmen',
                'jenjang' => 'SD Kelas 4 (Fase B)',
                'tingkat_kelas' => 4,
                'deskripsi' => 'Buku teks resmi Kurikulum Merdeka: materi wujud zat, bagian tubuh tumbuhan, gaya dan gerak, serta kearifan lokal.',
                'cover_path' => 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=600&auto=format&fit=crop&q=80',
                'file_path' => 'books/ipas-sd-kelas-4.pdf',
                'total_halaman' => 224,
                'rating' => 4.9,
                'total_dibaca' => 312,
                'is_active' => true,
            ],
            [
                'category_id' => $catIndo ? $catIndo->id : 1,
                'judul' => 'Bahasa Indonesia: Aku Bisa! untuk SD Kelas 1',
                'slug' => 'bahasa-indonesia-sd-kelas-1',
                'penulis' => 'Sofie Dewayani',
                'penerbit' => 'Pusat Perbukuan Kemendikdasmen',
                'jenjang' => 'SD Kelas 1 (Fase A)',
                'tingkat_kelas' => 1,
                'deskripsi' => 'Panduan belajar membaca permulaan, mengenal huruf vokal dan konsonan, menulis kata sederhana, dan bersosialisasi.',
                'cover_path' => 'https://images.unsplash.com/photo-1618519764620-7403abdbdfe9?w=600&auto=format&fit=crop&q=80',
                'file_path' => 'books/bahasa-indonesia-sd-kelas-1.pdf',
                'total_halaman' => 216,
                'rating' => 5.0,
                'total_dibaca' => 240,
                'is_active' => true,
            ],
            [
                'category_id' => $catMtk ? $catMtk->id : 1,
                'judul' => 'Matematika untuk SD/MI Kelas 2',
                'slug' => 'matematika-sd-kelas-2',
                'penulis' => 'Tim Gakkotosho & BSKAP Kemendikdasmen',
                'penerbit' => 'Pusat Perbukuan Kemendikdasmen',
                'jenjang' => 'SD Kelas 2 (Fase A)',
                'tingkat_kelas' => 2,
                'deskripsi' => 'Belajar berhitung bilangan sampai 1000, penjumlahan dan pengurangan bersusun, bentuk geometri dasar, dan waktu.',
                'cover_path' => 'https://images.unsplash.com/photo-1635070041078-e363dbe005cb?w=600&auto=format&fit=crop&q=80',
                'file_path' => 'books/matematika-sd-kelas-2.pdf',
                'total_halaman' => 160,
                'rating' => 4.9,
                'total_dibaca' => 198,
                'is_active' => true,
            ],
            [
                'category_id' => $catPancasila ? $catPancasila->id : 1,
                'judul' => 'Pendidikan Pancasila untuk SD/MI Kelas 5',
                'slug' => 'pendidikan-pancasila-sd-kelas-5',
                'penulis' => 'Adi Darma Indra, dkk.',
                'penerbit' => 'Pusat Perbukuan Kemendikdasmen',
                'jenjang' => 'SD Kelas 5 (Fase C)',
                'tingkat_kelas' => 5,
                'deskripsi' => 'Memahami penerapan nilai Pancasila dalam kehidupan berbangsa, norma hukum, serta kedaulatan wilayah NKRI.',
                'cover_path' => 'https://images.unsplash.com/photo-1577896851231-70ef18881754?w=600&auto=format&fit=crop&q=80',
                'file_path' => 'books/pendidikan-pancasila-sd-kelas-5.pdf',
                'total_halaman' => 192,
                'rating' => 4.8,
                'total_dibaca' => 155,
                'is_active' => true,
            ],
            [
                'category_id' => $catInggris ? $catInggris->id : 1,
                'judul' => 'My Next Words: English for Elementary School Grade 4',
                'slug' => 'my-next-words-grade-4',
                'penulis' => 'EYLC Team (BSKAP Kemendikdasmen)',
                'penerbit' => 'Pusat Perbukuan Kemendikdasmen',
                'jenjang' => 'SD Kelas 4 (Fase B)',
                'tingkat_kelas' => 4,
                'deskripsi' => 'Aktivitas belajar bahasa Inggris interaktif dengan gambar ekspresif mengenai kegiatan kelas, hobi, dan makanan favorit.',
                'cover_path' => 'https://images.unsplash.com/photo-1513542789411-b6a5d4f31634?w=600&auto=format&fit=crop&q=80',
                'file_path' => 'books/my-next-words-grade-4.pdf',
                'total_halaman' => 136,
                'rating' => 4.7,
                'total_dibaca' => 143,
                'is_active' => true,
            ],
            [
                'category_id' => $catSeni ? $catSeni->id : 1,
                'judul' => 'Seni Rupa untuk SD Kelas 3',
                'slug' => 'seni-rupa-sd-kelas-3',
                'penulis' => 'Faisal Kamandobat',
                'penerbit' => 'Pusat Perbukuan Kemendikdasmen',
                'jenjang' => 'SD Kelas 3 (Fase B)',
                'tingkat_kelas' => 3,
                'deskripsi' => 'Eksplorasi warna, pola garis, teknik cetak sederhana, menggambar ekspresi, dan apresiasi karya seni anak.',
                'cover_path' => 'https://images.unsplash.com/photo-1569742642598-a5c7fec35832?w=600&auto=format&fit=crop&q=80',
                'file_path' => 'books/seni-rupa-sd-kelas-3.pdf',
                'total_halaman' => 144,
                'rating' => 4.8,
                'total_dibaca' => 92,
                'is_active' => true,
            ],
        ];

        foreach ($books as $book) {
            Book::updateOrCreate(
                ['slug' => $book['slug']],
                $book
            );
        }
    }
}