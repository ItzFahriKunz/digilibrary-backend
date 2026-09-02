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
        Schema::create('reading_logs', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->nullable()->constrained('users')->onDelete('set null');
            $table->foreignId('book_id')->constrained('books')->onDelete('cascade');
            $table->enum('platform', ['web', 'mobile'])->default('web');
            $table->unsignedSmallInteger('halaman_terakhir')->default(1);
            $table->unsignedInteger('durasi_detik')->default(0);
            $table->timestamp('read_at')->useCurrent();
            $table->timestamps();

            $table->index(['book_id', 'read_at']);
            $table->index(['user_id', 'read_at']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('reading_logs');
    }
};
