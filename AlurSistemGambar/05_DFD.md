# 🔄 Spesifikasi Data Flow Diagram (DFD) — Digilibrary SD
> **Level: DFD Level 0 (Context Diagram) & DFD Level 1 (Dekomposisi Sistem)**  
> **Notasi: Yourdon & DeMarco / Gane & Sarson**

Dokumen ini memetakan transformasi masukan data menjadi keluaran informasi pada sistem Digilibrary SD.

---

## 1. DFD Level 0 (Context Diagram)

Diagram Konteks menggambarkan batasan sistem Digilibrary SD dan interaksinya dengan 3 entitas luar:

```mermaid
flowchart TD
    Siswa[🧑‍🎓 Siswa SD]
    Guru[👨‍🏫 Guru / Wali Kelas]
    Admin[👨‍💼 Administrator]

    System((SISTEM DIGILIBRARY SD<br/>Platform E-Perpustakaan & Literasi))

    %% Siswa Data Flow
    Siswa -->|1. Data Registrasi & Login| System
    Siswa -->|2. Data Update Profil: NIS, NISN| System
    Siswa -->|3. Sinyal Tracking Baca: Durasi, Halaman| System
    System -->|A. Katalog E-Book & Stream PDF| Siswa
    System -->|B. Papan Peringkat Leaderboard & Riwayat| Siswa

    %% Guru Data Flow
    Guru -->|4. Kredensial Login & Update NIP| System
    Guru -->|5. Filter Kelas Binaan & Parameter Cetak| System
    System -->|C. Data Siswa Kelas & Status Baca Hari Ini| Guru
    System -->|D. Laporan Rekapitulasi Literasi PDF Resmi| Guru

    %% Admin Data Flow
    Admin -->|6. Kredensial Login Administrator| System
    Admin -->|7. Data Master E-Book & Upload PDF| System
    Admin -->|8. Manajemen User: Siswa, Guru| System
    Admin -->|9. Kelola 24 Rombel, Kuota, & Tahun Ajaran| System
    System -->|E. Statistik Global Literasi Sekolah| Admin
    System -->|F. Laporan Lengkap 24 Rombel SD| Admin
```

---

## 2. DFD Level 1 (Dekomposisi Proses Utama)

```mermaid
flowchart TD
    Siswa[🧑‍🎓 Siswa]
    Guru[👨‍🏫 Guru]
    Admin[👨‍💼 Admin]

    %% Data Stores
    D1[(D1: users)]
    D2[(D2: books & categories)]
    D3[(D3: reading_logs)]
    D4[(D4: kelas & tahun_ajaran)]
    D5[(D5: siswa_kelas & wali_kelas)]

    %% Process 1: Auth
    P1((1.0<br/>Manajemen Autentikasi & Akun))
    Siswa & Guru & Admin -->|Kredensial Login / Google Token| P1
    P1 <-->|Validasi & Profil| D1

    %% Process 2: E-Book Management
    P2((2.0<br/>Katalog & E-Reader PDF))
    Admin -->|Upload PDF, Cover, Metadata| P2
    P2 <-->|CRUD Buku| D2
    P2 -->|Stream E-Book & Cover| Siswa

    %% Process 3: Live Reading Tracking
    P3((3.0<br/>Pelacakan Durasi & Progres))
    Siswa -->|Durasi Aktif & Halaman Terakhir| P3
    P3 -->|Catat Sesi Baca| D3
    P3 <-->|Ambil Info Total Hal| D2

    %% Process 4: Leaderboard Calculation
    P4((4.0<br/>Kalkulasi Ranking Leaderboard))
    D3 -->|Agregasi Menit & Buku Selesai| P4
    P4 -->|Papan Peringkat Bintang Literasi| Siswa & Guru

    %% Process 5: Teacher Monitoring & Report
    P5((5.0<br/>Pemantauan Kelas & Cetak Laporan))
    Guru -->|Request Pantau Rombel Binaan| P5
    P5 <-->|Data Murid & Wali| D5
    P5 <-->|Data Keaktifan Hari Ini| D3
    P5 -->|Tabel Monitoring & File PDF Laporan| Guru

    %% Process 6: Academic Structure Management
    P6((6.0<br/>Manajemen 24 Rombel & Kenaikan))
    Admin -->|Atur Kuota, Penetapan Wali, Tahun Ajaran| P6
    P6 <-->|Struktur Rombel| D4
    P6 <-->|Penugasan Wali & Siswa| D5
```

---

## 3. Kamus Data Aliran Data (Data Flow Dictionary)

1. **`Data_Tracking_Baca`**:
   `user_id + book_id + platform + durasi_detik + halaman_terakhir + read_at + (log_id)`
2. **`Data_Siswa_Kelas`**:
   `user_id + nama + nis + nisn + status_hari_ini + durasi_menit + books_completed + avg_progress`
3. **`Data_Laporan_Resmi_PDF`**:
   `nomor_surat + tahun_ajaran + semester + rombel + wali_kelas + daftar_murid[nama, nis, nisn, durasi, progres, lencana] + ttd_wali + ttd_kepala_sekolah`