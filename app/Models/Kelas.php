<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;

class Kelas extends Model
{
    use HasFactory;

    protected $table = 'kelas';

    protected $fillable = [
        'tingkat',
        'nama_rombel',
        'kuota_maksimal',
        'tahun_ajaran_id',
    ];

    protected $casts = [
        'tingkat'        => 'integer',
        'kuota_maksimal' => 'integer',
    ];

    public function tahunAjaran(): BelongsTo
    {
        return $this->belongsTo(TahunAjaran::class, 'tahun_ajaran_id');
    }

    public function siswaKelas(): HasMany
    {
        return $this->hasMany(SiswaKelas::class, 'kelas_id');
    }

    public function activeSiswa(): HasMany
    {
        return $this->hasMany(SiswaKelas::class, 'kelas_id')->where('status', 'aktif');
    }

    public function waliKelas(): HasOne
    {
        return $this->hasOne(WaliKelas::class, 'kelas_id');
    }

    public function getFullNameAttribute(): string
    {
        return "Kelas {$this->nama_rombel}";
    }
}
