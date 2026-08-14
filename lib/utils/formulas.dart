/// Kumpulan fungsi rumus matematika untuk bangun datar & bangun ruang.
/// Setiap fungsi diberi komentar rumus agar mudah diverifikasi.
/// Semua perhitungan memakai `double` (satuan bebas, misal cm).
library;

import 'dart:math' as math;

/// Pembulatan hasil ke 2 angka di belakang koma.
double round2(double value) => (value * 100).round() / 100;

// ==================== BANGUN DATAR (2D) ====================

/// Persegi: Luas = s × s ; Keliling = 4 × s
double luasPersegi(double sisi) => round2(sisi * sisi);
double kelilingPersegi(double sisi) => round2(4 * sisi);

/// Persegi Panjang: Luas = p × l ; Keliling = 2 × (p + l)
double luasPersegiPanjang(double panjang, double lebar) => round2(panjang * lebar);
double kelilingPersegiPanjang(double panjang, double lebar) => round2(2 * (panjang + lebar));

/// Segitiga: Luas = ½ × alas × tinggi ; Keliling = a + b + c
double luasSegitiga(double alas, double tinggi) => round2(0.5 * alas * tinggi);
double kelilingSegitiga(double a, double b, double c) => round2(a + b + c);

/// Segitiga sembarang dengan rumus Heron:
/// s = (a + b + c) / 2 ; Luas = √(s × (s-a) × (s-b) × (s-c))
double luasSegitigaHeron(double a, double b, double c) {
  final s = (a + b + c) / 2;
  return round2(math.sqrt(s * (s - a) * (s - b) * (s - c)));
}

/// Cek apakah tiga sisi dapat membentuk segitiga (pertidaksamaan segitiga).
bool validSegitiga(double a, double b, double c) =>
    a + b > c && a + c > b && b + c > a;

/// Lingkaran: Luas = π × r² ; Keliling = 2 × π × r
double luasLingkaran(double r) => round2(math.pi * r * r);
double kelilingLingkaran(double r) => round2(2 * math.pi * r);

/// Trapesium: Luas = ½ × (a + b) × t ; Keliling = a + b + c + d
double luasTrapesium(double sisiAtas, double sisiBawah, double tinggi) =>
    round2(0.5 * (sisiAtas + sisiBawah) * tinggi);
double kelilingTrapesium(double a, double b, double c, double d) =>
    round2(a + b + c + d);

/// Jajar Genjang: Luas = a × t ; Keliling = 2 × (a + b)
double luasJajarGenjang(double alas, double tinggi) => round2(alas * tinggi);
double kelilingJajarGenjang(double alas, double sisiMiring) =>
    round2(2 * (alas + sisiMiring));

/// Belah Ketupat: Luas = ½ × d1 × d2 ; Keliling = 4 × s
double luasBelahKetupat(double diagonal1, double diagonal2) =>
    round2(0.5 * diagonal1 * diagonal2);
double kelilingBelahKetupat(double sisi) => round2(4 * sisi);

/// Layang-layang: Luas = ½ × d1 × d2 ; Keliling = 2 × (a + b)
double luasLayangLayang(double diagonal1, double diagonal2) =>
    round2(0.5 * diagonal1 * diagonal2);
double kelilingLayangLayang(double sisiPendek, double sisiPanjang) =>
    round2(2 * (sisiPendek + sisiPanjang));

/// Segi enam beraturan (Hexagon): Luas = (3√3/2) × s² ; Keliling = 6 × s
double luasHexagon(double sisi) => round2((3 * math.sqrt(3) / 2) * sisi * sisi);
double kelilingHexagon(double sisi) => round2(6 * sisi);

/// Segi lima beraturan (Pentagon):
/// Luas = (1/4) × √(5(5+2√5)) × s² ≈ 1.7205 × s² ; Keliling = 5 × s
double luasPentagon(double sisi) => round2(
    0.25 * math.sqrt(5 * (5 + 2 * math.sqrt(5))) * sisi * sisi);
double kelilingPentagon(double sisi) => round2(5 * sisi);

// ==================== BANGUN RUANG (3D) ====================

/// Kubus: Volume = s³ ; Luas Permukaan = 6 × s²
double volumeKubus(double sisi) => round2(sisi * sisi * sisi);
double luasPermukaanKubus(double sisi) => round2(6 * sisi * sisi);

/// Balok: Volume = p × l × t ; Luas Permukaan = 2 × (pl + pt + lt)
double volumeBalok(double p, double l, double t) => round2(p * l * t);
double luasPermukaanBalok(double p, double l, double t) =>
    round2(2 * (p * l + p * t + l * t));

/// Tabung (Silinder):
/// Volume = π × r² × t ; Luas Permukaan = 2 × π × r × (r + t)
double volumeTabung(double r, double t) => round2(math.pi * r * r * t);
double luasPermukaanTabung(double r, double t) =>
    round2(2 * math.pi * r * (r + t));

/// Kerucut:
/// s (garis pelukis) = √(r² + t²)
/// Volume = (1/3) × π × r² × t ; Luas Permukaan = π × r × (r + s)
double garisPelukisKerucut(double r, double t) => math.sqrt(r * r + t * t);
double volumeKerucut(double r, double t) => round2(math.pi * r * r * t / 3);
double luasPermukaanKerucut(double r, double t) {
  final s = garisPelukisKerucut(r, t);
  return round2(math.pi * r * (r + s));
}

/// Bola: Volume = (4/3) × π × r³ ; Luas Permukaan = 4 × π × r²
double volumeBola(double r) => round2((4 / 3) * math.pi * r * r * r);
double luasPermukaanBola(double r) => round2(4 * math.pi * r * r);

/// Prisma Segitiga: Volume = Luas alas segitiga × t
/// (alas segitiga = ½ × alas × tinggi segitiga) ; Luas Permukaan =
/// 2 × luas alas + keliling alas × tinggi prisma
double volumePrismaSegitiga(double alasSegitiga, double tinggiSegitiga, double tPrisma) =>
    round2(0.5 * alasSegitiga * tinggiSegitiga * tPrisma);

double luasPermukaanPrismaSegitiga(
    double alasSegitiga, double tinggiSegitiga, double tPrisma,
    {double? sisiMiring1, double? sisiMiring2}) {
  // Sisi miring dihitung dengan teorema Pythagoras jika segitiga siku-siku,
  // atau dimasukkan manual (sisi a, b, c sembarang).
  final sisiA = sisiMiring1 ?? math.sqrt(math.pow(alasSegitiga / 2, 2) + math.pow(tinggiSegitiga, 2));
  final sisiB = sisiMiring2 ?? math.sqrt(math.pow(alasSegitiga / 2, 2) + math.pow(tinggiSegitiga, 2));
  final kelilingAlas = alasSegitiga + sisiA + sisiB;
  final luasAlas = 0.5 * alasSegitiga * tinggiSegitiga;
  return round2(2 * luasAlas + kelilingAlas * tPrisma);
}

/// Limas Segiempat: Volume = (1/3) × Luas alas × t
/// Luas alas = p × l ; Sisi tegak dihitung via apotema = √(t² + (sisi/2)²)
double volumeLimasSegiempat(double panjang, double lebar, double t) =>
    round2((panjang * lebar * t) / 3);

double luasPermukaanLimasSegiempat(double panjang, double lebar, double t) {
  final luasAlas = panjang * lebar;
  // Apotema sisi yang sejajar dengan panjang alas
  final apotemaP = math.sqrt(t * t + math.pow(panjang / 2, 2));
  // Apotema sisi yang sejajar dengan lebar alas
  final apotemaL = math.sqrt(t * t + math.pow(lebar / 2, 2));
  final luasSisiTegak = 2 * (0.5 * panjang * apotemaP) + 2 * (0.5 * lebar * apotemaL);
  return round2(luasAlas + luasSisiTegak);
}

/// Limas Segitiga (alas segitiga sembarang + tinggi limas):
/// Volume = (1/3) × Luas alas × t ;
/// Luas alas via Heron; luas sisi tegak didekati via tinggi sisi tegak yang
/// dihitung dari apotema ≈ √(t² + (r_in)²) dengan r_in = luas × 2 / keliling
double volumeLimasSegitiga(double a, double b, double c, double t) =>
    round2(luasSegitigaHeron(a, b, c) * t / 3);

double luasPermukaanLimasSegitiga(double a, double b, double c, double t) {
  final s = (a + b + c) / 2;
  final luasAlas = math.sqrt(s * (s - a) * (s - b) * (s - c));
  final keliling = a + b + c;
  final rIn = (2 * luasAlas) / keliling; // jari-jari lingkaran dalam alas
  final apotema = math.sqrt(t * t + rIn * rIn);
  return round2(luasAlas + 0.5 * keliling * apotema);
}

/// Setengah Bola (Hemisphere):
/// Volume = (2/3) × π × r³ ; Luas Permukaan = 3 × π × r²
/// (termasuk bidang lingkaran alas: 2πr² + πr²)
double volumeHemisphere(double r) => round2((2 / 3) * math.pi * r * r * r);
double luasPermukaanHemisphere(double r) => round2(3 * math.pi * r * r);

/// Format angka: 2 desimal, hilangkan trailing zero.
String formatAngka(double value) {
  final s = value.toStringAsFixed(2);
  return s.contains('.') ? s.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '') : s;
}
