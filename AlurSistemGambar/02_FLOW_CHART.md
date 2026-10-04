# 📊 Spesifikasi Flowchart Sistem — Digilibrary SD
> **Rujukan Visual: `Picture2.png`**  
> **Cakupan Sistem: Alur Web Admin/Guru, Alur Mobile Siswa/Guru, & 5 Sub-Proses Utama**

Dokumen ini menjelaskan alur logika sistem dari mulai login pengguna hingga proses bisnis inti literasi sekolah dasar.

---

## 1. Flowchart Induk A: Web Dashboard Admin & Guru

```mermaid
flowchart TD
    StartAdmin([MULAI]) --> LoginWeb[Login Web Admin / Guru]
    LoginWeb --> AuthCheck{Autentikasi Valid?}
    AuthCheck -- Tidak --> ErrorMsg[Tampilkan Notifikasi Error] --> LoginWeb
    AuthCheck -- Ya --> RoleCheck{Peran Pengguna?}

    RoleCheck -- Admin --> DashAdmin[Dashboard Utama Administrator]
    RoleCheck -- Guru --> DashGuru[Dashboard Pemantauan Guru / Wali Kelas]

    %% Menu Admin
    DashAdmin --> MenuAdmin{Pilih Menu Admin}
    MenuAdmin --> M1[1. Kelola E-Book: Upload PDF, Cover, Kategori]
    MenuAdmin --> M2[2. Kelola Pengguna: Siswa, Guru, Reset Password]
    MenuAdmin --> M3[3. Kelola 24 Rombel: Kuota & Penetapan Wali]
    MenuAdmin --> M4[4. Kelola Tahun Ajaran & Kenaikan Kelas]
    MenuAdmin --> M5[5. Rekapitulasi & Cetak Laporan 24 Kelas]

    %% Menu Guru
    DashGuru --> MenuGuru{Pilih Menu Guru}
    MenuGuru --> G1[Pantau Statistik Literasi Kelas Binaan]
    MenuGuru --> G2[Tabel Murid: Status Sudah/Belum Baca Hari Ini]
    MenuGuru --> G3[Peringkat Bintang Literasi Murid Kelas]
    MenuGuru --> G4[Cetak Laporan Rekapitulasi PDF Format Resmi]

    M1 & M2 & M3 & M4 & M5 & G1 & G2 & G3 & G4 --> LogoutCheck{Keluar / Logout?}
    LogoutCheck -- Tidak --> RoleCheck
    LogoutCheck -- Ya --> EndAdmin([SELESAI])
```

---

## 2. Flowchart Induk B: Aplikasi Mobile Android (Siswa & Guru)

```mermaid
flowchart TD
    StartMob([MULAI]) --> OpenApp[Buka Aplikasi Digilibrary Mobile]
    OpenApp --> MethodAuth{Pilih Metode Masuk}
    MethodAuth -- Email/Password --> FormEmail[Input Email & Kata Sandi]
    MethodAuth -- Google One-Tap --> GoogleAuth[Firebase Google Sign-In]
    MethodAuth -- Lupa Sandi --> ForgotPass[Minta OTP Email -> Verifikasi -> Sandi Baru] --> FormEmail

    FormEmail & GoogleAuth --> CheckAuthMob{Kredensial Valid?}
    CheckAuthMob -- Tidak --> ErrMob[Pesan Kesalahan Login] --> MethodAuth
    CheckAuthMob -- Ya --> CheckComplete{Profil Lengkap?}

    CheckComplete -- Belum --> CompleteForm[Lengkapi Nama & Kelas Awal] --> SaveProfile[Simpan Profil] --> CheckRoleMob
    CheckComplete -- Sudah --> CheckRoleMob{Cek Role Pengguna}

    %% Siswa Flow
    CheckRoleMob -- Siswa --> TabSiswa[Bottom Bar 3 Tab: Beranda, Rak Buku, Profil]
    TabSiswa --> ActSiswa{Pilih Menu Siswa}
    ActSiswa --> S1[Katalog E-Book SIBI Kurikulum Merdeka]
    ActSiswa --> S2[E-Reader PDF & Live Reading Tracker]
    ActSiswa --> S3[Papan Peringkat Leaderboard Siswa]
    ActSiswa --> S4[Profil: Cek NIS, NISN, Ganti Foto, Sandi]

    %% Guru Flow
    CheckRoleMob -- Guru --> TabGuru[Bottom Bar 4 Tab: Beranda, Rak Buku, Pantau Kelas, Profil]
    TabGuru --> ActGuru{Pilih Menu Guru}
    ActGuru --> S1
    ActGuru --> S2
    ActGuru --> GT1[Tab Pantau Kelas: Rekap Siswa Kelas Sendiri]
    ActGuru --> GT2[Evaluasi Siswa Belum Membaca Hari Ini]
    ActGuru --> S4

    S1 & S2 & S3 & S4 & GT1 & GT2 --> LogoutMob{Keluar Akun?}
    LogoutMob -- Tidak --> CheckRoleMob
    LogoutMob -- Ya --> EndMob([SELESAI])
```

---

## 3. Sub-Proses Utama Aplikasi

### Sub-Proses 1: Kelola E-Book & PDF (Admin)
`Pilih Menu E-Book` ➔ `Upload File PDF & Gambar Cover SIBI` ➔ `Isi Metadata (Judul, Penulis, Kelas 1-6, Kategori)` ➔ `Simpan ke Storage & Database MySQL` ➔ `Buku Aktif di Katalog`.

### Sub-Proses 2: Baca & Scroll Tracking 0–100% (Siswa)
`Pilih Buku` ➔ `Buka E-Reader PDF` ➔ `Deteksi Interaksi Sentuhan / Scroll Vertikal` ➔ `Timer Aktif Berjalan (Detik)` ➔ `Idle Detector (>60 detik diam = Jeda Otomatis)` ➔ `Kirim Sinkronisasi POST track-read per 30 Detik` ➔ `Database Update Durasi & Halaman Terakhir`.

### Sub-Proses 3: Sistem Poin & Leaderboard Membaca
`Siswa Membaca Hingga Halaman Terakhir (100%)` ➔ `Sistem Tandai Buku Selesai` ➔ `Akumulasi Total Buku & Durasi Menit` ➔ `Urutkan Peringkat Kelas` ➔ `Peringkat 1: Bintang Literasi #1` ➔ `Peringkat 2 & 3: Juara Baca #2 & #3` ➔ `Tampil di Leaderboard`.

### Sub-Proses 4: Rekap & Cetak Laporan Literasi PDF
`Pilih Kelas & Tahun Ajaran` ➔ `Sistem Menghitung Total Siswa Aktif, Rata-rata Progres %, Total Durasi` ➔ `Susun Data Prestasi Siswa & Catatan Wali Kelas` ➔ `Buka Modal Cetak Laporan` ➔ `Render Dokumen Format A4 (Kop Madrasah & Tanda Tangan)` ➔ `Cetak / Unduh PDF`.

### Sub-Proses 5: Tutup Tahun Ajaran & Kenaikan Kelas (24 Rombel)
`Admin Buka Manajemen Kelas` ➔ `Buat Tahun Ajaran Baru (Misal: 2026/2027)` ➔ `Sistem Otomatis Generate 24 Rombel (1A s/d 6C)` ➔ `Siswa Kelas 1-5 Naik Tingkat (Status: naik_kelas)` ➔ `Siswa Kelas 6 Dinyatakan Lulus (Status: lulus)` ➔ `Admin Menetapkan Ulang Wali Kelas Baru`.