# 📐 Dokumentasi Alur Sistem & Arsitektur Digilibrary SD
> **Perpustakaan Digital Sekolah Dasar Berstandar Kurikulum Merdeka & SIBI Kemendikdasmen**  
> Repositori panduan spesifikasi pemodelan rekayasa perangkat lunak, diagram alur, kamus data, dan basis data relasional.

Folder ini berisi cetak biru arsitektur lengkap sistem **Digilibrary SD** yang mencakup interaksi antara **Web Application (React + Vite)** dan **Mobile Application (Android Kotlin / Jetpack Compose)** yang terhubung dengan **REST API Backend (Laravel 11)**.

Setiap berkas markdown di bawah ini dirancang terstruktur dan dilengkapi dengan kode **Mermaid Diagram** sehingga dapat langsung disalin ke [Mermaid Live Editor](https://mermaid.live), Draw.io, maupun tools generator diagram otomatis lainnya.

---

## 📂 Struktur Berkas Dokumentasi

| Berkas | Keterangan & Rujukan Gambar | Status Arsitektur |
| :--- | :--- | :---: |
| 📘 **[`01_USE_CASE.md`](./01_USE_CASE.md)** | Pemodelan Use Case Diagram, spesifikasi aktor (Siswa, Guru, Admin), dan skenario interaksi sistem (*Rujukan: Picture1.png*). | ✅ Final |
| 📊 **[`02_FLOW_CHART.md`](./02_FLOW_CHART.md)** | Diagram alir aktivitas (Flowchart) untuk Web Admin, Mobile Siswa & Guru, serta 5 sub-proses utama (*Rujukan: Picture2.png*). | ✅ Final |
| 🗺️ **[`03_FLOW_MAP.md`](./03_FLOW_MAP.md)** | Bagan alir dokumen & prosedur sistem (Swimlane Flow Map 5 entitas terintegrasi) (*Rujukan: Picture3.png*). | ✅ Final |
| 🗄️ **[`04_ERD.md`](./04_ERD.md)** | Entity Relationship Diagram & Kamus Data Relasional MySQL (8 entitas inti termasuk 24 rombel & tahun ajaran) (*Rujukan: Picture4.png & db_siperpus_mi.sql*). | ✅ Final |
| 🔄 **[`05_DFD.md`](./05_DFD.md)** | Data Flow Diagram (DFD Level 0 Context Diagram, DFD Level 1 Dekomposisi Sistem, & Kamus Aliran Data). | ✅ Final |

---

## 🎯 Batasan Platform Berdasarkan Peran (Role Scope)

1. **Aplikasi Mobile (Android Kotlin)**:
   - **Khusus Siswa**: Katalog Kurikulum Merdeka Fase A–C, E-Reader interaktif (watermark anti-bajak), live reading tracker (0–100%), leaderboard bintang literasi, riwayat baca, dan profil (NIS & NISN).
   - **Khusus Guru / Wali Kelas**: Semua fitur siswa ditambah tab ekstra **"Pantau Kelas"** untuk memantau capaian murid kelas binaannya sendiri secara langsung.
2. **Aplikasi Web Desktop (React + Vite)**:
   - **Khusus Administrator Perpustakaan**: Manajemen katalog buku, upload PDF, manajemen pengguna, pemantauan 24 rombel SD, pengaturan kuota siswa, penetapan wali kelas, dan arsip tahun ajaran.
   - **Guru / Wali Kelas**: Dapat login via Web untuk mencetak laporan rekapitulasi literasi kelas format resmi PDF.
   - **Siswa**: Dapat mengakses landing page dan membaca buku secara mandiri via browser.

---

## 🖼️ Arsip Diagram Visual Asli
- 🖼️ `Picture1.png` — Use Case Diagram Sistem Digilibrary (Awal)
- 🖼️ `Picture2.png` — Flowchart Sistem Digilibrary (Awal)
- 🖼️ `Picture3.png` — Flowmap Sistem Digilibrary (Awal)
- 🖼️ `Picture4.png` — ERD Sistem Digilibrary (Awal)
- 💾 `Database/db_siperpus_mi (1).sql` — Dump Basis Data Fisik MI Roudotutta'lim (Rujukan 24 Rombel & Data Guru/Siswa)