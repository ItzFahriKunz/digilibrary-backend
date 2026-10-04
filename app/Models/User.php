<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'firebase_uid',
        'avatar',
        'role',
        'nis',
        'nisn',
        'nip',
        'kelas',
        'jenis_kelamin',
    ];

    /**
     * Appended accessors for serialization.
     */
    protected $appends = [
        'has_password',
        'is_google',
    ];

    public function getHasPasswordAttribute(): bool
    {
        return !empty($this->password);
    }

    public function getIsGoogleAttribute(): bool
    {
        return !empty($this->firebase_uid);
    }

    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * Get the attributes that should be cast.
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }

    /**
     * Relasi ke reading_logs (aktivitas membaca).
     */
    public function readingLogs()
    {
        return $this->hasMany(ReadingLog::class);
    }

    /**
     * Relasi riwayat kelas siswa.
     */
    public function siswaKelas(): HasMany
    {
        return $this->hasMany(SiswaKelas::class, 'user_id');
    }

    /**
     * Relasi kelas aktif siswa saat ini.
     */
    public function activeSiswaKelas(): HasOne
    {
        return $this->hasOne(SiswaKelas::class, 'user_id')->where('status', 'aktif');
    }

    /**
     * Relasi riwayat penugasan wali kelas (untuk Guru).
     */
    public function waliKelas(): HasMany
    {
        return $this->hasMany(WaliKelas::class, 'user_id');
    }

    /**
     * Relasi penugasan wali kelas aktif saat ini.
     */
    public function activeWaliKelas(): HasOne
    {
        return $this->hasOne(WaliKelas::class, 'user_id')->latestOfMany();
    }

    /**
     * Buku yang diunggah oleh admin ini.
     */
    public function uploadedBooks(): HasMany
    {
        return $this->hasMany(Book::class, 'uploaded_by');
    }

    /**
     * Cek apakah profil sudah dilengkapi (nama + kelas untuk siswa).
     */
    public function isProfileComplete(): bool
    {
        if ($this->role === 'admin' || $this->role === 'guru') {
            return !empty($this->name);
        }

        // Siswa wajib punya nama dan kelas
        return !empty($this->name) && (!empty($this->kelas) || $this->activeSiswaKelas()->exists());
    }
}