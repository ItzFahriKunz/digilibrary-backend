# 📘 Buku Panduan Arsitektur & Desain Sistem - Digilibrary SD
> **Dokumen Referensi Perancangan Diagram Rekayasa Perangkat Lunak**  
> Disusun khusus sebagai panduan pembuatan **Use Case Diagram, Flowchart, Flow Map, Data Flow Diagram (DFD), dan Entity Relationship Diagram (ERD)** yang diekstraksi langsung dari implementasi nyata sistem **Digilibrary SD** (Backend Laravel & Mobile Android Kotlin).

---

## 📑 Daftar Isi
1. [Bedah Sistem: Fitur & Modul Nyata Digilibrary SD](#1-bedah-sistem-fitur--modul-nyata-digilibrary-sd)
2. [Panduan 1: Use Case Diagram](#2-panduan-1-use-case-diagram)
   - [Komponen Penyusun Use Case](#a-komponen-penyusun-use-case)
   - [Daftar Kasus Penggunaan (Use Case List)](#b-daftar-kasus-penggunaan-use-case-list)
   - [Diagram Visual Use Case (Mermaid)](#c-diagram-visual-use-case)
   - [Skenario Use Case Utama (Use Case Specifications)](#d-skenario-use-case-utama)
3. [Panduan 2: Flowchart (Diagram Alir Aktivitas)](#3-panduan-2-flowchart-diagram-alir-aktivitas)
   - [Simbol & Komponen Standar Flowchart](#a-simbol--komponen-standar-flowchart)
   - [Flowchart 1: Autentikasi & Dynamic Role Navigation](#b-flowchart-1-autentikasi--dynamic-role-navigation)
   - [Flowchart 2: Eksplorasi Katalog & Membaca E-Book](#c-flowchart-2-eksplorasi-katalog--membaca-e-book)
   - [Flowchart 3: Live Reading Tracker & Idle Detector (Anti-Curang)](#d-flowchart-3-live-reading-tracker--idle-detector)
   - [Flowchart 4: Pemantauan Kelas oleh Wali Kelas](#e-flowchart-4-pemantauan-kelas-oleh-wali-kelas)
4. [Panduan 3: Flow Map (Bagan Alir Dokumen & Prosedur)](#4-panduan-3-flow-map-bagan-alir-dokumen--prosedur)
   - [Simbol & Komponen Standar Flow Map](#a-simbol--komponen-standar-flow-map)
   - [Pembagian Entitas / Kolom Swimlane](#b-pembagian-entitas--kolom-swimlane)
   - [Flow Map 1: Prosedur Registrasi & Pengisian Profil Kelas](#c-flow-map-1-prosedur-registrasi--profil-kelas)
   - [Flow Map 2: Prosedur Peminjaman/Membaca Buku Digital](#d-flow-map-2-prosedur-membaca-buku-digital)
   - [Flow Map 3: Prosedur Monitoring & Pelaporan Literasi Siswa](#e-flow-map-3-prosedur-monitoring--pelaporan-literasi)
5. [Panduan 4: Data Flow Diagram (DFD)](#5-panduan-4-data-flow-diagram-dfd)
   - [Simbol & Komponen Standar DFD (Notasi Gane & Sarson / Yourdon)](#a-simbol--komponen-standar-dfd)
   - [DFD Level 0: Diagram Konteks (Context Diagram)](#b-dfd-level-0-diagram-konteks)
   - [DFD Level 1: Dekomposisi Proses Utama](#c-dfd-level-1-dekomposisi-proses-utama)
   - [Kamus Data (Data Dictionary) Aliran Data](#d-kamus-data-data-dictionary-aliran-data)
6. [Panduan 5: Entity Relationship Diagram (ERD)](#6-panduan-5-entity-relationship-diagram-erd)
   - [Komponen Penyusun ERD](#a-komponen-penyusun-erd)
   - [Struktur Tabel Nyata Database MySQL](#b-struktur-tabel-nyata-database-mysql)
   - [Diagram Relasi ERD Visual (Crow's Foot)](#c-diagram-relasi-erd-visual)
   - [Matriks Kardinalitas & Integritas Relasional](#d-matriks-kardinalitas--integritas-relasional)
7. [Panduan Praktis Pemindahan ke Draw.io / Visio / Word](#7-panduan-praktis-pemindahan-ke-drawio--visio--word)

---

## 1. Bedah Sistem: Fitur & Modul Nyata Digilibrary SD

Digilibrary SD adalah platform perpustakaan digital khusus Sekolah Dasar yang menyajikan buku resmi SIBI Kemendikdasmen (Kurikulum Merdeka). Sistem ini memiliki 3 entitas pengguna dengan fungsi yang berbeda:

### A. Tiga Aktor Utama
1. **👨‍🎓 Siswa SD**:
   - Masuk menggunakan Google One-Tap (Firebase) atau Email/Password.
   - Pendaftaran akun baru otomatis menghasilkan `role = "siswa"`.
   - Mengisi profil wajib (Nama Lengkap & Pilihan Kelas 1 s/d 6 SD).
   - Menjelajahi buku menurut 5 kategori SIBI dan tingkat kelas.
   - Membaca e-book di E-Reader dengan watermark nama anti-pembajakan.
   - Aktivitas durasi membaca dicatat otomatis via *Live Reading Tracker* yang memiliki sensor diam (*Idle Detector*).
   - Melihat rak buku, riwayat baca, dan progres persentase halaman.
2. **👩‍🏫 Guru / Wali Kelas**:
   - Berstatus `role = "guru"` (ditetapkan oleh Admin Sekolah).
   - Memilih/mengatur kelas yang diampu (misal: "Kelas 4").
   - Memiliki seluruh fitur Siswa (membaca buku siswa & buku panduan guru).
   - Memiliki fitur khusus **"Pantau Kelas"**: melihat daftar murid di kelasnya, memantau siapa yang sudah membaca hari ini, durasi menit membaca, dan buku terakhir yang dibaca.
3. **👨‍💼 Admin Sekolah**:
   - Berstatus `role = "admin"`.
   - Mengakses Dashboard Web Desktop untuk:
     - CRUD Data Buku SIBI (unggah PDF, cover, sinopsis, tingkat kelas, kategori).
     - CRUD Pengguna (membuat akun, ubah role siswa menjadi guru, reset password).
     - Melihat statistik perpustakaan (total buku, total pembaca, grafik baca).

---

## 2. Panduan 1: Use Case Diagram

Use Case Diagram menggambarkan fungsionalitas sistem dari sudut pandang pengguna eksternal (aktor).

### A. Komponen Penyusun Use Case
Saat menggambar di Draw.io / StarUML / Visio, gunakan 4 komponen berikut:
1. **Actor (Aktor)**: Disimbolkan dengan *Stick Figure*. Merepresentasikan pihak yang berinteraksi dengan sistem (Siswa, Guru, Admin, Google Auth API).
2. **Use Case**: Disimbolkan dengan bentuk *Oval*. Merepresentasikan fungsi/layanan spesifik yang diawali kata kerja (contoh: *Melakukan Login*, *Membaca Buku Digital*).
3. **System Boundary**: Disimbolkan dengan *Kotak Persegi Panjang* besar yang membungkus semua use case, dengan judul sistem di bagian atas. Aktor diletakkan di **luar** kotak.
4. **Relasi (Relationships)**:
   - **Association (Asosiasi)**: Garis lurus tanpa panah yang menghubungkan Aktor dengan Use Case yang diaksesnya.
   - **`<<include>>`**: Panah putus-putus terbuka bertuliskan `<<include>>`. Menandakan bahwa use case sumber **pasti dan wajib** menjalankan use case tujuan (Contoh: *Membaca Buku* `<<include>>` *Menjalankan Live Reading Tracker*).
   - **`<<extend>>`**: Panah putus-putus bertuliskan `<<extend>>`. Menandakan use case yang bersifat opsional/kondisional (Contoh: *Login Sistem* `<<extend>>` *Melengkapi Profil Siswa Baru*).

---

### B. Daftar Kasus Penggunaan (Use Case List)

| ID | Nama Use Case | Aktor Terlibat | Tipe Relasi | Keterangan Fungsional |
| :--- | :--- | :--- | :---: | :--- |
| **UC-01** | Autentikasi Pengguna (Login) | Siswa, Guru, Admin | - | Masuk via Google One-Tap atau Email & Password. |
| **UC-02** | Lengkapi Profil Akun | Siswa, Guru | `<<extend>>` UC-01 | Pengisian nama & jenjang kelas saat login pertama. |
| **UC-03** | Reset Password via OTP | Siswa, Guru | - | Meminta kode OTP email untuk memulihkan password. |
| **UC-04** | Jelajahi Katalog Buku SIBI | Siswa, Guru | - | Melihat daftar buku berdasarkan 5 kategori & tingkat kelas. |
| **UC-05** | Pencarian Buku | Siswa, Guru | - | Mencari buku berdasarkan judul, penulis, atau kata kunci. |
| **UC-06** | Membaca Buku Digital (E-Reader) | Siswa, Guru | - | Membuka kanvas PDF dan membaca halaman per halaman. |
| **UC-07** | Terapkan Watermark Proteksi | Sistem | `<<include>>` UC-06 | Menimpa identitas siswa di atas kanvas PDF secara otomatis. |
| **UC-08** | Lacak Durasi Baca Aktif | Sistem | `<<include>>` UC-06 | Menghitung waktu aktif dengan sensor auto-pause 60s. |
| **UC-09** | Kelola Rak Buku & Riwayat | Siswa, Guru | - | Melihat daftar buku yang sedang dibaca dan progres halaman. |
| **UC-10** | Atur Kelas Ampuan Guru | Guru | - | Menentukan kelas yang menjadi tanggung jawab wali kelas. |
| **UC-11** | Pantau Aktivitas Literasi Kelas | Guru | - | Melihat rekap siswa yang sudah membaca hari ini. |
| **UC-12** | Kelola Master Data Buku SIBI | Admin | - | Tambah, ubah, hapus metadata dan file PDF buku. |
| **UC-13** | Kelola Akun & Hak Akses Pengguna | Admin | - | Mengubah role user, reset password, hapus user. |
| **UC-14** | Lihat Statistik Perpustakaan | Admin | - | Melihat total pembaca, buku terpopuler, dan grafik. |

---

### C. Diagram Visual Use Case

```mermaid
flowchart LR
    %% Actors
    subgraph Aktor_Sistem ["Aktor Pengguna"]
        Siswa((👨‍🎓 Siswa SD))
        Guru((👩‍🏫 Guru / Wali Kelas))
        Admin((👨‍💼 Admin Sekolah))
    end

    subgraph Boundary ["Sistem Digilibrary SD"]
        direction TB

        %% Auth Cluster
        UC_Login["UC-01: Autentikasi (Login)"]
        UC_Complete["UC-02: Lengkapi Profil Kelas"]
        UC_Forgot["UC-03: Reset Password via OTP"]

        %% Book Catalog Cluster
        UC_Catalog["UC-04: Jelajahi Katalog SIBI"]
        UC_Search["UC-05: Pencarian Buku"]
        UC_Reader["UC-06: Membaca E-Book"]
        UC_Watermark["UC-07: Proteksi Watermark"]
        UC_Tracker["UC-08: Pelacakan Durasi Aktif"]
        UC_Shelf["UC-09: Kelola Rak & Riwayat"]

        %% Guru Cluster
        UC_SetClass["UC-10: Atur Kelas Ampuan"]
        UC_Monitoring["UC-11: Pantau Aktivitas Kelas"]

        %% Admin Cluster
        UC_Books["UC-12: Kelola Master Buku"]
        UC_Users["UC-13: Kelola Pengguna & Role"]
        UC_Stats["UC-14: Lihat Statistik Sistem"]
    end

    %% Siswa Connections
    Siswa --- UC_Login
    Siswa --- UC_Forgot
    Siswa --- UC_Catalog
    Siswa --- UC_Search
    Siswa --- UC_Reader
    Siswa --- UC_Shelf

    %% Guru Connections
    Guru --- UC_Login
    Guru --- UC_Forgot
    Guru --- UC_Catalog
    Guru --- UC_Search
    Guru --- UC_Reader
    Guru --- UC_Shelf
    Guru --- UC_SetClass
    Guru --- UC_Monitoring

    %% Admin Connections
    Admin --- UC_Login
    Admin --- UC_Books
    Admin --- UC_Users
    Admin --- UC_Stats

    %% Includes & Extends
    UC_Login -.->|<<extend>>| UC_Complete
    UC_Reader -.->|<<include>>| UC_Watermark
    UC_Reader -.->|<<include>>| UC_Tracker
```

---

### D. Skenario Use Case Utama (Use Case Specifications)

Contoh 2 tabel spesifikasi use case yang wajib ada di laporan/skripsi:

#### 1. Skenario: UC-06 (Membaca Buku Digital & Pelacakan Aktif)
- **Aktor Utama**: Siswa SD
- **Deskripsi**: Siswa membuka buku digital pilihan dan membaca melalui PDF canvas dengan perekaman waktu membaca anti-curang.
- **Prekondisi**: Siswa telah berhasil login dan memilih buku dari katalog.
- **Postkondisi**: Durasi membaca bertambah pada `reading_logs`, counter `total_dibaca` buku naik, dan riwayat halaman tersimpan.
- **Skenario Normal (Main Flow)**:
  1. Siswa menekan tombol "Mulai Membaca" pada halaman detail buku.
  2. Sistem mengunduh/memuat berkas PDF resmi dari server.
  3. Sistem merender kanvas PDF dan menempelkan watermark nama, email, dan tanggal siswa.
  4. Sistem menginisialisasi timer membaca aktif (`active_timer = 0`, `idle_timer = 0`).
  5. Siswa membaca dan membalik halaman.
  6. Setiap ada sentuhan layar, sistem mereset `idle_timer = 0` dan menambah `active_timer + 1`.
  7. Setiap interval 30 detik aktif, sistem mengirim data durasi ke API backend di background.
  8. Siswa menekan tombol selesai/kembali.
  9. Sistem mengirim sinkronisasi durasi terakhir dan menyimpan nomor halaman terakhir dibaca.
- **Skenario Alternatif (Idle Detector Triggered)**:
  - Pada langkah 6, jika layar tidak disentuh selama > 60 detik:
    1. Sistem menjeda `active_timer`.
    2. Sistem memunculkan banner pemberitahuan bahwa sesi membaca dijeda.
    3. Ketika siswa menyentuh layar kembali, timer aktif melanjutkan hitungan.

#### 2. Skenario: UC-11 (Memantau Aktivitas Literasi Kelas)
- **Aktor Utama**: Guru / Wali Kelas
- **Deskripsi**: Wali kelas memantau keaktifan membaca murid-murid di kelas ampuannya hari ini.
- **Prekondisi**: Guru memiliki `role = "guru"` dan telah menentukan kelas ampuannya (misal: "Kelas 4").
- **Postkondisi**: Guru mendapatkan informasi real-time mengenai status literasi murid.
- **Skenario Normal**:
  1. Guru membuka tab navigasi "Pantau Kelas".
  2. Aplikasi mengirim permintaan `GET /api/guru/overview?kelas={nama_kelas}` dengan Bearer Token.
  3. Sistem mengumpulkan data murid terdaftar di kelas tersebut, mengagregasikan log membaca hari ini, dan menghitung total menit membaca minggu ini.
  4. Sistem menampilkan kartu ringkasan (Total Murid, Murid Sudah Membaca, Murid Belum Membaca).
  5. Guru dapat melihat detail nama murid beserta judul buku yang terakhir dibaca.

---

## 3. Panduan 2: Flowchart (Diagram Alir Aktivitas)

Flowchart menggambarkan urutan langkah logika, percabangan keputusan, dan proses komputasi dalam sistem.

### A. Simbol & Komponen Standar Flowchart
1. **Terminator (Oval / Kapsul)**: Menandai awal (`Mulai / Start`) dan akhir (`Selesai / End`) dari sebuah alur.
2. **Process (Persegi Panjang)**: Langkah pemrosesan data, kalkulasi, atau aksi sistem (contoh: *Hitung durasi + 1 detik*, *Simpan token*).
3. **Decision (Belah Ketupat / Diamond)**: Titik evaluasi kondisi logika yang menghasilkan cabang minimal 2 arah: `Ya / Tidak` atau `True / False`.
4. **Input / Output (Jajaran Genjang)**: Proses memasukkan data oleh pengguna atau menampilkan informasi (contoh: *Input email & password*, *Tampilkan katalog buku*).
5. **Predefined Process / Subrutin (Kotak Bergaris Samping Ganda)**: Memanggil prosedur yang sudah didefinisikan secara terpisah (contoh: *Panggil API Auth Google*).
6. **Connector (Lingkaran Kecil)**: Menyambungkan alur pada lembar yang sama.
7. **Flowline (Garis Berpanah)**: Menunjukkan arah jalannya instruksi dari satu simbol ke simbol berikutnya.

---

### B. Flowchart 1: Autentikasi & Dynamic Role Navigation
Menjelaskan logika saat aplikasi dibuka, login, validasi profil, dan pembagian menu peran:

```mermaid
flowchart TD
    A([Mulai]) --> B[/Buka Aplikasi Android/]
    B --> C{Ada Token Sesi Tersimpan?}

    C -- Ya --> D[Kirim Request: GET /api/auth/me]
    C -- Tidak --> E[/Tampilkan Layar Login/]

    E --> F{Pilih Metode Login}
    F -- "Google One-Tap" --> G[Autentikasi Firebase SDK]
    F -- "Email & Password" --> H[/Input Email & Password/]

    G --> I[Kirim: POST /api/auth/google]
    H --> J[Kirim: POST /api/auth/login]

    I --> K{Respon API 200 OK?}
    J --> K

    K -- Tidak (Gagal) --> L[/Tampilkan Notifikasi Error/] --> E
    K -- Ya (Sukses) --> M[Simpan Token di EncryptedStorage] --> D

    D --> N{Token Server Masih Valid?}
    N -- Tidak --> O[Hapus Token Lokal] --> E
    N -- Ya --> P{is_profile_complete == true?}

    P -- Tidak --> Q[/Form Lengkapi Profil: Input Nama & Pilih Kelas/]
    Q --> R[Kirim: PUT /api/auth/complete-profile] --> P

    P -- Ya --> S{Cek user.role}

    S -- "siswa" --> T[/Buka Dashboard Siswa:<br>• Tab Beranda<br>• Tab Rak Buku<br>• Tab Profil/]
    S -- "guru" --> U[/Buka Dashboard Guru:<br>• Tab Beranda<br>• Tab Rak Buku<br>• Tab Pantau Kelas<br>• Tab Profil/]
    S -- "admin" --> V[/Dialog: Akun Admin.<br>Silakan Akses Web Desktop/]

    T --> W([Selesai])
    U --> W
    V --> W
```

---

### C. Flowchart 2: Eksplorasi Katalog & Membaca E-Book
Menjelaskan alur saat murid mencari buku hingga membaca di kanvas PDF:

```mermaid
flowchart TD
    A([Mulai]) --> B[/Siswa Buka Tab Beranda/]
    B --> C[/Pilih Kategori atau Ketik Judul di Kolom Cari/]
    C --> D[Kirim: GET /api/books?kategori=X&search=Y]
    D --> E[Server Query Database MySQL]
    E --> F[/Tampilkan Grid Kartu Buku Berwarna/]
    
    F --> G[/Siswa Klik Salah Satu Kartu Buku/]
    G --> H[/Tampilkan Halaman Detail Buku & Sinopsis/]
    H --> I{Siswa Klik 'Mulai Membaca'?}
    
    I -- Tidak --> F
    I -- Ya --> J[Cek Berkas PDF di Cache Penyimpanan HP]
    
    J --> K{Berkas PDF Tersedia di Cache?}
    K -- Tidak --> L[Unduh File PDF dari Server] --> M
    K -- Ya --> M[Muat Berkas ke AndroidPdfViewer Canvas]
    
    M --> N[Terapkan Layer Watermark Nama & Tanggal Siswa]
    N --> O[Buka Nomor Halaman Terakhir yang Tersimpan]
    O --> P([Masuk ke Loop E-Reader])
```

---

### D. Flowchart 3: Live Reading Tracker & Idle Detector
Menjelaskan logika anti-curang pada waktu membaca aktif murid:

```mermaid
flowchart TD
    A([Mulai Sesi E-Reader]) --> B[Inisialisasi: timer_aktif = 0, idle_counter = 0]
    B --> C[Mulai Ticker Jam Setiap 1 Detik]
    
    C --> D{Ada Sentuhan Layar / Balik Halaman?}
    
    %% Jika Disentuh
    D -- Ya --> E[idle_counter = 0<br>timer_aktif = timer_aktif + 1]
    
    %% Jika Tidak Disentuh
    D -- Tidak --> F{idle_counter >= 60 Detik?}
    F -- Tidak --> G[idle_counter = idle_counter + 1<br>timer_aktif = timer_aktif + 1]
    F -- Ya (Diam Terlalu Lama) --> H[PAUSE TIMER AKTIF<br>Tampilkan Banner Jeda Membaca]
    
    H --> I{Layar Disentuh Kembali?}
    I -- Tidak --> H
    I -- Ya --> J[Tutup Banner Jeda] --> E
    
    E --> K{timer_aktif Kelipatan 30 Detik?}
    G --> K
    
    K -- Ya --> L[Kirim Background: POST /api/books/:id/track-read<br>payload: duration=30, page=curr_page]
    K -- Tidak --> M{Siswa Menutup Buku / Tekan Back?}
    L --> M
    
    M -- Tidak --> C
    M -- Ya --> N[Kirim Request Final Track Read ke Server]
    N --> O[Update Status Rak Buku Lokal]
    O --> P([Selesai Membaca])
```

---

### E. Flowchart 4: Pemantauan Kelas oleh Wali Kelas
Menjelaskan alur guru memantau keaktifan membaca murid kelasnya:

```mermaid
flowchart TD
    A([Mulai]) --> B[/Guru Klik Tab 'Pantau Kelas'/]
    B --> C[Cek Parameter Kelas Ampuan Guru di Profil]
    C --> D[Kirim: GET /api/guru/overview?kelas={nama_kelas}]
    D --> E[Server Mengambil Data Seluruh Siswa di Kelas Tersebut]
    E --> F[Server Menghitung Log Membaca Hari Ini & Minggu Ini]
    F --> G[/Tampilkan Kartu Statistik:<br>• Jumlah Siswa Aktif Hari Ini<br>• Total Jam Literasi Kelas/]
    G --> H[/Tampilkan Tabel Status Murid:<br>• Nama Siswa<br>• Status: Sudah/Belum Membaca<br>• Menit Membaca Hari Ini<br>• Judul Buku Terakhir/]
    H --> I([Selesai])
```

---

## 4. Panduan 3: Flow Map (Bagan Alir Dokumen & Prosedur)

Flow Map (Bagan Alir Sistem / Prosedur Dokumen) menggambarkan aliran fisik dokumen, data, dan aksi antar bagian/entitas dalam sistem.

### A. Simbol & Komponen Standar Flow Map
1. **Swimlane / Kolom Bagian**: Kolom vertikal yang membagi tanggung jawab tiap bagian (contoh: *Siswa/Guru*, *Aplikasi Android*, *API Server Laravel*, *Database MySQL*).
2. **Dokumen (Document)**: Bentuk persegi panjang dengan bagian bawah bergelombang. Merepresentasikan data formulir, token, berkas PDF, atau laporan fisik/digital.
3. **Proses Manual (Manual Operation)**: Bentuk trapesium terbalik. Merepresentasikan aktivitas fisik manusia (contoh: *Siswa membaca buku*, *Guru memeriksa nilai*).
4. **Proses Komputerisasi (Process)**: Persegi panjang biasa. Merepresentasikan proses komputasi sistem (contoh: *Verifikasi password*, *Hitung agregasi log*).
5. **Database / File Storage (Cylinder / Data Store)**: Silinder database relasional atau direktori penyimpanan berkas PDF.
6. **Arsip / Simpanan (Storage/Archive)**: Segitiga terbalik (arsip offline) atau silinder (basis data).
7. **Garis Alir & Konektor**: Panah yang menghubungkan alur dokumen antar kolom.

---

### B. Pembagian Entitas / Kolom Swimlane
Sistem Digilibrary SD memiliki 4 entitas kolom utama dalam Flow Map:
1. **Kolom 1: Aktor Pengguna** (Siswa SD / Guru Wali Kelas)
2. **Kolom 2: Antarmuka Klien** (Aplikasi Android Kotlin / Web Desktop)
3. **Kolom 3: Layanan Backend** (Laravel 11 REST API Controller & Sanctum)
4. **Kolom 4: Basis Data & Storage** (MySQL Relasional & Disk PDF Storage)

---

### C. Flow Map 1: Prosedur Registrasi & Profil Kelas
Menjelaskan aliran formulir pendaftaran dan validasi profil kelas baru:

```mermaid
sequenceDiagram
    autonumber
    actor Pengguna as 👨‍🎓 Siswa / Pengguna
    participant Klien as 📱 Aplikasi Android
    participant Server as 🌐 Backend API Laravel
    participant DB as 🗄️ Database MySQL

    Note over Pengguna, DB: Prosedur Registrasi & Pengisian Profil Kelas
    Pengguna->>Klien: Mengisi Form Registrasi (Nama, Email, Password)
    Klien->>Server: Mengirim HTTP POST /api/auth/register
    Server->>Server: Validasi Format Email & Enkripsi Password (Bcrypt)
    Server->>DB: INSERT INTO users (role: 'siswa', created_at)
    DB-->>Server: User ID Dibuat
    Server->>Server: Generate Personal Access Token (Sanctum)
    Server-->>Klien: Mengembalikan JSON Token & Data User
    Klien->>Klien: Menyimpan Token Sesi di Encrypted Storage

    Note over Pengguna, DB: Prosedur Lengkapi Profil Kelas Wajib
    Klien->>Pengguna: Menampilkan Form Pilih Kelas (Kelas 1 - 6 SD)
    Pengguna->>Klien: Memilih Kelas (contoh: "Kelas 4")
    Klien->>Server: Mengirim HTTP PUT /api/auth/complete-profile { kelas: "Kelas 4" }
    Server->>DB: UPDATE users SET kelas = 'Kelas 4' WHERE id = user_id
    DB-->>Server: Data Berhasil Diperbarui
    Server-->>Klien: 200 OK Profil Siap
    Klien->>Pengguna: Mengalihkan ke Halaman Beranda Siswa
```

---

### D. Flow Map 2: Prosedur Membaca Buku Digital
Menjelaskan alur permohonan file buku, verifikasi, rendering watermark, dan pencatatan log sesi baca:

```mermaid
sequenceDiagram
    autonumber
    actor Siswa as 👨‍🎓 Siswa SD
    participant App as 📱 E-Reader Android
    participant Backend as 🌐 REST API Laravel
    participant Storage as ☁️ Storage PDF SIBI
    participant DB as 🗄️ Database MySQL

    Siswa->>App: Menekan Tombol "Baca Buku Ini"
    App->>Backend: Request GET /api/books/{id} (Kirim Bearer Token)
    Backend->>DB: SELECT * FROM books WHERE id = {id}
    DB-->>Backend: Metadata Buku & File Path PDF
    Backend-->>App: JSON Detail Buku & Path Stream PDF
    App->>Storage: Mengunduh Berkas PDF Resmi
    Storage-->>App: Stream Data Binary PDF
    App->>App: Render PDF Canvas + Cetak Watermark Siswa
    App->>Siswa: Buku Siap Dibaca di Layar

    loop Setiap 30 Detik Membaca Aktif
        Siswa->>App: Aktivitas Membaca (Sentuh Layar)
        App->>App: Hitung Durasi Aktif (+30s)
        App->>Backend: POST /api/books/{id}/track-read { durasi: 30, page: 12, platform: 'mobile' }
        Backend->>DB: INSERT INTO reading_logs (user_id, book_id, durasi_detik, read_at)
        Backend->>DB: UPDATE books SET total_dibaca = total_dibaca + 1
        DB-->>Backend: Data Log Tersimpan
        Backend-->>App: 200 OK
    end

    Siswa->>App: Menekan Tombol Kembali / Selesai Membaca
    App->>Backend: POST /api/books/{id}/track-read (Kirim Sisa Detik & Hal Terakhir)
    Backend->>DB: Update Terakhir di reading_logs
    Backend-->>App: Sukses
    App->>Siswa: Menampilkan Halaman Rak Buku
```

---

### E. Flow Map 3: Prosedur Monitoring & Pelaporan Literasi
Menjelaskan aliran dokumen laporan aktivitas membaca murid ke wali kelas:

```mermaid
sequenceDiagram
    autonumber
    actor Guru as 👩‍🏫 Wali Kelas
    participant App as 📱 Tab Pantau Kelas
    participant API as 🌐 REST API Laravel
    participant DB as 🗄️ Database MySQL

    Guru->>App: Membuka Menu "Pantau Kelas"
    App->>API: GET /api/guru/overview?kelas=Kelas 4 (Kirim Token Guru)
    API->>DB: SELECT * FROM users WHERE kelas = 'Kelas 4' AND role = 'siswa'
    DB-->>API: Daftar 28 Murid Kelas 4
    API->>DB: Query reading_logs Siswa Kelas 4 Hari Ini & Minggu Ini
    DB-->>API: Rekapitulasi Durasi & Buku yang Dibaca
    API->>API: Agregasi: Siswa Aktif, Siswa Belum Baca, Total Jam Literasi
    API-->>App: JSON Rekapitulasi Kelas Lengkap
    App->>Guru: Menampilkan Rekap Kartu Murid & Leaderboard Kelas
```

---

## 5. Panduan 4: Data Flow Diagram (DFD)

Data Flow Diagram (DFD / DAD) menggambarkan arus pergerakan data dari entitas luar, melalui proses transformasi komputasi, menuju simpanan data (data store).

### A. Simbol & Komponen Standar DFD (Notasi Gane & Sarson / Yourdon)
1. **Entitas Luar (External Entity / Terminator)**: Disimbolkan dengan *Persegi Panjang*. Sumber atau tujuan data di luar batas sistem (Contoh: *Siswa*, *Guru*, *Admin*, *Google Auth API*).
2. **Proses (Process)**: Disimbolkan dengan *Lingkaran* (Notasi Yourdon) atau *Persegi Sudut Tumpul* (Notasi Gane & Sarson) dengan nomor identifikasi proses di bagian atas (Contoh: `1.0`, `2.0`, `3.0`).
3. **Simpanan Data (Data Store)**: Disimbolkan dengan *Dua Garis Paralel Horizontal* terbuka atau huruf `D` diikuti nomor (Contoh: `D1: users`, `D2: categories`, `D3: books`, `D4: reading_logs`).
4. **Aliran Data (Data Flow)**: Panah berlabel nama data yang mengalir (Contoh: *Data_Login*, *Data_Buku*, *Log_Membaca*).

---

### B. DFD Level 0: Diagram Konteks (Context Diagram)

Diagram Konteks memandang seluruh sistem Digilibrary SD sebagai satu kesatuan proses tunggal (`0.0 Sistem Informasi Digilibrary SD`) yang dihubungkan dengan seluruh entitas eksternal:

```mermaid
flowchart TD
    %% External Entities
    E_Siswa["👨‍🎓 Entitas: Siswa SD"]
    E_Guru["👩‍🏫 Entitas: Guru / Wali Kelas"]
    E_Admin["👨‍💼 Entitas: Admin Sekolah"]
    E_Google["🔐 Entitas: Google Firebase Auth"]

    %% Central Process
    P_System(("0.0<br>SISTEM INFORMASI<br>DIGILIBRARY SD"))

    %% Data Flows: Siswa
    E_Siswa -->|1. Data Akun & Pilihan Kelas| P_System
    E_Siswa -->|2. Kriteria Cari & Filter Buku| P_System
    E_Siswa -->|3. Data Durasi & Halaman Baca| P_System
    P_System -->|4. Berkas E-Book PDF & Watermark| E_Siswa
    P_System -->|5. Info Riwayat & Rak Buku| E_Siswa

    %% Data Flows: Guru
    E_Guru -->|6. Kredensial Login & Pilihan Kelas Ampuan| P_System
    P_System -->|7. Laporan Rekapitulasi Literasi Murid| E_Guru
    P_System -->|8. Katalog Buku Guru & Siswa| E_Guru

    %% Data Flows: Admin
    E_Admin -->|9. Data Master Buku & Unggah PDF SIBI| P_System
    E_Admin -->|10. Manajemen Peran Akun Pengguna| P_System
    P_System -->|11. Laporan Statistik & Grafik Pembaca| E_Admin

    %% Data Flows: Google Auth
    E_Google -->|12. Token ID & Data Profil Google| P_System
```

---

### C. DFD Level 1: Dekomposisi Proses Utama

Dekomposisi proses `0.0` menjadi 4 proses inti beserta data store yang terlibat:

```mermaid
flowchart TB
    %% External Entities
    Siswa["👨‍🎓 Siswa SD"]
    Guru["👩‍🏫 Guru / Wali Kelas"]
    Admin["👨‍💼 Admin Sekolah"]

    %% Data Stores
    D1[("D1: users")]
    D2[("D2: categories")]
    D3[("D3: books")]
    D4[("D4: reading_logs")]

    %% Process 1.0: Autentikasi
    P1(("1.0<br>Pengelolaan Akun<br>& Autentikasi"))
    Siswa -->|Form Login / Register| P1
    Guru -->|Form Login| P1
    Admin -->|Kelola User & Role| P1
    P1 <-->|Read / Write Akun| D1
    P1 -->|Token Sesi & Info Role| Siswa
    P1 -->|Token Sesi & Info Role| Guru

    %% Process 2.0: Manajemen Katalog Buku
    P2(("2.0<br>Pengelolaan & Akses<br>Katalog Buku SIBI"))
    Admin -->|Upload PDF & Metadata| P2
    P2 <-->|Read / Write Kategori| D2
    P2 <-->|Read / Write Buku| D3
    Siswa -->|Keyword Cari / Filter Kategori| P2
    Guru -->|Pencarian Buku| P2
    P2 -->|Daftar Buku & Detail Sinopsis| Siswa
    P2 -->|Daftar Buku & Panduan Guru| Guru

    %% Process 3.0: E-Reader & Tracker
    P3(("3.0<br>Pembacaan E-Book<br>& Pelacakan Waktu"))
    Siswa -->|Trigger Baca & Sinyal Aktif| P3
    D3 -->|Stream File PDF| P3
    D1 -->|Data Nama & Email Siswa| P3
    P3 -->|Render Watermark & PDF| Siswa
    P3 -->|Simpan Durasi & Hal Terakhir| D4
    P3 -->|Update total_dibaca +1| D3

    %% Process 4.0: Pemantauan Kelas & Statistik
    P4(("4.0<br>Pemantauan Kelas<br>& Pelaporan Literasi"))
    Guru -->|Request Pantau Kelas| P4
    Admin -->|Request Statistik Perpustakaan| P4
    D4 -->|Data Log Waktu Membaca| P4
    D1 -->|Data Kelas Murid| P4
    D3 -->|Judul Buku Dibaca| P4
    P4 -->|Laporan Harian Siswa Kelas| Guru
    P4 -->|Laporan Statistik Sekolah| Admin
```

---

### D. Kamus Data (Data Dictionary) Aliran Data

Format struktur data yang mengalir pada DFD:

1. **`Data_Registrasi`**:
   - `nama` = *String (max 255)*
   - `email` = *String (valid email format, unique)*
   - `password` = *String (min 8 karakter)*
   - `kelas` = *String (enum: 'Kelas 1' s/d 'Kelas 6')*
2. **`Data_Track_Membaca`**:
   - `user_id` = *Integer (FK users.id)*
   - `book_id` = *Integer (FK books.id)*
   - `durasi_detik` = *Integer (akumulasi sesi aktif, misal: 30)*
   - `halaman_terakhir` = *Integer (nomor halaman saat ini)*
   - `platform` = *Enum ('mobile', 'web')*
   - `read_at` = *Timestamp (waktu sesi berlangsung)*
3. **`Data_Laporan_Guru`**:
   - `nama_kelas` = *String*
   - `total_siswa` = *Integer*
   - `siswa_aktif_hari_ini` = *Integer*
   - `rekap_siswa` = *Array of [nama, status_baca, menit_hari_ini, judul_buku]*

---

## 6. Panduan 5: Entity Relationship Diagram (ERD)

ERD menggambarkan struktur logis basis data relasional, entitas tabel, atribut kolom, kunci utama (Primary Key), kunci tamu (Foreign Key), dan kardinalitas antar tabel.

### A. Komponen Penyusun ERD
1. **Entitas (Entity)**: Tabel data yang menyimpan objek independen (disimbolkan dengan kotak persegi panjang).
2. **Atribut (Attribute)**: Kolom-kolom di dalam entitas.
   - **Primary Key (PK)**: Pengenal unik record (contoh: `id`).
   - **Foreign Key (FK)**: Kunci penghubung ke entitas lain (contoh: `category_id`, `user_id`, `book_id`).
3. **Kardinalitas (Cardinality)**: Menggunakan notasi **Crow's Foot**:
   - `||--o{` : Relasi **One-to-Many (1 ke N)**. Satu record di entitas kiri dapat memiliki 0, 1, atau banyak record di entitas kanan.
   - `||--||` : Relasi **One-to-One (1 ke 1)**.

---

### B. Struktur Tabel Nyata Database MySQL
Diekstraksi langsung dari berkas migrasi Laravel pada `database/migrations/`:

#### 1. Tabel: `users`
| Kolom | Tipe Data | Constraint | Keterangan |
| :--- | :--- | :--- | :--- |
| `id` | BIGINT UNSIGNED | PK, Auto Increment | Identitas unik pengguna |
| `name` | VARCHAR(255) | NOT NULL | Nama lengkap siswa / guru / admin |
| `email` | VARCHAR(255) | UNIQUE, NOT NULL | Alamat email akun |
| `password` | VARCHAR(255) | NULLABLE | Hash bcrypt kata sandi (null jika pure Google) |
| `avatar` | VARCHAR(255) | NULLABLE | URL foto profil dari Google atau storage lokal |
| `firebase_uid` | VARCHAR(255) | NULLABLE | UID unik Google Firebase Auth |
| `role` | ENUM('admin','siswa','guru') | DEFAULT 'siswa' | Hak akses peran pengguna |
| `kelas` | VARCHAR(50) | NULLABLE | Kelas siswa / kelas ampuan guru (e.g. 'Kelas 4') |
| `email_verified_at`| TIMESTAMP | NULLABLE | Waktu verifikasi email |
| `created_at`, `updated_at` | TIMESTAMP | NULLABLE | Waktu pembuatan & modifikasi |

#### 2. Tabel: `categories`
| Kolom | Tipe Data | Constraint | Keterangan |
| :--- | :--- | :--- | :--- |
| `id` | BIGINT UNSIGNED | PK, Auto Increment | Identitas unik kategori |
| `nama` | VARCHAR(255) | NOT NULL | Nama kategori (Pelajaran SD, Cerita Fabel) |
| `slug` | VARCHAR(255) | UNIQUE, NOT NULL | Slug URL unik |
| `tipe` | ENUM('pelajaran','bacaan') | DEFAULT 'bacaan' | Klasifikasi tipe kategori buku |
| `icon` | VARCHAR(255) | NULLABLE | Ikon aset SVG / Lucide |
| `created_at`, `updated_at` | TIMESTAMP | NULLABLE | Waktu pembuatan & modifikasi |

#### 3. Tabel: `books`
| Kolom | Tipe Data | Constraint | Keterangan |
| :--- | :--- | :--- | :--- |
| `id` | BIGINT UNSIGNED | PK, Auto Increment | Identitas unik buku |
| `category_id` | BIGINT UNSIGNED | FK ke `categories.id` | Kategori induk buku |
| `judul` | VARCHAR(255) | NOT NULL | Judul resmi buku SIBI |
| `slug` | VARCHAR(255) | UNIQUE, NOT NULL | Slug URL judul |
| `penulis` | VARCHAR(255) | NOT NULL | Penulis / Tim Pusat Perbukuan |
| `penerbit` | VARCHAR(255) | NOT NULL | Kemendikdasmen RI / Penerbit resmi |
| `jenjang` | VARCHAR(100) | NOT NULL | SD Kelas 1-3 / SD Kelas 4-6 |
| `tingkat_kelas`| TINYINT UNSIGNED | NOT NULL (1 s/d 6) | Angka tingkatan kelas murid |
| `deskripsi` | TEXT | NULLABLE | Sinopsis dan pengenalan isi buku |
| `cover_path` | VARCHAR(255) | NULLABLE | Lokasi path gambar sampul buku |
| `file_path` | VARCHAR(255) | NOT NULL | Lokasi path file PDF resmi buku |
| `total_halaman`| SMALLINT UNSIGNED | DEFAULT 0 | Jumlah total halaman PDF |
| `rating` | DECIMAL(3,2) | DEFAULT 5.00 | Nilai ulasan buku |
| `total_dibaca` | INT UNSIGNED | DEFAULT 0 | Counter akumulasi pembacaan |
| `is_active` | BOOLEAN | DEFAULT TRUE | Status visibilitas buku di katalog |
| `created_at`, `updated_at` | TIMESTAMP | NULLABLE | Waktu pembuatan & modifikasi |

#### 4. Tabel: `reading_logs`
| Kolom | Tipe Data | Constraint | Keterangan |
| :--- | :--- | :--- | :--- |
| `id` | BIGINT UNSIGNED | PK, Auto Increment | Identitas unik sesi log |
| `user_id` | BIGINT UNSIGNED | FK ke `users.id`, NULLABLE | Akun siswa yang membaca (null jika tamu) |
| `book_id` | BIGINT UNSIGNED | FK ke `books.id` | Buku yang dibaca |
| `platform` | ENUM('web','mobile') | DEFAULT 'mobile' | Perangkat yang digunakan untuk membaca |
| `halaman_terakhir`| SMALLINT UNSIGNED | DEFAULT 1 | Posisi halaman terakhir dibuka |
| `durasi_detik` | INT UNSIGNED | DEFAULT 0 | Waktu membaca aktif dalam detik |
| `read_at` | TIMESTAMP | NOT NULL | Waktu stempel sesi membaca dimulai |
| `created_at`, `updated_at` | TIMESTAMP | NULLABLE | Waktu pembuatan & modifikasi |

#### 5. Tabel: `personal_access_tokens` (Laravel Sanctum)
| Kolom | Tipe Data | Constraint | Keterangan |
| :--- | :--- | :--- | :--- |
| `id` | BIGINT UNSIGNED | PK, Auto Increment | Identitas unik token |
| `tokenable_type` | VARCHAR(255) | NOT NULL | `App\Models\User` |
| `tokenable_id` | BIGINT UNSIGNED | NOT NULL | ID User pemilik token |
| `name` | VARCHAR(255) | NOT NULL | Nama perangkat (misal: 'mobile-token') |
| `token` | VARCHAR(64) | UNIQUE, NOT NULL | SHA-256 hash dari bearer token |
| `abilities` | TEXT | NULLABLE | Hak akses token |
| `last_used_at` | TIMESTAMP | NULLABLE | Waktu terakhir token dipakai request API |
| `expires_at` | TIMESTAMP | NULLABLE | Waktu kadaluarsa token |
| `created_at`, `updated_at` | TIMESTAMP | NULLABLE | Waktu pembuatan & modifikasi |

---

### C. Diagram Relasi ERD Visual

```mermaid
erDiagram
    USERS ||--o{ READING_LOGS : "memiliki riwayat baca"
    USERS ||--o{ PERSONAL_ACCESS_TOKENS : "memiliki token sesi"
    CATEGORIES ||--o{ BOOKS : "mengelompokkan"
    BOOKS ||--o{ READING_LOGS : "dicatat pada sesi baca"

    USERS {
        bigint id PK
        string name "Nama Lengkap"
        string email UK "Email Akun"
        string password "Bcrypt Hash"
        string avatar "URL Foto Profil"
        string firebase_uid "UID Google Auth"
        enum role "admin, siswa, guru"
        string kelas "Kelas 1-6 SD"
        timestamp email_verified_at
        timestamp created_at
        timestamp updated_at
    }

    CATEGORIES {
        bigint id PK
        string nama "Nama Kategori SIBI"
        string slug UK "Slug URL"
        enum tipe "pelajaran, bacaan"
        string icon "Aset Ikon"
        timestamp created_at
        timestamp updated_at
    }

    BOOKS {
        bigint id PK
        bigint category_id FK
        string judul "Judul Buku Resmi"
        string slug UK
        string penulis
        string penerbit
        string jenjang
        tinyint tingkat_kelas "1 sampai 6"
        text deskripsi
        string cover_path
        string file_path
        smallint total_halaman
        decimal rating
        int total_dibaca
        boolean is_active
        timestamp created_at
        timestamp updated_at
    }

    READING_LOGS {
        bigint id PK
        bigint user_id FK "Nullable"
        bigint book_id FK
        enum platform "web, mobile"
        smallint halaman_terakhir
        int durasi_detik
        timestamp read_at
        timestamp created_at
        timestamp updated_at
    }

    PERSONAL_ACCESS_TOKENS {
        bigint id PK
        string tokenable_type
        bigint tokenable_id
        string name
        string token UK
        text abilities
        timestamp last_used_at
        timestamp expires_at
        timestamp created_at
        timestamp updated_at
    }
```

---

### D. Matriks Kardinalitas & Integritas Relasional

1. **`CATEGORIES` ke `BOOKS` (1 : N)**:
   - *Penjelasan*: Satu kategori dapat menaungi banyak buku teks maupun bacaan fabel. Satu buku wajib berelasi ke tepat satu kategori.
   - *Foreign Key*: `books.category_id` mereferensikan `categories.id` (`ON DELETE RESTRICT / CASCADE`).
2. **`USERS` ke `READING_LOGS` (1 : N)**:
   - *Penjelasan*: Satu siswa dapat memiliki ratusan catatan sesi membaca harian. Kolom `user_id` bernilai `NULLABLE` jika terdapat pembacaan anonim/tamu.
   - *Foreign Key*: `reading_logs.user_id` mereferensikan `users.id` (`ON DELETE SET NULL`).
3. **`BOOKS` ke `READING_LOGS` (1 : N)**:
   - *Penjelasan*: Satu buku dapat dibaca berkali-kali oleh banyak murid yang berbeda.
   - *Foreign Key*: `reading_logs.book_id` mereferensikan `books.id` (`ON DELETE CASCADE`).
4. **`USERS` ke `PERSONAL_ACCESS_TOKENS` (1 : N)**:
   - *Penjelasan*: Satu pengguna dapat login dari perangkat yang berbeda (misal: HP Android dan Web Desktop), sehingga memiliki lebih dari satu token sesi aktif.
   - *Foreign Key Polymorphic*: `personal_access_tokens.tokenable_id` mereferensikan `users.id`.

---

## 7. Panduan Praktis Pemindahan ke Draw.io / Visio / Word

Jika ingin menggambar ulang diagram-diagram ini ke aplikasi visual seperti **Draw.io**, **Microsoft Visio**, atau dokumen **Laporan Skripsi / Tugas Akhir**:

### 1. Di Draw.io (app.diagrams.net):
- **Untuk Use Case Diagram**: Pilih shape library `UML` ➔ ambil simbol `Actor` (orang-orangan) dan `Use Case` (oval). Buat garis `<<include>>` dengan garis putus-putus dan panah terbuka.
- **Untuk Flowchart**: Pilih shape library `Flowchart` ➔ gunakan `Terminator` untuk awal/akhir, `Process` untuk aksi, dan `Decision` untuk belah ketupat percabangan.
- **Untuk Flow Map**: Buat tabel `Swimlane (Vertical)` 4 kolom (Pengguna, Mobile App, Backend API, Database), masukkan simbol `Document` dan `Process` di kolom yang bersangkutan.
- **Untuk DFD**: Pilih library `Data Flow Diagram` ➔ gunakan `External Entity` (kotak), `Process` (lingkaran), `Data Store` (garis ganda), dan panah berlabel nama data.
- **Untuk ERD**: Pilih library `Entity Relation` ➔ gunakan tabel bertipe `Entity` dengan atribut PK, FK, dan relasi `1-to-many` (ujung cakar gagak / crow's foot).

### 2. Tips Penulisan Bab 3 / Bab 4 Skripsi:
- **Penomoran Gambar**: Berikan judul gambar resmi, contoh: *"Gambar 3.1 Use Case Diagram Sistem Digilibrary SD"*, *"Gambar 3.2 Diagram Konteks (DFD Level 0)"*, *"Gambar 3.5 Entity Relationship Diagram"*.
- **Penjelasan Alur**: Setelah gambar disisipkan, sertakan penjelasan teks seperti tabel use case atau kamus data yang telah disediakan di atas agar penguji skripsi dapat memahami alur data secara mendalam.
