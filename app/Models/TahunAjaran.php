<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class TahunAjaran extends Model
{
    use HasFactory;

    protected $table = 'tahun_ajaran';

    protected $fillable = [
        'label',
        'tanggal_mulai',
        'tanggal_selesai',
        'status',
    ];

    protected $casts = [
        'tanggal_mulai'   => 'date',
        'tanggal_selesai' => 'date',
    ];

    public function kelas(): HasMany
    {
        return $this->hasMany(Kelas::class, 'tahun_ajaran_id');
    }

    public function siswaKelas(): HasMany
    {
        return $this->hasMany(SiswaKelas::class, 'tahun_ajaran_id');
    }

    public function waliKelas(): HasMany
    {
        return $this->hasMany(WaliKelas::class, 'tahun_ajaran_id');
    }

    public static function getActive()
    {
        return self::where('status', 'aktif')->latest()->first();
    }
}
