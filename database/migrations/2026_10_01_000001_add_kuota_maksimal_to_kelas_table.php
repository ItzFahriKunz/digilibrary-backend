<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('kelas', function (Blueprint $table) {
            if (!Schema::hasColumn('kelas', 'kuota_maksimal')) {
                $table->unsignedSmallInteger('kuota_maksimal')->default(32)->after('nama_rombel');
            }
        });
    }

    public function down(): void
    {
        Schema::table('kelas', function (Blueprint $table) {
            if (Schema::hasColumn('kelas', 'kuota_maksimal')) {
                $table->dropColumn('kuota_maksimal');
            }
        });
    }
};
