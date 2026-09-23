<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kode Reset Kata Sandi Digilibrary</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #F4F7F5;
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            color: #1A1A1A;
            -webkit-font-smoothing: antialiased;
        }
        .container {
            max-width: 540px;
            margin: 30px auto;
            background-color: #FFFFFF;
            border: 1px solid #D8E6DE;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
        }
        .header {
            background-color: #1F6F4A;
            padding: 30px 24px;
            text-align: center;
        }
        .header h1 {
            color: #FFFFFF;
            font-size: 22px;
            margin: 10px 0 0 0;
            font-weight: 800;
            letter-spacing: -0.5px;
        }
        .header p {
            color: #E7F3EC;
            font-size: 12px;
            margin: 4px 0 0 0;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 600;
        }
        .content {
            padding: 32px 28px;
        }
        .greeting {
            font-size: 16px;
            font-weight: bold;
            color: #1A1A1A;
            margin-bottom: 12px;
        }
        .text {
            font-size: 14px;
            line-height: 1.6;
            color: #5C6B64;
            margin-bottom: 24px;
        }
        .otp-card {
            background-color: #E7F3EC;
            border: 2px dashed #1F6F4A;
            border-radius: 16px;
            padding: 24px 16px;
            text-align: center;
            margin-bottom: 24px;
        }
        .otp-label {
            font-size: 11px;
            font-weight: 700;
            color: #1F6F4A;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            margin-bottom: 8px;
        }
        .otp-code {
            font-size: 36px;
            font-weight: 800;
            letter-spacing: 8px;
            color: #17573A;
            font-family: 'Courier New', Courier, monospace;
        }
        .warning-box {
            background-color: #FFF9ED;
            border: 1px solid #FFE4A0;
            border-radius: 12px;
            padding: 14px 16px;
            font-size: 12px;
            color: #8C6200;
            line-height: 1.5;
            margin-bottom: 20px;
        }
        .footer {
            background-color: #F9FBFA;
            border-top: 1px solid #E5EDE8;
            padding: 20px 24px;
            text-align: center;
            font-size: 11px;
            color: #8B9992;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <div style="font-size: 32px; line-height: 1;">&#128218;</div>
            <h1>Digilibrary</h1>
            <p>Perpustakaan Digital Sekolah Dasar</p>
        </div>

        <!-- Content -->
        <div class="content">
            <div class="greeting">Halo, {{ $user->name }}!</div>
            <div class="text">
                Kami menerima permintaan untuk mengatur ulang kata sandi akun Digilibrary Anda. Gunakan kode verifikasi di bawah ini pada aplikasi untuk membuat kata sandi baru:
            </div>

            <!-- OTP Code Card -->
            <div class="otp-card">
                <div class="otp-label">Kode Verifikasi Reset Password</div>
                <div class="otp-code">{{ $token }}</div>
            </div>

            <!-- Warning Note -->
            <div class="warning-box">
                &#9888; <strong>Penting:</strong> Kode verifikasi ini hanya berlaku selama <strong>60 menit</strong>. Jika Anda tidak pernah meminta perubahan kata sandi, abaikan email ini dan akun Anda akan tetap aman.
            </div>

            <div class="text" style="font-size: 13px; margin-bottom: 0;">
                Salam hangat,<br>
                <strong>Tim Perpustakaan Digital Digilibrary</strong>
            </div>
        </div>

        <!-- Footer -->
        <div class="footer">
            &copy; {{ date('Y') }} Digilibrary &mdash; Perpustakaan Digital Sekolah Dasar.<br>
            Email ini dikirim secara otomatis oleh sistem, mohon tidak membalas langsung.
        </div>
    </div>
</body>
</html>
