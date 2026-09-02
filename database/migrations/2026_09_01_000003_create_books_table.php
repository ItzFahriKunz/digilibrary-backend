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
        Schema::create('books', function (Blueprint $table) {
            $table->id();
            $table->foreignId('category_id')->constrained('categories')->onDelete('restrict');
            $table->string('judul', 255);
            $table->string('slug', 280)->unique();
            $table->string('penulis', 150);
            $table->string('penerbit', 150)->default('Pusat Perbukuan Kemendikdasmen');
            $table->string('jenjang', 100);
            $table->unsignedTinyInteger('tingkat_kelas')->nullable();
            $table->text('deskripsi')->nullable();
            $table->string('cover_path')->nullable();
            $table->string('file_path')->nullable();
            $table->unsignedSmallInteger('total_halaman')->default(0);
            $table->decimal('rating', 2, 1)->default(5.0);
            $table->unsignedInteger('total_dibaca')->default(0);
            $table->boolean('is_active')->default(true);
            $table->timestamps();

            $table->index(['category_id', 'tingkat_kelas']);
            $table->index('is_active');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('books');
    }
};
