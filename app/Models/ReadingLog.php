<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ReadingLog extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'book_id',
        'platform',
        'halaman_terakhir',
        'durasi_detik',
        'read_at',
    ];

    protected $casts = [
        'halaman_terakhir' => 'integer',
        'durasi_detik' => 'integer',
        'read_at' => 'datetime',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function book(): BelongsTo
    {
        return $this->belongsTo(Book::class);
    }
}