<?php

namespace Database\Seeders;

use App\Models\Book;
use App\Models\ReadingLog;
use App\Models\User;
use Illuminate\Database\Seeder;

class ReadingLogSeeder extends Seeder
{
    /**
     * Seed dummy reading logs untuk mengisi statistik dashboard admin.
     */
    public function run(): void
    {
        $users = User::all();
        $books = Book::all();

        if ($users->isEmpty() || $books->isEmpty()) {
            return;
        }

        $platforms = ['web', 'mobile'];

        // Buat 60 log bacaan dummy selama 7 hari terakhir
        for ($i = 0; $i < 60; $i++) {
            $user = $users->random();
            $book = $books->random();
            $platform = $platforms[array_rand($platforms)];
            $daysAgo = rand(0, 6);
            $hoursAgo = rand(0, 23);

            ReadingLog::create([
                'user_id' => $user->id,
                'book_id' => $book->id,
                'platform' => $platform,
                'halaman_terakhir' => rand(1, $book->total_halaman ?: 50),
                'durasi_detik' => rand(30, 1800),
                'read_at' => now()->subDays($daysAgo)->subHours($hoursAgo),
            ]);
        }
    }
}