# Rumus Bangun Ruang & Datar

Aplikasi Android (Flutter/Dart) sebagai referensi sekaligus kalkulator lengkap untuk bangun datar (2D) dan bangun ruang (3D). Desain modern minimalis dengan skema warna pastel (soft mint, lavender, peach, blue).

## Fitur

- **Halaman Home**: grid card kategori Bangun Datar & Bangun Ruang + search bar
- **Halaman Detail**: ilustrasi bentuk geometris (CustomPainter), daftar rumus, tombol ke kalkulator
- **Kalkulator**: auto-hitung realtime saat mengetik, rumus dipakai ditampilkan di atas hasil, validasi input, tombol Reset, satuan dinamis
- **Riwayat perhitungan**: tersimpan lokal via `shared_preferences`
- **Dark mode** opsional
- 10 bangun datar (Luas & Keliling) dan 9 bangun ruang (Volume & Luas Permukaan)

## Bangun Datar (2D)

Persegi, Persegi Panjang, Segitiga (alas×tinggi + Heron), Lingkaran, Trapesium, Jajar Genjang, Belah Ketupat, Layang-layang, Segi Enam Beraturan, Segi Lima Beraturan.

## Bangun Ruang (3D)

Kubus, Balok, Tabung, Kerucut, Bola, Prisma Segitiga, Limas Segiempat, Limas Segitiga, Setengah Bola (Hemisphere).

## Struktur Project

```
lib/
  main.dart                      # entry point, Provider, tema
  models/shape.dart              # model data tiap bangun & rumus
  screens/
    home_screen.dart             # grid kategori + search
    detail_screen.dart           # ilustrasi + rumus
    calculator_screen.dart       # form auto-hitung realtime
  widgets/
    shape_painter.dart           # CustomPainter ilustrasi bentuk
    history_provider.dart        # riwayat perhitungan (shared_preferences)
  utils/formulas.dart            # fungsi rumus matematika
  theme/app_theme.dart           # warna pastel & tema terang/gelap
.github/workflows/build-apk.yml  # CI/CD build APK
```

## Build Lokal

```bash
flutter pub get
flutter run            # jalankan di emulator/perangkat
flutter build apk --debug   # build APK demo (unsigned)
```

APK hasil build ada di `build/app/outputs/flutter-apk/app-debug.apk`.

## Ambil APK dari GitHub Actions

1. Push ke branch `main` akan otomatis memicu workflow **Build APK** (juga bisa manual via *Actions → Build APK → Run workflow*).
2. Buka tab **Actions** di repo, pilih run terbaru.
3. Di bagian **Artifacts**, klik **rumus-bangun-debug-apk** untuk mengunduh `app-debug.apk`.

## Cara Menambah Bangun Baru

Tambahkan satu entry di daftar `shapes2D` atau `shapes3D` pada `lib/models/shape.dart`, lalu tambahkan branch kalkulasi di fungsi `calculate()` pada `lib/screens/calculator_screen.dart` dan fungsi rumus di `lib/utils/formulas.dart`. UI otomatis menyesuaikan.
