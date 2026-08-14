# Prompt: Aplikasi Flutter "Rumus Bangun Ruang & Datar"

Buatkan aplikasi Android menggunakan **Flutter (Dart)** dengan judul **"Rumus Bangun Ruang & Datar"**. Aplikasi ini adalah referensi sekaligus kalkulator lengkap untuk hampir semua bangun datar (2D) dan bangun ruang (3D), lengkap dengan CI/CD build APK via GitHub Actions.

## 1. Tech Stack
- Flutter versi stable terbaru, Dart null-safety
- State management sederhana: `Provider` atau `setState` (tidak perlu arsitektur berat)
- Tidak perlu backend/API, semua rumus dihitung secara lokal (offline)

## 2. Struktur Fitur Utama
- **Halaman Home**: grid/list kategori "Bangun Datar" dan "Bangun Ruang" dengan card modern
- **Halaman Detail per Bangun**: menampilkan gambar/ilustrasi sederhana (bisa pakai CustomPainter atau icon), rumus-rumus terkait, dan tombol menuju kalkulator
- **Form Kalkulator**: input variabel (misal sisi, alas, tinggi, jari-jari), auto-hitung realtime setiap kali user mengetik, hasil ditampilkan lengkap dengan satuan dan rumus yang dipakai
- **Search bar** di Home untuk mencari nama bangun dengan cepat
- **Riwayat perhitungan (opsional)**: menyimpan history hitungan terakhir secara lokal (shared_preferences)

## 3. Daftar Bangun Datar (2D) — hitung Luas & Keliling
- Persegi
- Persegi Panjang
- Segitiga (siku-siku, sembarang dengan rumus Heron)
- Lingkaran
- Trapesium
- Jajar Genjang
- Belah Ketupat
- Layang-layang
- Segi Enam Beraturan (Hexagon)
- Segi Lima Beraturan (Pentagon)

## 4. Daftar Bangun Ruang (3D) — hitung Volume & Luas Permukaan
- Kubus
- Balok
- Tabung (Silinder)
- Kerucut
- Bola
- Prisma Segitiga
- Limas Segiempat
- Limas Segitiga
- Setengah Bola (Hemisphere)

## 5. Kebutuhan UI/UX
- Desain **modern, minimalis, clean**, dengan **skema warna pastel** (contoh: soft mint, soft lavender, soft peach, soft blue) sebagai identitas visual utama
- Gunakan card dengan rounded corner, subtle shadow, dan spacing yang lega
- Font modern (misal Google Fonts: Poppins/Nunito)
- Icon custom/ilustrasi sederhana tiap bangun (boleh pakai `CustomPainter` untuk gambar bentuk geometris asli, bukan cuma icon generik)
- Animasi transisi halaman yang halus (page transition, fade/slide)
- Dark mode opsional (nice to have, bukan wajib)
- Responsive untuk berbagai ukuran layar Android

## 6. Detail Form Kalkulator
- Setiap input field pakai `TextField` dengan `keyboardType: number`, validasi input kosong/invalid
- **Auto-hitung**: hasil langsung update setiap perubahan input (pakai `onChanged`, tanpa perlu tombol "Hitung" — tapi tetap sediakan tombol "Reset")
- Tampilkan rumus yang digunakan di atas hasil (misal: `Luas = sisi × sisi`)
- Tampilkan hasil akhir dengan angka desimal rapi (2 angka di belakang koma) dan satuan yang sesuai (cm², cm³, dst — bisa dibuat dinamis/tidak wajib satuan spesifik)
- Tangani edge case: input negatif atau nol ditolak dengan pesan error yang jelas

## 7. Struktur Project
```
lib/
  main.dart
  models/          # model data tiap bangun & rumus
  screens/
    home_screen.dart
    detail_screen.dart
    calculator_screen.dart
  widgets/         # reusable widget (card, custom painter bentuk, dll)
  utils/           # kumpulan fungsi rumus matematika
  theme/           # definisi warna pastel & tema aplikasi
```

## 8. GitHub Actions — Build APK (Unsigned/Debug)
Buatkan workflow `.github/workflows/build-apk.yml` dengan ketentuan:
- Trigger: `push` ke branch `main` dan `workflow_dispatch` (manual trigger)
- Menggunakan `actions/checkout@v4` dan `subosito/flutter-action@v2` (channel stable)
- Jalankan `flutter pub get`, lalu `flutter build apk --debug` (karena APK demo belum di-sign)
- Upload hasil APK sebagai artifact build menggunakan `actions/upload-artifact@v4`, path mengarah ke `build/app/outputs/flutter-apk/app-debug.apk`
- Beri nama artifact yang jelas, misal `rumus-bangun-debug-apk`

## 9. Deliverables yang Diminta
1. Seluruh source code Flutter (semua file di `lib/`)
2. `pubspec.yaml` lengkap dengan dependency yang dipakai (google_fonts, provider, shared_preferences, dll bila digunakan)
3. File workflow GitHub Actions (`build-apk.yml`)
4. `README.md` singkat berisi cara build lokal dan cara ambil APK dari GitHub Actions Artifacts

## 10. Catatan Tambahan
- Semua rumus harus akurat secara matematis, sertakan komentar kode untuk tiap rumus agar mudah diverifikasi
- Kode harus rapi, terorganisir per file/folder sesuai struktur di atas, dan mudah dikembangkan (menambah bangun baru di kemudian hari harus mudah)
- Jangan gunakan package berbayar atau yang butuh API key eksternal
