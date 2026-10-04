<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // 1. Tabel Tahun Ajaran
        if (!Schema::hasTable('tahun_ajaran')) {
            Schema::create('tahun_ajaran', function (Blueprint $table) {
                $table->id();
                $table->string('label', 50); // contoh: "2025/2026"
                $table->date('tanggal_mulai')->nullable();
                $table->date('tanggal_selesai')->nullable();
                $table->enum('status', ['aktif', 'selesai'])->default('aktif');
                $table->timestamps();
            });
        }

        // 2. Tabel Kelas (Rombel per Tahun Ajaran)
        if (!Schema::hasTable('kelas')) {
            Schema::create('kelas', function (Blueprint $table) {
                $table->id();
                $table->unsignedTinyInteger('tingkat'); // 1 - 6
                $table->string('nama_rombel', 20); // contoh: "4B"
                $table->foreignId('tahun_ajaran_id')->constrained('tahun_ajaran')->onDelete('cascade');
                $table->timestamps();

                $table->unique(['tingkat', 'nama_rombel', 'tahun_ajaran_id']);
            });
        }

        // 3. Tabel Siswa Kelas (Riwayat Kelas per Siswa per Tahun Ajaran)
        if (!Schema::hasTable('siswa_kelas')) {
            Schema::create('siswa_kelas', function (Blueprint $table) {
                $table->id();
                $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
                $table->foreignId('kelas_id')->constrained('kelas')->onDelete('cascade');
                $table->foreignId('tahun_ajaran_id')->constrained('tahun_ajaran')->onDelete('cascade');
                $table->enum('status', ['aktif', 'naik_kelas', 'lulus', 'pindah'])->default('aktif');
                $table->timestamps();

                $table->unique(['user_id', 'tahun_ajaran_id']);
            });
        }

        // 4. Tabel Wali Kelas (Satu Guru = Satu Kelas per Tahun Ajaran)
        if (!Schema::hasTable('wali_kelas')) {
            Schema::create('wali_kelas', function (Blueprint $table) {
                $table->id();
                $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
                $table->foreignId('kelas_id')->constrained('kelas')->onDelete('cascade');
                $table->foreignId('tahun_ajaran_id')->constrained('tahun_ajaran')->onDelete('cascade');
                $table->timestamps();

                $table->unique(['kelas_id', 'tahun_ajaran_id']);
            });
        }

        // 5. Tambah kolom NIS dan NIP ke users jika belum ada
        Schema::table('users', function (Blueprint $table) {
            if (!Schema::hasColumn('users', 'nis')) {
                $table->string('nis', 30)->nullable()->after('role');
            }
            if (!Schema::hasColumn('users', 'nip')) {
                $table->string('nip', 30)->nullable()->after('nis');
            }
        });

        // 6. Tambah kolom uploaded_by ke books jika belum ada
        Schema::table('books', function (Blueprint $table) {
            if (!Schema::hasColumn('books', 'uploaded_by')) {
                $table->foreignId('uploaded_by')->nullable()->after('category_id')->constrained('users')->onDelete('set null');
            }
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('books', function (Blueprint $table) {
            if (Schema::hasColumn('books', 'uploaded_by')) {
                $table->dropForeign(['uploaded_by']);
                $table->dropColumn('uploaded_by');
            }
        });

        Schema::table('users', function (Blueprint $table) {
            $cols = [];
            if (Schema::hasColumn('users', 'nip')) $cols[] = 'nip';
            if (Schema::hasColumn('users', 'nis')) $cols[] = 'nis';
            if (!empty($cols)) {
                $table->dropColumn($cols);
            }
        });

        Schema::dropIfExists('wali_kelas');
        Schema::dropIfExists('siswa_kelas');
        Schema::dropIfExists('kelas');
        Schema::dropIfExists('tahun_ajaran');
    }
};
