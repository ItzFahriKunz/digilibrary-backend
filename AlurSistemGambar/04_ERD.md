# 🗄️ Spesifikasi Entity Relationship Diagram (ERD) — Digilibrary SD
> **Rujukan Visual: `Picture4.png` & `Database/db_siperpus_mi (1).sql`**  
> **Basis Data: MySQL 8.x / MariaDB (Laravel 11 Eloquent ORM)**

Dokumen ini mendokumentasikan skema basis data relasional final yang mengintegrasikan kebutuhan e-library modern dan struktur akademik 24 rombel sekolah dasar.

---

## 1. Diagram Relasi Entitas (Mermaid ERD)

```mermaid
erDiagram
    users ||--o{ reading_logs : "memiliki"
    users ||--o{ siswa_kelas : "terdaftar_di"
    users ||--o{ wali_kelas : "mengampu"
    users ||--o{ books : "mengunggah (admin)"

    categories ||--o{ books : "mengelompokkan"
    books ||--o{ reading_logs : "dibaca_dalam"

    tahun_ajaran ||--o{ kelas : "menaungi"
    tahun_ajaran ||--o{ siswa_kelas : "periode_akademik"
    tahun_ajaran ||--o{ wali_kelas : "periode_penugasan"

    kelas ||--o{ siswa_kelas : "memiliki_murid"
    kelas ||--o{ wali_kelas : "dipimpin_oleh"

    users {
        bigint id PK
        string firebase_uid "nullable"
        string name
        string email "UK"
        string password
        enum role "admin, guru, siswa"
        string avatar "nullable"
        string nis "nullable, khusus siswa"
        string nisn "nullable, khusus siswa"
        string nip "nullable, khusus guru"
        string kelas "nullable, cache rombel aktif"
        datetime created_at
        datetime updated_at
    }

    tahun_ajaran {
        bigint id PK
        string label "contoh: 2025/2026"
        date tanggal_mulai "nullable"
        date tanggal_selesai "nullable"
        enum status "aktif, selesai"
        datetime created_at
        datetime updated_at
    }

    kelas {
        bigint id PK
        bigint tahun_ajaran_id FK
        int tingkat "1 - 6"
        string nama_rombel "contoh: 1A, 4B"
        int kuota_maksimal "default: 32"
        datetime created_at
        datetime updated_at
    }

    siswa_kelas {
        bigint id PK
        bigint user_id FK
        bigint kelas_id FK
        bigint tahun_ajaran_id FK
        enum status "aktif, naik_kelas, lulus, pindah"
        datetime created_at
        datetime updated_at
    }

    wali_kelas {
        bigint id PK
        bigint user_id FK
        bigint kelas_id FK
        bigint tahun_ajaran_id FK
        datetime created_at
        datetime updated_at
    }

    categories {
        bigint id PK
        string nama "Bahasa Indonesia, Matematika, dll"
        string slug "UK"
        text deskripsi "nullable"
        enum tipe "pelajaran, bacaan"
        string icon "nullable"
        datetime created_at
        datetime updated_at
    }

    books {
        bigint id PK
        bigint category_id FK
        bigint uploaded_by FK "admin"
        string judul
        string slug "UK"
        string penulis
        string penerbit "nullable"
        int tahun_terbit "nullable"
        string isbn "nullable"
        text deskripsi "nullable"
        int tingkat_kelas "1 - 6"
        int total_halaman
        decimal rating "default: 5.00"
        int total_dibaca "default: 0"
        string cover_path
        string file_path "PDF file"
        boolean is_active "default: true"
        datetime created_at
        datetime updated_at
    }

    reading_logs {
        bigint id PK
        bigint user_id FK
        bigint book_id FK
        string platform "mobile, web"
        int halaman_terakhir "default: 1"
        int durasi_detik "default: 0"
        datetime read_at
        datetime created_at
        datetime updated_at
    }
```

---

## 2. Kamus Data (Data Dictionary) Tabel Utama

### A. Tabel `users` (Entitas Pengguna Terpusat)
Menyimpan seluruh akun pengguna sistem dengan pembeda kolom `role`.
- `id` (BigInt, PK, Auto Increment)
- `firebase_uid` (VarChar 128, Nullable): UID otentikasi Google One-Tap Firebase.
- `name` (VarChar 150): Nama lengkap siswa, guru, atau admin.
- `email` (VarChar 150, Unique): Alamat email resmi.
- `role` (Enum: `'admin'`, `'guru'`, `'siswa'`): Peran otorisasi sistem.
- `nis` (VarChar 30, Nullable): Nomor Induk Siswa.
- `nisn` (VarChar 30, Nullable): Nomor Induk Siswa Nasional.
- `nip` (VarChar 30, Nullable): Nomor Induk Pegawai (khusus guru).
- `kelas` (VarChar 50, Nullable): String penanda rombel aktif (misal: "Kelas 4A") untuk backward-compatibility.
- `avatar` (VarChar 255, Nullable): Lokasi path / URL gambar profil pengguna.

### B. Tabel `tahun_ajaran` & `kelas` (Struktur 24 Rombel SD)
- **`tahun_ajaran`**: Menampung siklus tahun pelajaran (contoh: "2025/2026", status: `'aktif'`).
- **`kelas`**: Menyimpan 24 rombel Sekolah Dasar:
  - Tingkat 1: `1A`, `1B`, `1C`
  - Tingkat 2: `2A`, `2B`, `2C`
  - Tingkat 3: `3A`, `3B`, `3C`
  - Tingkat 4: `4A`, `4B`, `4C`
  - Tingkat 5: `5A`, `5B`, `5C`
  - Tingkat 6: `6A`, `6B`, `6C`
  - `kuota_maksimal`: Batas kapasitas murid per rombel (standar: 32 siswa).

### C. Tabel `siswa_kelas` & `wali_kelas` (Riwayat Kenaikan & Penugasan)
- **`siswa_kelas`**: Relasi banyak-ke-banyak antara siswa dan kelas per tahun ajaran dengan status (`'aktif'`, `'naik_kelas'`, `'lulus'`, `'pindah'`).
- **`wali_kelas`**: Relasi satu guru memimpin satu kelas pada tahun ajaran aktif. Constraint unik pada `kelas_id + tahun_ajaran_id`.

### D. Tabel `books` & `reading_logs` (Katalog & Pelacakan Baca)
- **`books`**: Menyimpan katalog e-book resmi SIBI Kemendikdasmen beserta referensi cover image dan file PDF.
- **`reading_logs`**: Menyimpan riwayat baca live (`durasi_detik`, `halaman_terakhir`, `platform: 'mobile'/'web'`).