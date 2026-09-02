<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
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
        'kelas',
    ];

    /**
     * The attributes that should be hidden for serialization.
     */
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
     * Relasi ke log pembacaan buku.
     */
    public function readingLogs()
    {
        return $this->hasMany(ReadingLog::class);
    }

    /**
     * Cek apakah profil sudah dilengkapi (nama + kelas untuk siswa).
     */
    public function isProfileComplete(): bool
    {
        // Admin dan guru tidak wajib isi kelas
        if ($this->role === 'admin' || $this->role === 'guru') {
            return true;
        }

        // Siswa wajib punya nama dan kelas
        return !empty($this->name) && !empty($this->kelas);
    }
}