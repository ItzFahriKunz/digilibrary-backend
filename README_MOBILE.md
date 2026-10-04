> ⚠️ **PENTING UNTUK DEVELOPER MOBILE (ANDROID KOTLIN / FLUTTER)**:  
> Aplikasi Mobile ini **KHUSUS DIPERUNTUKKAN BAGI 2 PERAN (ROLE): GURU & SISWA**.  
> - **Siswa**: Beranda Katalog Kurikulum Merdeka, E-Reader PDF, Pelacakan Baca Real-time (0–100%), Papan Peringkat Leaderboard, Profil (NIS & NISN).  
> - **Guru / Wali Kelas**: Semua fitur siswa ditambah tab ekstra **"Pantau Kelas"** (`/api/guru/overview`) untuk memantau aktivitas murid satu rombel binaan.  
> - **Administrator**: **Dikelola khusus melalui Web Browser Desktop** (Manajemen Buku, Pengguna, 24 Rombel, Kuota, Tahun Ajaran). Jika akun `role: "admin"` mencoba login di mobile, tampilkan dialog/pesan ramah bahwa fitur admin perpustakaan diakses melalui Web Desktop.

---
# 📱 Panduan Pengembangan Android (Kotlin) - Digilibrary SD
> **Perpustakaan Digital Sekolah Dasar Berstandar Kurikulum Merdeka & SIBI Kemendikdasmen**  
> Repositori panduan teknis, spesifikasi antarmuka Jetpack Compose, integrasi REST API, dan tata kelola peran (Role Siswa & Guru).

Bagi rekan developer yang ingin mempelajari gambaran besar arsitektur, diagram alur, dan struktur relasi database sistem, silakan baca:  
📑 **[📘 ReadmeAlurSistem.md (Use Case, Flowchart, Flow Map, ERD & Komponen)](./ReadmeAlurSistem.md)**

---

## 📌 Daftar Isi
1. [Ringkasan Proyek & Konsep Role](#1-ringkasan-proyek--konsep-role)
2. [Format Standar Response API (JSON Envelope)](#2-format-standar-response-api-json-envelope)
3. [Design System & Panduan Tampilan UI](#3-design-system--panduan-tampilan-ui)
4. [Navigasi & Dynamic Role Bottom Bar](#4-navigasi--dynamic-role-bottom-bar)
5. [Spesifikasi Fitur Utama E-Reader](#5-spesifikasi-fitur-utama-e-reader)
6. [Kontrak Lengkap REST API Backend](#6-kontrak-lengkap-rest-api-backend)
   - [A. Autentikasi (`/api/auth`)](#a-autentikasi-apiauth)
   - [B. Manajemen Profil & Akun (`/api/user`)](#b-manajemen-profil--akun-apiuser)
   - [C. Kategori & Buku Kurikulum Merdeka (`/api/categories` & `/api/books`)](#c-kategori--buku-kurikulum-merdeka-apicategories--apibooks)
   - [D. Dasbor Guru & Pemantauan Kelas (`/api/guru`)](#d-dasbor-guru--pemantauan-kelas-apiguru)
7. [Template Model Data Android (Kotlin Data Classes)](#7-template-model-data-android-kotlin-data-classes)
8. [Setup Backend untuk Rekan Pengembang (Git Pull & Migrasi)](#8-setup-backend-untuk-rekan-pengembang-git-pull--migrasi)
9. [Konfigurasi Emulator & Network Security](#9-konfigurasi-emulator--network-security)
10. [Checklist Pengujian Aplikasi (QA)](#10-checklist-pengujian-aplikasi-qa)

---

## 1. Ringkasan Proyek & Konsep Role

Digilibrary SD adalah aplikasi perpustakaan digital khusus anak Sekolah Dasar (SD) dengan katalog buku resmi dari SIBI Kemendikdasmen (Buku Teks Kurikulum Merdeka Fase A s/d C, Buku Pengayaan Literasi, dan Sains Terapan).

### 👥 Aturan Peran (Role Handling) di Mobile:
1. **Siswa (Pengguna Utama)**:
   - Login menggunakan akun Google (Firebase One-Tap) atau Email & Kata Sandi.
   - Pendaftaran baru otomatis mendapatkan peran **`role = "siswa"`**.
   - Pada login pertama kali, jika `is_profile_complete = false`, wajib melengkapi nama dan kelas.
   - Siswa memiliki data akademik: **NIS** (Nomor Induk Siswa) dan **NISN** (Nomor Induk Siswa Nasional).
   - Hak penugasan kelas dan mutasi siswa dikelola terpusat oleh Administrator demi validitas data.
   - Membaca buku secara interaktif dengan pelacakan waktu membaca aktif (*Live Reading Tracker*).
2. **Guru / Wali Kelas**:
   - Diberikan kewenangan peran **`role = "guru"`** oleh Admin Sekolah via panel Web.
   - Memiliki semua kemampuan Siswa ditambah tab ekstra: **"Pantau Kelas"** (`/api/guru/overview`).
   - Tab Pantau Kelas menampilkan statistik membaca kelas binaannya, peringkat (*leaderboard*) literasi, serta daftar murid dengan status membaca hari ini ("Sudah Membaca" vs "Belum Membaca").
   - Guru memiliki data **NIP** (Nomor Induk Pegawai).
   - *Catatan Penting*: Jika guru belum ditetapkan sebagai wali kelas oleh admin (`has_assigned_class: false`), aplikasi menampilkan ilustrasi status *"Belum Ditugaskan Sebagai Wali Kelas"*.
3. **Admin Sekolah**:
   - Berstatus **`role = "admin"`**. Dikelola khusus melalui Web Browser Desktop. Jika login di mobile, arahkan pengguna bahwa fitur manajemen perpustakaan diakses melalui Web.

---

## 2. Format Standar Response API (JSON Envelope)

Seluruh response dari backend Laravel dibungkus dalam format standar seragam:

### Respons Berhasil (200 OK / 201 Created)
```json
{
  "status": "success",
  "message": "Pesan deskriptif aksi",
  "data": { ... } // Atau berupa JSON Array [ ... ]
}
```

### Respons Gagal / Validasi (401 / 403 / 404 / 422)
```json
{
  "status": "error",
  "message": "Pesan kesalahan yang mudah dipahami",
  "errors": { ... } // Opsional: pesan validasi per kolom form
}
```

---

## 3. Design System & Panduan Tampilan UI

Tampilan aplikasi Android mengusung nuansa **ramah anak, cerah, modern, dan harmonis dengan desain Web**.

### A. Palet Warna (Color Tokens)
Gunakan token warna berikut pada `ui/theme/Color.kt`:

| Token | Hex Code | Penggunaan |
| :--- | :--- | :--- |
| `PrimaryEmerald` | `#10A871` / `#2BA76E` | Tombol utama, tab aktif, ikon primer |
| `HeroGradientStart` | `#16A34A` | Titik awal gradien hero section atas |
| `HeroGradientEnd` | `#064E3B` | Titik akhir gradien hero section bawah |
| `CategoryGradientStart` | `#19BC71` | Gradien kartu kategori bacaan |
| `CategoryGradientEnd` | `#1B9A60` | Gradien kartu kategori bacaan |
| `BackgroundLight` | `#FDFDFD` / `#F8FAF9` | Latar belakang layar & form input |
| `AccentMintLight` | `#3DD68C` / `#7DF3BA` | Teks sorotan pada banner hijau |
| `BorderDivider` | `#D8E6DE` | Border card, outline input text, divider |
| `TextPrimary` | `#1A1A1A` | Judul buku, headline utama |
| `TextSecondary` | `#5C6B64` | Subtitle, nama penulis, sinopsis cerita |
| `RatingStar` | `#F59E0B` | Bintang rating ulasan buku |
| `SoftRed` | `#EF4444` | Notifikasi status belum membaca |

### B. Tipografi
- **Headline & Judul**: Gunakan font *Outfit* atau font Sans-Serif modern berbobot *SemiBold / Bold*.
- **Body & Metadata**: Gunakan font *Inter* atau *Roboto* dengan *line-height* yang lega ramah siswa SD.

---

## 4. Navigasi & Dynamic Role Bottom Bar

Gunakan Navigation Compose dengan Bottom Bar dinamis yang disesuaikan dengan nilai `user.role`:

```
📱 Siswa Bottom Bar:
   ├── [1] Beranda (Katalog & Banner Kategori)
   ├── [2] Rak Buku (Buku Sedang Dibaca & Riwayat Membaca)
   └── [3] Profil (Data Diri, NIS, NISN, Ganti Sandi, Logout)

📱 Guru Bottom Bar:
   ├── [1] Beranda (Katalog & Buku Panduan Guru)
   ├── [2] Rak Buku (Buku Favorit & Riwayat)
   ├── [3] Pantau Kelas (Rekapitulasi Murid Kelas Wali) 🌟 (Khusus Guru)
   └── [4] Profil (Data Diri, NIP, Kelas Ampuan, Logout)
```

---

## 5. Spesifikasi Fitur Utama E-Reader

### 1. PDF Canvas & Anti-Pembajakan (Dynamic Watermark)
- Gunakan library native Android PDF Viewer (misal: `AndroidPdfViewer`).
- Lapisi kanvas PDF dengan layer transparan (*Canvas drawText*) miring 45 derajat berulang berisi teks:  
  `"Digilibrary SD • [Nama Siswa] • [Tanggal]"` (Opacity 12-15%).
- Matikan screenshot via `window.setFlags(FLAG_SECURE, FLAG_SECURE)`.

### 2. Live Reading Tracker & Idle Detector (Anti-Curang)
1. **Active Timer (1 Detik)**: Berjalan saat layar buku sedang aktif dan pengguna berinteraksi.
2. **Idle Detector (60 Detik)**:
   - Setiap sentuhan layar / gestur membalik halaman mereset penghitung idle (`idle_counter = 0`).
   - Jika layar tidak disentuh selama **> 60 detik**, timer aktif otomatis **di-pause** dan muncul dialog *"Sesi membaca dijeda karena layar tidak disentuh"*.
3. **Sinkronisasi Periodik & Deduplikasi**:
   - Kirim akumulasi waktu setiap 30 detik aktif ke `POST /api/books/{id}/track-read`.
   - Simpan `log_id` yang diterima dari respons pertama, lalu sertakan pada request berikutnya agar backend memperbarui sesi yang sama (`durasi_detik = max(durasi_lama, durasi_baru)`) tanpa membuat baris baru.
   - Kirimkan data terakhir saat siswa menutup viewer / menekan tombol kembali.

---

## 6. Kontrak Lengkap REST API Backend

Base URL Lokal Emulator: `http://10.0.2.2:8000/api`  
Base URL Device Fisik (Wi-Fi Laptop): `http://<IP_LAPTOP>:8000/api`  
Header Wajib Request Terproteksi:  
```http
Authorization: Bearer <TOKEN_SANCTUM>
Accept: application/json
```

---

### A. Autentikasi (`/api/auth`)

#### 1. Registrasi Akun Baru (Siswa)
* **Endpoint**: `POST /api/auth/register`
* **Request Body**:
  ```json
  {
    "name": "Ahmad Fauzi",
    "email": "ahmad.fauzi@sekolah.sch.id",
    "password": "password123"
  }
  ```
* **Response (201 Created)**:
  ```json
  {
    "status": "success",
    "message": "Pendaftaran akun berhasil!",
    "data": {
      "user": {
        "id": 15,
        "name": "Ahmad Fauzi",
        "email": "ahmad.fauzi@sekolah.sch.id",
        "role": "siswa",
        "kelas": null,
        "avatar": null,
        "nis": null,
        "nisn": null,
        "nip": null
      },
      "token": "1|qwe879asdasd87687asd...",
      "is_profile_complete": false
    }
  }
  ```

#### 2. Login dengan Email & Password
* **Endpoint**: `POST /api/auth/login`
* **Request Body**:
  ```json
  {
    "email": "ahmad.fauzi@sekolah.sch.id",
    "password": "password123"
  }
  ```
* **Response (200 OK)**:
  ```json
  {
    "status": "success",
    "message": "Login berhasil!",
    "data": {
      "user": {
        "id": 15,
        "name": "Ahmad Fauzi",
        "email": "ahmad.fauzi@sekolah.sch.id",
        "role": "siswa",
        "kelas": "Kelas 4A",
        "avatar": "/storage/avatars/user_15.jpg",
        "nis": "20240101",
        "nisn": "0081234567",
        "nip": null
      },
      "token": "2|123897asdnmba23487asd...",
      "is_profile_complete": true
    }
  }
  ```

#### 3. Login dengan Google One-Tap (Firebase Auth)
* **Endpoint**: `POST /api/auth/google`
* **Catatan Kompatibilitas**: Backend mendukung field `token` maupun `id_token` secara fleksibel.
* **Request Body**:
  ```json
  {
    "token": "eyJhbGciOiJSUzI1NiIsImtpZCI...",
    "avatar": "https://lh3.googleusercontent.com/a/..."
  }
  ```
  *(Atau gunakan field `"id_token"`)*
* **Response (200 OK)**:
  ```json
  {
    "status": "success",
    "message": "Login Google berhasil!",
    "data": {
      "user": {
        "id": 14,
        "name": "Budi Pratama",
        "email": "budi.pratama@gmail.com",
        "avatar": "https://lh3.googleusercontent.com/...",
        "role": "siswa",
        "kelas": "Kelas 4A",
        "nis": null,
        "nisn": null,
        "nip": null
      },
      "token": "3|poi879asdasd87687asd...",
      "is_profile_complete": true
    }
  }
  ```

#### 4. Lengkapi Profil Pertama Kali (Untuk Siswa Baru)
* **Endpoint**: `PUT /api/auth/complete-profile`
* **Request Body**:
  ```json
  {
    "name": "Budi Pratama",
    "kelas": "Kelas 4A"
  }
  ```
* **Response (200 OK)**:
  ```json
  {
    "status": "success",
    "message": "Profil berhasil dilengkapi!",
    "data": {
      "id": 14,
      "name": "Budi Pratama",
      "kelas": "Kelas 4A",
      "is_profile_complete": true
    }
  }
  ```

#### 5. Ambil Info Pengguna Aktif (`me`)
* **Endpoint**: `GET /api/auth/me`
* **Response (200 OK)**:
  ```json
  {
    "status": "success",
    "data": {
      "user": {
        "id": 14,
        "name": "Budi Pratama",
        "email": "budi@gmail.com",
        "role": "siswa",
        "kelas": "Kelas 4A",
        "avatar": "https://lh3.googleusercontent.com/...",
        "nis": "20240012",
        "nisn": "0082345678",
        "nip": null
      },
      "is_profile_complete": true
    }
  }
  ```

#### 6. Lupa Kata Sandi (Permintaan OTP 6-Digit)
* **Endpoint**: `POST /api/auth/forgot-password`
* **Request Body**:
  ```json
  {
    "email": "siswa@sekolah.sch.id"
  }
  ```
* **Response (200 OK)**:
  ```json
  {
    "status": "success",
    "message": "Kode OTP reset password berhasil dikirim ke email Anda. Berlaku selama 60 menit."
  }
  ```

#### 7. Verifikasi Kode OTP
* **Endpoint**: `POST /api/auth/verify-otp`
* **Request Body**:
  ```json
  {
    "email": "siswa@sekolah.sch.id",
    "token": "482910"
  }
  ```
* **Response (200 OK)**:
  ```json
  {
    "status": "success",
    "message": "Kode verifikasi valid! Silakan atur kata sandi baru Anda."
  }
  ```

#### 8. Reset Kata Sandi Baru
* **Endpoint**: `POST /api/auth/reset-password`
* **Request Body**:
  ```json
  {
    "email": "siswa@sekolah.sch.id",
    "token": "482910",
    "password": "PasswordBaru123",
    "password_confirmation": "PasswordBaru123"
  }
  ```
* **Response (200 OK)**:
  ```json
  {
    "status": "success",
    "message": "Kata sandi Anda berhasil diatur ulang. Silakan masuk kembali."
  }
  ```

#### 9. Logout
* **Endpoint**: `POST /api/auth/logout`
* **Response (200 OK)**:
  ```json
  {
    "status": "success",
    "message": "Berhasil keluar dari sesi aplikasi."
  }
  ```

---

### B. Manajemen Profil & Akun (`/api/user`)

#### 1. Perbarui Profil Pengguna
* **Endpoint**: `POST /api/user/profile`
* **Content-Type**: `multipart/form-data` atau `application/json`
* **Parameters**:
  * `name` (string, wajib, max 150)
  * `nis` (string, opsional, max 30) - Nomor Induk Siswa
  * `nisn` (string, opsional, max 30) - Nomor Induk Siswa Nasional
  * `nip` (string, opsional, max 30) - Nomor Induk Pegawai (khusus Guru)
  * `avatar_file` (file image: jpg/png/webp, opsional, max 3MB)
  * `avatar` (string URL, opsional jika memakai gambar online)
  * `remove_avatar` (`"1"` atau `true`, opsional jika siswa ingin menghapus foto dan kembali ke inisial abjad)
* **Aturan Keamanan**: Peran (`role`) dan penugasan kelas (`kelas`) dikunci demi keamanan integritas rapor siswa.
* **Response (200 OK)**:
  ```json
  {
    "status": "success",
    "message": "Profil berhasil diperbarui",
    "data": {
      "user": {
        "id": 14,
        "name": "Budi Pratama",
        "email": "budi@gmail.com",
        "avatar": "/storage/avatars/avatar_14.webp",
        "role": "siswa",
        "kelas": "Kelas 4A",
        "nis": "20240012",
        "nisn": "0082345678",
        "nip": null
      }
    }
  }
  ```

#### 2. Ubah Kata Sandi Akun
* **Endpoint**: `PUT /api/user/password`
* **Request Body**:
  ```json
  {
    "current_password": "passwordLama123",
    "new_password": "passwordBaru123",
    "new_password_confirmation": "passwordBaru123"
  }
  ```
  *(Catatan: Jika akun terdaftar via Google One-Tap dan belum memiliki password, `current_password` tidak wajib diisi).*
* **Response (200 OK)**:
  ```json
  {
    "status": "success",
    "message": "Kata sandi berhasil diperbarui."
  }
  ```

#### 3. Riwayat Buku yang Baru Dibaca
* **Endpoint**: `GET /api/user/reading-history`
* **Response (200 OK)**:
  ```json
  {
    "status": "success",
    "data": [
      {
        "id": 102,
        "user_id": 14,
        "book_id": 5,
        "platform": "mobile",
        "halaman_terakhir": 24,
        "durasi_detik": 1500,
        "read_at": "2026-10-02T13:45:00.000000Z",
        "book": {
          "id": 5,
          "judul": "Matematika untuk SD/MI Kelas IV",
          "slug": "matematika-kelas-iv",
          "penulis": "Hobri, dkk.",
          "jenjang": "SD Kelas 4",
          "total_halaman": 192,
          "cover_path": "covers/matematika_4.jpg",
          "file_path": "books/matematika_4.pdf",
          "cover_url": "http://10.0.2.2:8000/storage/covers/matematika_4.jpg",
          "pdf_url": "http://10.0.2.2:8000/storage/books/matematika_4.pdf"
        }
      }
    ]
  }
  ```

---

### C. Kategori & Buku Kurikulum Merdeka (`/api/categories` & `/api/books`)

#### 1. Daftar Kategori Bacaan
* **Endpoint**: `GET /api/categories`
* **Query Params Opsional**: `tipe=pelajaran` atau `tipe=bacaan`
* **Response (200 OK)**:
  ```json
  {
    "status": "success",
    "message": "Daftar kategori berhasil diambil",
    "data": [
      {
        "id": 1,
        "nama": "Bahasa Indonesia",
        "slug": "bahasa-indonesia",
        "tipe": "pelajaran",
        "icon": "book-open",
        "books_count": 8
      },
      {
        "id": 2,
        "nama": "Matematika",
        "slug": "matematika",
        "tipe": "pelajaran",
        "icon": "math",
        "books_count": 6
      },
      {
        "id": 3,
        "nama": "Ilmu Pengetahuan Alam & Sosial",
        "slug": "ipas",
        "tipe": "pelajaran",
        "icon": "flask",
        "books_count": 5
      }
    ]
  }
  ```

#### 2. Katalog Buku Lengkap (Pagination & Filter)
* **Endpoint**: `GET /api/books`
* **Query Parameters**:
  * `search`: Kata kunci pencarian (judul, penulis, deskripsi)
  * `kategori` atau `category_id`: ID kategori buku
  * `tingkat_kelas` atau `kelas`: Angka kelas (1 - 6)
  * `sort_by`: `created_at` (default), `total_dibaca`, `rating`, `judul`
  * `sort_order`: `asc` atau `desc`
  * `per_page`: Jumlah buku per halaman (default 24)
  * `page`: Nomor halaman aktif (default 1)
* **Response (200 OK)**:
  ```json
  {
    "status": "success",
    "message": "Katalog buku berhasil diambil",
    "data": {
      "current_page": 1,
      "data": [
        {
          "id": 5,
          "category_id": 2,
          "judul": "Matematika untuk SD/MI Kelas IV",
          "slug": "matematika-kelas-iv",
          "penulis": "Hobri, dkk.",
          "penerbit": "Pusat Perbukuan Kemendikdasmen",
          "tingkat_kelas": 4,
          "total_halaman": 192,
          "rating": "4.90",
          "total_dibaca": 128,
          "cover_url": "http://10.0.2.2:8000/storage/covers/matematika_4.jpg",
          "pdf_url": "http://10.0.2.2:8000/storage/books/matematika_4.pdf"
        }
      ],
      "first_page_url": "http://10.0.2.2:8000/api/books?page=1",
      "from": 1,
      "last_page": 2,
      "per_page": 24,
      "total": 36
    }
  }
  ```

#### 3. Detail Lengkap Buku
* **Endpoint**: `GET /api/books/{slug_or_id}`
* **Fleksibilitas**: Parameter dapat berupa angka ID (misal `/api/books/5`) maupun teks slug (misal `/api/books/matematika-kelas-iv`).
* **Response (200 OK)**:
  ```json
  {
    "status": "success",
    "message": "Detail buku berhasil diambil",
    "data": {
      "id": 5,
      "category_id": 2,
      "judul": "Matematika untuk SD/MI Kelas IV",
      "slug": "matematika-kelas-iv",
      "penulis": "Hobri, dkk.",
      "penerbit": "Pusat Perbukuan Kemendikdasmen",
      "tahun_terbit": 2023,
      "isbn": "978-602-244-884-6",
      "deskripsi": "Buku teks utama pembelajaran matematika Kurikulum Merdeka...",
      "tingkat_kelas": 4,
      "total_halaman": 192,
      "rating": "4.90",
      "total_dibaca": 128,
      "cover_url": "http://10.0.2.2:8000/storage/covers/matematika_4.jpg",
      "pdf_url": "http://10.0.2.2:8000/storage/books/matematika_4.pdf",
      "category": {
        "id": 2,
        "nama": "Matematika",
        "slug": "matematika"
      }
    }
  }
  ```

#### 4. Catat Sesi Membaca Aktif (Live Reading Tracker)
* **Endpoint**: `POST /api/books/{id}/track-read`
* **Dual Field Naming Support**: Controller mendukung field Bahasa Indonesia maupun Inggris:
  * Durasi: `duration_seconds` atau `durasi_detik` (detik, integer).
  * Halaman: `page_number` atau `halaman_terakhir` (integer).
  * Platform: `"mobile"` atau `"web"`.
  * Sesi ID: `log_id` (integer, opsional).
* **Request Awal (Saat Masuk Halaman E-Reader)**:
  ```json
  {
    "duration_seconds": 30,
    "page_number": 1,
    "platform": "mobile"
  }
  ```
* **Response (200 OK)**:
  ```json
  {
    "status": "success",
    "message": "Sesi membaca berhasil dicatat",
    "data": {
      "total_dibaca": 129,
      "log_id": 565
    }
  }
  ```
* **Request Sinkronisasi Berkala (Setiap 30-60 Detik & Saat Tutup Buku)**:
  Sertakan `log_id: 565` dari response di atas:
  ```json
  {
    "log_id": 565,
    "duration_seconds": 90,
    "page_number": 8,
    "platform": "mobile"
  }
  ```

#### 5. Streaming File PDF
* **Endpoint**: `GET /api/books/{id}/stream`
* Mengembalikan binary stream file PDF dengan header Content-Type `application/pdf`.

---

### D. Dasbor Guru & Pemantauan Kelas (`/api/guru`)

Hanya dapat diakses oleh pengguna dengan peran **`role = "guru"`** atau **`"admin"`**.

#### 1. Ringkasan & Peringkat Membaca Murid Kelas
* **Endpoint**: `GET /api/guru/overview`
* **Response (200 OK - Guru Memiliki Kelas Binaan)**:
  ```json
  {
    "status": "success",
    "message": "Data pemantauan Kelas 4A berhasil dimuat",
    "data": {
      "has_assigned_class": true,
      "is_admin": false,
      "current_class": {
        "code": "4A",
        "name": "Kelas 4A",
        "grade": 4,
        "sub": "A",
        "wali_kelas": {
          "id": 8,
          "name": "Dra. Nurhayati, M.Pd.",
          "email": "nurhayati@sekolah.sch.id",
          "avatar": "/storage/avatars/guru_8.jpg"
        },
        "is_my_assigned": true
      },
      "teacher_assigned_class": "Kelas 4A",
      "stats": {
        "total_students": 28,
        "active_students": 19,
        "average_progress": 72,
        "total_books_read": 14,
        "total_duration_minutes": 1420
      },
      "leaderboard": [
        {
          "id": 14,
          "name": "Budi Pratama",
          "avatar": "https://lh3.googleusercontent.com/...",
          "kelas": "Kelas 4A",
          "nis": "20240012",
          "nisn": "0082345678",
          "rank": 1,
          "badge": "Bintang Literasi #1",
          "books_count": 8,
          "total_duration_minutes": 320,
          "avg_progress": 95,
          "status_today": "active",
          "status_today_label": "Sudah Membaca",
          "today_duration_minutes": 45,
          "last_book": "Matematika untuk SD/MI Kelas IV"
        },
        {
          "id": 19,
          "name": "Siti Rahmawati",
          "avatar": null,
          "kelas": "Kelas 4A",
          "nis": "20240015",
          "nisn": "0082345681",
          "rank": 2,
          "badge": "Juara Baca #2",
          "books_count": 6,
          "total_duration_minutes": 250,
          "avg_progress": 88,
          "status_today": "active",
          "status_today_label": "Sudah Membaca",
          "today_duration_minutes": 30,
          "last_book": "Bahasa Indonesia Kelas IV"
        }
      ],
      "students": [
        // Daftar seluruh murid kelas 4A berurutan berdasarkan capaian bacaan
      ]
    }
  }
  ```

* **Response (200 OK - Guru Belum Ditugaskan Kelas)**:
  ```json
  {
    "status": "success",
    "message": "Akun Anda terdaftar sebagai Guru namun belum memiliki penugasan kelas binaan.",
    "data": {
      "has_assigned_class": false,
      "is_admin": false,
      "current_class": null,
      "teacher_assigned_class": null,
      "stats": {
        "total_students": 0,
        "active_students": 0,
        "average_progress": 0,
        "total_books_read": 0,
        "total_duration_minutes": 0
      },
      "leaderboard": [],
      "students": []
    }
  }
  ```

---

## 7. Template Model Data Android (Kotlin Data Classes)

Salin kode berikut pada package `data/model/` aplikasi Android Anda:

```kotlin
package com.digilibrary.app.data.model

import com.google.gson.annotations.SerializedName

// 1. Generic Envelope
data class ApiResponse<T>(
    @SerializedName("status") val status: String,
    @SerializedName("message") val message: String?,
    @SerializedName("data") val data: T?
)

// 2. Auth & User
data class AuthData(
    @SerializedName("user") val user: UserDto,
    @SerializedName("token") val token: String,
    @SerializedName("is_profile_complete") val isProfileComplete: Boolean
)

data class UserDto(
    @SerializedName("id") val id: Int,
    @SerializedName("name") val name: String,
    @SerializedName("email") val email: String,
    @SerializedName("role") val role: String,
    @SerializedName("kelas") val kelas: String?,
    @SerializedName("avatar") val avatar: String?,
    @SerializedName("nis") val nis: String?,
    @SerializedName("nisn") val nisn: String?,
    @SerializedName("nip") val nip: String?
)

// 3. Books & Categories
data class CategoryDto(
    @SerializedName("id") val id: Int,
    @SerializedName("nama") val nama: String,
    @SerializedName("slug") val slug: String,
    @SerializedName("tipe") val tipe: String,
    @SerializedName("icon") val icon: String?,
    @SerializedName("books_count") val booksCount: Int?
)

data class PaginatedBooks(
    @SerializedName("current_page") val currentPage: Int,
    @SerializedName("data") val data: List<BookDto>,
    @SerializedName("last_page") val lastPage: Int,
    @SerializedName("total") val total: Int
)

data class BookDto(
    @SerializedName("id") val id: Int,
    @SerializedName("category_id") val categoryId: Int?,
    @SerializedName("judul") val judul: String,
    @SerializedName("slug") val slug: String,
    @SerializedName("penulis") val penulis: String,
    @SerializedName("penerbit") val penerbit: String?,
    @SerializedName("tingkat_kelas") val tingkatKelas: Int?,
    @SerializedName("total_halaman") val totalHalaman: Int?,
    @SerializedName("rating") val rating: String?,
    @SerializedName("total_dibaca") val totalDibaca: Int,
    @SerializedName("cover_url") val coverUrl: String?,
    @SerializedName("pdf_url") val pdfUrl: String?,
    @SerializedName("deskripsi") val deskripsi: String?,
    @SerializedName("category") val category: CategoryDto?
)

// 4. Reading Tracker
data class TrackReadRequest(
    @SerializedName("log_id") val logId: Int? = null,
    @SerializedName("duration_seconds") val durationSeconds: Int,
    @SerializedName("page_number") val pageNumber: Int,
    @SerializedName("platform") val platform: String = "mobile"
)

data class TrackReadResult(
    @SerializedName("total_dibaca") val totalDibaca: Int,
    @SerializedName("log_id") val logId: Int
)

// 5. Guru / Wali Kelas
data class TeacherOverviewData(
    @SerializedName("has_assigned_class") val hasAssignedClass: Boolean,
    @SerializedName("current_class") val currentClass: ClassInfoDto?,
    @SerializedName("teacher_assigned_class") val teacherAssignedClass: String?,
    @SerializedName("stats") val stats: ClassStatsDto,
    @SerializedName("leaderboard") val leaderboard: List<StudentReaderDto>,
    @SerializedName("students") val students: List<StudentReaderDto>
)

data class ClassInfoDto(
    @SerializedName("code") val code: String,
    @SerializedName("name") val name: String,
    @SerializedName("grade") val grade: Int,
    @SerializedName("sub") val sub: String
)

data class ClassStatsDto(
    @SerializedName("total_students") val totalStudents: Int,
    @SerializedName("active_students") val activeStudents: Int,
    @SerializedName("average_progress") val averageProgress: Int,
    @SerializedName("total_books_read") val totalBooksRead: Int,
    @SerializedName("total_duration_minutes") val totalDurationMinutes: Int
)

data class StudentReaderDto(
    @SerializedName("id") val id: Int,
    @SerializedName("name") val name: String,
    @SerializedName("avatar") val avatar: String?,
    @SerializedName("kelas") val kelas: String?,
    @SerializedName("nis") val nis: String?,
    @SerializedName("nisn") val nisn: String?,
    @SerializedName("rank") val rank: Int?,
    @SerializedName("badge") val badge: String?,
    @SerializedName("books_count") val booksCount: Int,
    @SerializedName("total_duration_minutes") val totalDurationMinutes: Int,
    @SerializedName("avg_progress") val avgProgress: Int,
    @SerializedName("status_today") val statusToday: String,
    @SerializedName("status_today_label") val statusTodayLabel: String,
    @SerializedName("today_duration_minutes") val todayDurationMinutes: Int,
    @SerializedName("last_book") val lastBook: String?
)
```

---

## 8. Setup Backend untuk Rekan Pengembang (Git Pull & Migrasi)

Bagi rekan yang baru saja melakukan `git pull` dari repositori backend:

1. **Ambil Pembaharuan Git**:
   ```bash
   git pull origin main
   ```
2. **Pasang Dependensi & Jalankan Migrasi**:
   ```bash
   composer install
   php artisan migrate
   ```
3. **Pastikan Symlink Storage Aktif (Untuk Cover & Avatar)**:
   ```bash
   php artisan storage:link
   ```
4. **Jalankan Server dengan Binding Semua Network (Host 0.0.0.0)**:
   Agar dapat diakses oleh HP fisik / emulator:
   ```bash
   php artisan serve --host=0.0.0.0 --port=8000
   ```

---

## 9. Konfigurasi Emulator & Network Security

### A. Alamat IP Host
- **Android Emulator**: Gunakan `http://10.0.2.2:8000/api`
- **Device Fisik (HP Asli)**: Gunakan `http://<IP_WIFI_LAPTOP>:8000/api` (Pastikan laptop dan HP dalam satu jaringan Wi-Fi).

### B. Network Security Config (HTTP Development)
Buat file `res/xml/network_security_config.xml`:
```xml
<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
    <domain-config cleartextTrafficPermitted="true">
        <domain includeSubdomains="true">10.0.2.2</domain>
        <domain includeSubdomains="true">192.168.1.0</domain>
        <domain includeSubdomains="true">localhost</domain>
    </domain-config>
</network-security-config>
```

---

## 10. Checklist Pengujian Aplikasi (QA)

| No | Kasus Uji | Ekspektasi | Status |
| :-: | :--- | :--- | :-: |
| 1 | Registrasi Akun Siswa | Akun terbuat, token disimpan, diarahkan melengkapi profil jika belum | ✅ Siap |
| 2 | Login Google One-Tap | Support token Firebase, avatar Google terambil otomatis | ✅ Siap |
| 3 | Lupa Password & Verifikasi OTP | Kode 6-digit terkirim ke email, berhasil diverifikasi & password baru aktif | ✅ Siap |
| 4 | Profil Siswa (NIS & NISN) | Dapat menyimpan NIS dan NISN, foto profil dapat diunggah / direset | ✅ Siap |
| 5 | Filter Katalog Buku | Kategori Bahasa Indonesia, Matematika, IPAS, dsb. berfungsi akurat | ✅ Siap |
| 6 | E-Reader & Watermark | PDF tampil dengan watermark nama siswa, gesture swipe membalik halaman | ✅ Siap |
| 7 | Idle Detector E-Reader | Timer terjeda otomatis jika layar tidak disentuh > 60 detik | ✅ Siap |
| 8 | Sinkronisasi Durasi Baca | `POST track-read` terkirim tiap 30 detik tanpa menggandakan baris di database | ✅ Siap |
| 9 | Dasbor Guru (Wali Kelas) | Menampilkan statistik kelas binaan, peringkat literasi, dan status harian | ✅ Siap |
| 10 | Logout Akun | Sesi terhapus di backend dan token lokal dibersihkan | ✅ Siap |