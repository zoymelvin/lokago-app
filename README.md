# LokaGo - Mobile Travel & Activity Booking App

LokaGo adalah aplikasi pemesanan aktivitas wisata dan perjalanan berbasis mobile yang dibangun menggunakan **Flutter**. Aplikasi ini memungkinkan pengguna untuk menjelajahi berbagai destinasi, mengelola keranjang belanja, melakukan transaksi pembayaran secara instan, dan melihat e-tiket langsung dari perangkat mereka.

## 🚀 Fitur Utama

- **Authentication**: Sistem registrasi dan login yang aman menggunakan integrasi API.
- **Activity Discovery**: Penjelajahan aktivitas berdasarkan kategori dan pencarian real-time.
- **Direct Booking**: Fitur "Pesan Sekarang" yang mempercepat proses checkout tanpa harus masuk ke keranjang.
- **Cart Management**: Mengelola daftar aktivitas yang ingin dipesan sebelum melakukan pembayaran.
- **Payment Integration**: Mendukung berbagai metode pembayaran (Virtual Account, dll) dengan status transaksi real-time.
- **E-Ticket System**: Akses tiket digital dengan barcode unik setelah pembayaran berhasil.
- **Profile Management**: Update informasi pengguna dan pengelolaan akun.

## 🛠️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **Language**: [Dart](https://dart.dev/)
- **State Management**: [Flutter BLoC](https://pub.dev/packages/flutter_bloc) (Business Logic Component)
- **Networking**: [Dio](https://pub.dev/packages/dio) for API calls
- **Local Storage**: [Shared Preferences](https://pub.dev/packages/shared_preferences)
- **UI Components**: Google Fonts, Barcode Widget, WebView Flutter.

## 📂 Struktur Proyek

Aplikasi ini mengikuti prinsip **Clean Architecture** (Data, Domain, Presentation) untuk memastikan kode mudah dipelihara dan diuji:

```text
lib/
├── core/               # Konfigurasi network, utilitas, dan konstanta
├── data/               # Model data dan implementasi repository
│   ├── models/         # Data Transfer Objects (DTO)
│   └── repositories/   # Logika komunikasi dengan API
├── presentation/       # UI Layer
│   ├── blocs/          # State Management (Auth, Cart, Home, Payment, User)
│   ├── pages/          # Halaman utama aplikasi
│   └── widgets/        # Komponen UI yang dapat digunakan kembali
└── main.dart           # Titik masuk aplikasi & Dependency Injection
```

## ⚙️ Instalasi

Pastikan Anda telah menginstal Flutter di lingkungan pengembangan Anda.

1. Clone repositori ini:
```bash
git clone https://github.com/zoymelvin/lokago-app.git
```

2. Masuk ke direktori proyek:
```bash
cd lokago-app
```

3. Instal dependensi:
```bash
flutter pub get
```

4. Jalankan aplikasi:
```bash
flutter run
```

## 📝 Konfigurasi API

Aplikasi ini terhubung dengan API backend. Pastikan URL dasar API sudah dikonfigurasi pada file: `lib/core/constants/api_constants.dart`

```dart
class ApiConstants {
  static const String baseUrl = 'URL_API_ANDA';
}
```

Dibuat d oleh Joy Melvin Ginting
