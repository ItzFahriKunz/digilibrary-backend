# 📱 Panduan Pengembangan Android (Kotlin) - Digilibrary SD
> **Perpustakaan Digital Sekolah Dasar Berstandar Kurikulum Merdeka & SIBI Kemendikdasmen**  
> Repositori panduan teknis, spesifikasi antarmuka Jetpack Compose, integrasi REST API, dan tata kelola peran (Role Siswa & Guru).

Bagi rekan developer yang ingin mempelajari gambaran besar arsitektur, diagram alur, dan struktur relasi database sistem, silakan baca:  
👉 **[📐 ReadmeAlurSistem.md (Use Case, Flowchart, Flow Map, ERD & Komponen)](./ReadmeAlurSistem.md)**

---

## 📑 Daftar Isi
1. [Ringkasan Proyek & Konsep Role](#1-ringkasan-proyek--konsep-role)
2. [Design System & Panduan Tampilan UI](#2-design-system--panduan-tampilan-ui)
3. [Navigasi & Dynamic Role Bottom Bar](#3-navigasi--dynamic-role-bottom-bar)
4. [Spesifikasi Fitur Utama E-Reader](#4-spesifikasi-fitur-utama-e-reader)
5. [Kontrak Endpoint REST API Backend](#5-kontrak-endpoint-rest-api-backend)
6. [Rekomendasi Tech Stack & Dependensi Gradle](#6-rekomendasi-tech-stack--dependensi-gradle)
7. [Konfigurasi Emulator & Network Security](#7-konfigurasi-emulator--network-security)
8. [Checklist Pengujian Aplikasi (QA)](#8-checklist-pengujian-aplikasi-qa)

---

## 1. Ringkasan Proyek & Konsep Role

Digilibrary SD adalah aplikasi perpustakaan digital khusus anak Sekolah Dasar (SD) dengan katalog buku resmi dari SIBI Kemendikdasmen (Buku Pelajaran Kurikulum Merdeka, Buku Bacaan Bergambar, Cerita Fabel).

### 👥 Aturan Peran (Role Handling) di Mobile:
1. **Siswa (Pengguna Utama)**:
   - Login menggunakan akun Google (Firebase One-Tap) atau Email/Password.
   - Pendaftaran baru otomatis mendapatkan peran **`role = "siswa"`**.
   - Pada login pertama kali, wajib melengkapi data nama & memilih tingkatan kelas (Kelas 1 s/d Kelas 6 SD).
   - Membaca buku secara interaktif dengan pelacakan waktu membaca aktif (*Live Reading Tracker*).
2. **Guru / Wali Kelas**:
   - Diberikan kewenangan peran **`role = "guru"`** oleh Admin Sekolah via panel Web.
   - Memiliki semua kemampuan Siswa ditambah tab ekstra: **"Pantau Kelas"**.
   - Tab Pantau Kelas menampilkan daftar murid kelas ampuannya, status membaca hari ini, dan total menit membaca mingguan.
3. **Admin Sekolah**:
   - Berstatus **`role = "admin"`**. Dikelola khusus melalui Web Browser Desktop. Jika login di mobile, tampilkan notifikasi bahwa fitur manajemen perpustakaan diakses melalui Web.

---

## 2. Design System & Panduan Tampilan UI

Tampilan aplikasi Android wajib mengusung nuansa **ramah anak, cerah, modern, dan seirama dengan desain Web**.

### A. Palet Warna (Color Tokens)
Gunakan token warna berikut pada `ui/theme/Color.kt`:

| Token | Hex Code | Penggunaan |
| :--- | :--- | :--- |
| `PrimaryEmerald` | `#10A871` / `#2BA76E` | Tombol utama, tab aktif, ikon primer |
| `HeroGradientStart` | `#16A34A` | Titik awal gradien hero section atas |
| `HeroGradientEnd` | `#064E3B` | Titik akhir gradien hero section bawah |
| `CategoryGradientStart` | `#19BC71` (16%) | Gradien kartu kategori bacaan |
| `CategoryGradientEnd` | `#1B9A60` (77%) | Gradien kartu kategori bacaan |
| `BackgroundLight` | `#FDFDFD` / `#F8FAF9` | Latar belakang layar & form input |
| `AccentMintLight` | `#3DD68C` / `#7DF3BA` | Teks sorotan pada banner hijau |
| `BorderDivider` | `#D8E6DE` | Border card, outline input text, divider |
| `TextPrimary` | `#1A1A1A` | Judul buku, headline utama |
| `TextSecondary` | `#5C6B64` | Subtitle, nama penulis, sinopsis cerita |
| `RatingStar` | `#F59E0B` | Bintang rating ulasan buku |
| `SoftRed` | `#EF4444` | Notifikasi status belum membaca |

### B. Tipografi
- **Headline & Judul**: Gunakan font *Outfit* atau font Sans-Serif modern berbobot *SemiBold / Bold*.
- **Body & Metadata**: Gunakan font *Inter* atau *Roboto* dengan *line-height* yang lega agar mudah dibaca oleh anak SD.

### C. Dimensi & Gaya Komponen (Jetpack Compose)
1. **Kartu Buku (Book Card)**:
   - Bentuk: `RoundedCornerShape(24.dp)`
   - Rasio Cover: `aspectRatio(3f / 4f)` dengan `ContentScale.Crop`
   - Badge Kelas: `RoundedCornerShape(6.dp)` di pojok cover buku
2. **Tombol CTA ("Mulai Membaca" / "Baca Buku Ini")**:
   - Bentuk: `RoundedCornerShape(16.dp)`
   - Tinggi: `50.dp` s/d `54.dp` (target sentuhan jempol besar ramah anak)
3. **Pill Kategori (Filter Row)**:
   - Bentuk: `RoundedCornerShape(50)` (Kapsul penuh)
   - State Aktif: Background `#2BA76E`, teks `#FFFFFF`
   - State Inaktif: Background `#F8FAF9`, border `1.dp` solid `#D8E6DE`, teks `#5C6B64`

---

## 3. Navigasi & Dynamic Role Bottom Bar

Gunakan Navigation Compose dengan Bottom Bar dinamis yang disesuaikan dengan nilai `user.role` dari API:

```
├── Siswa Bottom Bar:
│   ├── [1] Beranda (Katalog & Banner Kategori)
│   ├── [2] Rak Buku (Buku Sedang Dibaca & Selesai)
│   └── [3] Profil (Data Diri, Kelas, Logout)
│
└── Guru Bottom Bar:
    ├── [1] Beranda (Katalog & Buku Panduan Guru)
    ├── [2] Rak Buku (Buku Favorit & Riwayat)
    ├── [3] Pantau Kelas (Rekapitulasi Murid Kelas Wali) ⭐ (Khusus Guru)
    └── [4] Profil (Data Diri, Kelas Ampuan, Logout)
```

---

## 4. Spesifikasi Fitur Utama E-Reader

### 1. PDF Canvas & Anti-Pembajakan (Dynamic Watermark)
- Gunakan library native Android PDF Viewer (misal: `AndroidPdfViewer`).
- Lapisi kanvas PDF dengan layer transparan (*Canvas drawText*) miring 45 derajat berulang berisi teks:  
  `"Digilibrary SD • [Nama Siswa] • [Email Siswa] • [Tanggal]"` (Opacity 15%).
- Matikan screenshot jika diperlukan via `window.setFlags(FLAG_SECURE, FLAG_SECURE)`.

### 2. Live Reading Tracker & Idle Detector (Anti-Curang)
Untuk memastikan data literasi membaca valid dan bukan manipulasi:
1. **Active Timer (1 Detik)**: Berjalan saat layar buku aktif.
2. **Idle Detector (60 Detik)**:
   - Setiap sentuhan layar / gestur membalik halaman mereset penghitung idle (`idle_counter = 0`).
   - Jika layar tidak disentuh selama **> 60 detik**, timer aktif otomatis **di-pause** dan muncul notifikasi *"Sesi membaca dijeda karena layar tidak disentuh"*.
3. **Sinkronisasi Periodik**:
   - Setiap akumulasi 30–60 detik aktif, kirim request background ke endpoint `POST /api/books/{id}/track-read`.
   - Saat siswa menutup buku / menekan tombol kembali, kirim sinkronisasi data terakhir.

---

## 5. Kontrak Endpoint REST API Backend

Base URL Lokal Emulator: `http://10.0.2.2:8000/api`  
Semua request terproteksi wajib menyertakan header:  
`Authorization: Bearer <TOKEN>` dan `Accept: application/json`.

---

### A. Autentikasi (`/api/auth`)

#### 1. Login dengan Google One-Tap
* **Endpoint**: `POST /api/auth/google`
* **Request Body**:
  ```json
  {
    "id_token": "eyJhbGciOiJSUzI1NiIsImtpZCI...",
    "avatar": "https://lh3.googleusercontent.com/a/..."
  }
  ```
* **Response (200 OK)**:
  ```json
  {
    "status": "success",
    "token": "1|qwe879asdasd87687asd...",
    "user": {
      "id": 14,
      "name": "Budi Pratama",
      "email": "budi.pratama@gmail.com",
      "avatar": "https://lh3.googleusercontent.com/...",
      "role": "siswa",
      "kelas": "Kelas 4",
      "is_profile_complete": true
    }
  }
  ```

#### 2. Login dengan Email & Password
* **Endpoint**: `POST /api/auth/login`
* **Request Body**:
  ```json
  {
    "email": "siswa@sekolah.sch.id",
    "password": "password123"
  }
  ```

#### 3. Lengkapi Profil (Untuk User Baru)
* **Endpoint**: `PUT /api/auth/complete-profile`
* **Request Body**:
  ```json
  {
    "name": "Budi Pratama",
    "kelas": "Kelas 4"
  }
  ```
* **Response (200 OK)**:
  ```json
  {
    "status": "success",
    "message": "Profil berhasil diperbarui",
    "user": {
      "id": 14,
      "name": "Budi Pratama",
      "kelas": "Kelas 4",
      "is_profile_complete": true
    }
  }
  ```

#### 4. Ambil Info Pengguna Aktif
* **Endpoint**: `GET /api/auth/me`
* **Response (200 OK)**:
  ```json
  {
    "status": "success",
    "user": {
      "id": 14,
      "name": "Budi Pratama",
      "email": "budi@gmail.com",
      "role": "siswa",
      "kelas": "Kelas 4",
      "is_profile_complete": true
    }
  }
  ```

---

### B. Katalog Buku & E-Reader (`/api/books` & `/api/categories`)

#### 1. Daftar Kategori
* **Endpoint**: `GET /api/categories`
* **Response (200 OK)**:
  ```json
  [
    {
      "id": 1,
      "nama": "Pelajaran SD",
      "slug": "pelajaran-sd",
      "tipe": "pelajaran",
      "icon": "book-open"
    },
    {
      "id": 2,
      "nama": "Cerita Fabel",
      "slug": "cerita-fabel",
      "tipe": "bacaan",
      "icon": "sparkles"
    }
  ]
  ```

#### 2. Daftar Katalog Buku
* **Endpoint**: `GET /api/books?kategori=1&tingkat_kelas=4&search=matematika&page=1`
* **Response (200 OK)**:
  ```json
  {
    "current_page": 1,
    "data": [
      {
        "id": 5,
        "judul": "Matematika untuk SD/MI Kelas IV",
        "slug": "matematika-kelas-iv",
        "penulis": "Hobri, dkk.",
        "penerbit": "Kementerian Pendidikan, Kebudayaan, Riset, dan Teknologi",
        "tingkat_kelas": 4,
        "cover_url": "http://10.0.2.2:8000/storage/covers/matematika_4.jpg",
        "rating": "4.90",
        "total_dibaca": 128
      }
    ],
    "last_page": 3,
    "total": 36
  }
  ```

#### 3. Detail Lengkap Buku
* **Endpoint**: `GET /api/books/{id}`
* **Response (200 OK)**:
  ```json
  {
    "id": 5,
    "judul": "Matematika untuk SD/MI Kelas IV",
    "penulis": "Hobri, dkk.",
    "deskripsi": "Buku teks utama pembelajaran matematika Kurikulum Merdeka...",
    "tingkat_kelas": 4,
    "total_halaman": 192,
    "cover_url": "http://10.0.2.2:8000/storage/covers/matematika_4.jpg",
    "pdf_url": "http://10.0.2.2:8000/storage/books/matematika_4.pdf",
    "last_read_page": 14,
    "total_duration_minutes": 25
  }
  ```

#### 4. Catat Sesi Membaca Aktif (Tracking)
* **Endpoint**: `POST /api/books/{id}/track-read`
* **Dual Field Naming Support**: Controller backend mendukung penamaan field bahasa Indonesia maupun bahasa Inggris secara fleksibel:
  * **Durasi Baca**: Menggunakan `duration_seconds` atau `durasi_detik` (tipe `integer`, detik).
  * **Halaman Terakhir**: Menggunakan `page_number` atau `halaman_terakhir` (tipe `integer`).
  * **Platform**: Nilai `"mobile"` atau `"web"`.
  * **ID Sesi (Opsional)**: `log_id` (tipe `integer`), didapatkan dari respons permintaan pertama.

* **Request Body (Sesi Pertama / Saat Mulai Membaca)**:
  ```json
  {
    "duration_seconds": 30,
    "page_number": 5,
    "platform": "mobile"
  }
  ```
  *(Atau format bahasa Indonesia: `{"durasi_detik": 30, "halaman_terakhir": 5, "platform": "mobile"}`)*

* **Response (200 OK)**:
  ```json
  {
    "status": "success",
    "message": "Sesi membaca berhasil dicatat",
    "data": {
      "total_dibaca": 12,
      "log_id": 565
    }
  }
  ```

* **Request Body (Sinkronisasi Periodik / Kelipatan 30 Detik & Saat Menutup Buku)**:
  Simpan `data.log_id` dari respons sebelumnya, lalu kirimkan di interval berikutnya. Server otomatis memperbarui sesi berjalan (`durasi_detik = max(durasi_lama, durasi_baru)`) tanpa membuat baris baru atau menggandakan `total_dibaca`:
  ```json
  {
    "log_id": 565,
    "duration_seconds": 60,
    "page_number": 8,
    "platform": "mobile"
  }
  ```

---

### C. Khusus Wali Kelas / Guru (`/api/guru`)

#### 1. Ringkasan Pantauan Kelas
* **Endpoint**: `GET /api/guru/overview?kelas=Kelas 4`
* **Response (200 OK)**:
  ```json
  {
    "kelas": "Kelas 4",
    "total_siswa": 28,
    "siswa_aktif_hari_ini": 19,
    "total_durasi_minggu_ini_menit": 1420,
    "daftar_siswa": [
      {
        "id": 14,
        "name": "Budi Pratama",
        "avatar": "https://lh3.googleusercontent.com/...",
        "status_hari_ini": "Sudah Membaca",
        "durasi_hari_ini_menit": 25,
        "buku_terakhir": "Kancil dan Buaya"
      },
      {
        "id": 18,
        "name": "Siti Rahma",
        "avatar": null,
        "status_hari_ini": "Belum Membaca",
        "durasi_hari_ini_menit": 0,
        "buku_terakhir": "-"
      }
    ]
  }
  ```

---

## 6. Rekomendasi Tech Stack & Dependensi Gradle

Tambahkan dependensi berikut pada `app/build.gradle.kts`:

```kotlin
dependencies {
    // Jetpack Compose & Material 3
    implementation(platform("androidx.compose:compose-bom:2024.06.00"))
    implementation("androidx.compose.ui:ui")
    implementation("androidx.compose.material3:material3")
    implementation("androidx.navigation:navigation-compose:2.7.7")

    // Networking (Retrofit 2 & OkHttp)
    implementation("com.squareup.retrofit2:retrofit:2.11.0")
    implementation("com.squareup.retrofit2:converter-gson:2.11.0")
    implementation("com.squareup.okhttp3:logging-interceptor:4.12.0")

    // Image Loading (Coil)
    implementation("io.coil-kt:coil-compose:2.6.0")

    // PDF Viewer Native Android
    implementation("com.github.barteksc:android-pdf-viewer:3.2.0-beta.1")

    // Penyimpanan Kredensial Aman (Encrypted SharedPreferences)
    implementation("androidx.security:security-crypto:1.1.0-alpha06")

    // Google Sign-In & Firebase Auth
    implementation("com.google.android.gms:play-services-auth:21.2.0")
    implementation(platform("com.google.firebase:firebase-bom:33.1.2"))
    implementation("com.google.firebase:firebase-auth-ktx")
}
```

---

## 7. Konfigurasi Emulator & Network Security

### A. Alamat IP Host
- **Android Emulator**: Gunakan `http://10.0.2.2:8000/api`
- **Device Fisik (HP Asli)**: Gunakan `http://<IP_WIFI_LAPTOP>:8000/api` (Pastikan laptop dan HP dalam satu Wi-Fi yang sama).

### B. Network Security Config (HTTP Development)
Buat file `res/xml/network_security_config.xml`:
```xml
<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
    <domain-config cleartextTrafficPermitted="true">
        <domain includeSubdomains="true">10.0.2.2</domain>
        <domain includeSubdomains="true">192.168.1.0</domain>
    </domain-config>
</network-security-config>
```
Lalu cantumkan di `AndroidManifest.xml`:
```xml
<application
    android:networkSecurityConfig="@xml/network_security_config"
    android:usesCleartextTraffic="true" ...>
```

---

## 8. Checklist Pengujian Aplikasi (QA)

| No | Kasus Uji | Ekspektasi | Status |
| :-: | :--- | :--- | :-: |
| 1 | Login Google pertama kali | Muncul form input Nama & Pilihan Kelas (Fase A-C) | ⬜ |
| 2 | Verifikasi Role Siswa | Masuk ke Beranda dengan 3 tab (Beranda, Rak, Profil) | ⬜ |
| 3 | Verifikasi Role Guru | Masuk ke Beranda dengan 4 tab (+ Pantau Kelas) | ⬜ |
| 4 | Membuka E-Reader PDF | File PDF tampil lancar dengan watermark nama siswa | ⬜ |
| 5 | Idle Detector | Layar diam > 60 detik otomatis menjeda counter timer | ⬜ |
| 6 | Pelacakan Durasi Baca | Request `POST track-read` terkirim setiap 30 detik aktif | ⬜ |
| 7 | Dashboard Pantau Guru | Menampilkan daftar siswa kelas yang sudah/belum membaca | ⬜ |
| 8 | Logout Akun | Token sesi di-clear dan diarahkan kembali ke layar Login | ⬜ |
