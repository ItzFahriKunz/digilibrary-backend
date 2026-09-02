<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Book extends Model
{
    use HasFactory;

    protected $fillable = [
        'category_id',
        'judul',
        'slug',
        'penulis',
        'penerbit',
        'jenjang',
        'tingkat_kelas',
        'deskripsi',
        'cover_path',
        'file_path',
        'total_halaman',
        'rating',
        'total_dibaca',
        'is_active',
    ];

    protected $casts = [
        'is_active' => 'boolean',
        'rating' => 'float',
        'total_halaman' => 'integer',
        'total_dibaca' => 'integer',
        'tingkat_kelas' => 'integer',
    ];

    protected $appends = ['pdf_url', 'cover_url'];

    public function category()
    {
        return $this->belongsTo(Category::class);
    }

    public function readingLogs()
    {
        return $this->hasMany(ReadingLog::class);
    }

    /**
     * URL akses file PDF (bisa streaming lokal, storage public, atau external URL)
     */
    public function getPdfUrlAttribute(): ?string
    {
        if (empty($this->file_path)) {
            return null;
        }

        if (str_starts_with($this->file_path, 'http://') || str_starts_with($this->file_path, 'https://')) {
            return $this->file_path;
        }

        return url('/api/books/' . $this->id . '/stream');
    }

    /**
     * URL gambar cover
     */
    public function getCoverUrlAttribute(): ?string
    {
        if (empty($this->cover_path)) {
            return "https://images.unsplash.com/photo-1544717305-2782549b5136?w=600&auto=format&fit=crop&q=80";
        }

        if (str_starts_with($this->cover_path, 'http://') || str_starts_with($this->cover_path, 'https://')) {
            return $this->cover_path;
        }

        return asset('storage/' . $this->cover_path);
    }
}