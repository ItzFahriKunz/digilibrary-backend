# Digilibrary — Revisi Struktur Database (Tahun Ajaran, Kelas, Wali Kelas)

Dokumen ini mencatat struktur database final Digilibrary setelah penyesuaian kebutuhan: 3 role (Admin, Guru/Wali Kelas, Siswa), tracking kenaikan kelas per tahun ajaran, dan jejak akuntabilitas upload buku. Juga berisi daftar perubahan yang perlu dilakukan pada dokumen/diagram yang sudah ada (ERD, Flowmap, Flowchart, Use Case, dan SQL dump) agar semuanya konsisten.

---

## 1. Struktur Database Final

### `users` *(tidak berubah — tetap satu tabel untuk semua role)*
```
id
firebase_uid       (nullable, khusus login Google)
name
email              (unik)
avatar             (nullable)
role               (enum: admin, guru, siswa)
kelas              (nullable — akan digantikan relasi via siswa_kelas, lihat catatan di bawah)
email_verified_at
password
remember_token
created_at, updated_at
```
> **Catatan migrasi:** kolom `kelas` (varchar) yang sekarang ada di `users` akan digantikan fungsinya oleh tabel `siswa_kelas` di bawah, karena kelas siswa perlu berubah tiap tahun ajaran (tidak bisa lagi disimpan sebagai satu nilai tetap di `users`).

### `tahun_ajaran` *(baru)*
```
id
label              (contoh: "2026/2027")
tanggal_mulai
tanggal_selesai
status             (enum: aktif, selesai)
```

### `kelas` *(baru)*
```
id
tingkat            (1–6)
nama_rombel        (contoh: "4B")
tahun_ajaran_id    → tahun_ajaran
```

### `siswa_kelas` *(baru — riwayat kelas per siswa per tahun ajaran)*
```
id
user_id            → users (role: siswa)
kelas_id           → kelas
tahun_ajaran_id    → tahun_ajaran
status             (enum: aktif, naik_kelas, lulus, pindah)
```

### `wali_kelas` *(baru — satu guru memegang satu kelas per tahun ajaran)*
```
id
user_id            → users (role: guru)
kelas_id           → kelas
tahun_ajaran_id    → tahun_ajaran
```
Constraint: kombinasi `kelas_id` + `tahun_ajaran_id` hanya boleh punya satu baris (satu kelas = satu wali kelas per tahun ajaran).

### `books` *(tambahan kolom)*
```
... (kolom lama tetap sama) ...
uploaded_by        → users (nullable, harus role: admin)
```

### `categories` dan `reading_logs`
Tidak berubah dari struktur yang sudah berjalan.

---

## 2. Matriks Hak Akses (Final)

| Fitur | Admin | Guru (Wali Kelas) | Siswa |
|---|---|---|---|
| Upload/Edit/Hapus Buku | ✅ | ❌ | ❌ |
| Pantau Progres Baca — Semua Kelas | ✅ | ❌ | ❌ |
| Pantau Progres Baca — Kelas Sendiri | ✅ | ✅ | ❌ |
| Cetak Laporan (PDF) | ✅ | ❌ | ❌ |
| Kelola Tahun Ajaran & Proses Kenaikan Kelas | ✅ | ❌ | ❌ |
| Baca Buku | ✅ | ✅ | ✅ |

---

## 3. Alur Kenaikan Kelas / Tutup Tahun Ajaran

Diproses manual oleh Admin (bukan otomatis tanpa pengawasan), lewat tombol "Tutup Tahun Ajaran" di dashboard yang menjalankan Artisan Command:

1. Buat `tahun_ajaran` baru → status `aktif`; tahun ajaran lama → status `selesai`
2. Untuk setiap baris `siswa_kelas` yang masih `aktif` di tahun lama:
   - Jika `kelas.tingkat` < 6 → buat baris baru di `siswa_kelas` (tahun ajaran baru, tingkat +1), baris lama ditandai `naik_kelas`
   - Jika `kelas.tingkat` = 6 → baris lama ditandai `lulus`, tidak ada baris baru (riwayat baca siswa tetap tersimpan untuk data historis)
3. Admin menetapkan ulang `wali_kelas` untuk tahun ajaran baru (bisa sama atau beda guru)

---

## 4. Catatan Perubahan untuk Dokumen yang Sudah Ada

Lima file berikut (4 diagram + 1 SQL dump) perlu direvisi agar konsisten dengan struktur final di atas:

### `digilibrary.sql`
- [x] Tambah tabel: `tahun_ajaran`, `kelas`, `siswa_kelas`, `wali_kelas` (Selesai diekspor)
- [x] Tambah kolom `uploaded_by` pada tabel `books` (Selesai diekspor)
- [ ] Kolom `users.kelas` (varchar) dihapus setelah data lama dimigrasikan ke `siswa_kelas`

### ERD (Gambar 1)
- [ ] Gabungkan entity `admin` dan `siswa` menjadi satu entity `users` dengan atribut `role`
- [ ] Tambahkan entity `tahun_ajaran`, `kelas`, `siswa_kelas`, `wali_kelas` beserta relasinya
- [ ] Entity `leaderboard_weekly` dan `reading_progress` — **putuskan dulu** apakah tetap dipakai (jika ya, sesuaikan agar dihitung dari `reading_logs` yang sudah ada, bukan tabel statis terpisah)

### Flowmap (Gambar 2)
- [ ] Hapus referensi "Firestore" dari kolom Database — cukup tulis "MySQL" saja, karena Firebase di sistem ini hanya dipakai untuk autentikasi Google, bukan penyimpanan data

### Flow Chart (Gambar 3)
- [ ] Perbaiki catatan "Leaderboard mingguan untuk kelas XII RPL C" — istilah kelas ini adalah kelas SMK, tidak relevan dengan konteks sekolah dasar. Ganti dengan referensi kelas SD (contoh: "seluruh kelas aktif tahun ajaran berjalan")
- [ ] Tambahkan proses "Tutup Tahun Ajaran / Kenaikan Kelas" pada alur Admin

### Use Case Diagram (Gambar 4)
- [ ] Ubah "Login (Firebase Auth)" pada sisi Siswa menjadi "Login (Email & Password)" — Firebase hanya digunakan untuk opsi login Google pada role Admin/Guru
- [ ] Tambahkan use case "Kelola Tahun Ajaran & Kenaikan Kelas" pada sisi Admin
- [ ] Perjelas bahwa Guru hanya dapat melihat laporan pada kelas yang diampu (relasi `wali_kelas`), bukan seluruh kelas

---

## 5. Status

Struktur database inti (`users`, `categories`, `books`, `reading_logs`) sudah berjalan dan terhubung dengan API. Tabel-tabel baru pada dokumen ini (`tahun_ajaran`, `kelas`, `siswa_kelas`, `wali_kelas`) serta kolom `uploaded_by` masih dalam tahap perencanaan migration, belum diimplementasikan.

---

## 6. Rencana Eksekusi & Status Implementasi
- [x] Rencana Skema Disetujui
- [x] 1. Migration (Selesai): Tabel tahun_ajaran, kelas, siswa_kelas, wali_kelas, field nis/nip users, uploaded_by books
- [x] 2. Model Eloquent (Selesai): & Relasi (TahunAjaran, Kelas, SiswaKelas, WaliKelas, User, Book)
- [x] 3. Seeder Inisialisasi (Selesai): Tahun Ajaran Aktif, 24 Rombel SD, dan Migrasi Otomatis data users.kelas ke siswa_kelas/wali_kelas
- [x] 4. Pembaruan TeacherController (Selesai): dan AdminController (Backward Compatible)
