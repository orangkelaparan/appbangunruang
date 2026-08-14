// Verifikasi akurasi matematis seluruh rumus bangun datar & ruang.
import 'dart:math' as math;
import 'package:flutter_test/flutter_test.dart';
import 'package:app_bangunruang/utils/formulas.dart';

void main() {
  group('Bangun Datar (2D)', () {
    test('Persegi sisi 5', () {
      expect(luasPersegi(5), 25);
      expect(kelilingPersegi(5), 20);
    });

    test('Persegi Panjang 4 × 6', () {
      expect(luasPersegiPanjang(4, 6), 24);
      expect(kelilingPersegiPanjang(4, 6), 20);
    });

    test('Segitiga alas 8 tinggi 5', () {
      expect(luasSegitiga(8, 5), 20);
      expect(kelilingSegitiga(3, 4, 5), 12);
    });

    test('Segitiga Heron sisi 3, 4, 5 (segitiga siku-siku)', () {
      expect(luasSegitigaHeron(3, 4, 5), 6);
    });

    test('Lingkaran r = 7', () {
      expect(luasLingkaran(7), round2(math.pi * 49));
      expect(kelilingLingkaran(7), round2(2 * math.pi * 7));
    });

    test('Trapesium 6, 10, tinggi 4, sisi miring 5, 5', () {
      expect(luasTrapesium(6, 10, 4), 32);
      expect(kelilingTrapesium(6, 10, 5, 5), 26);
    });

    test('Jajar Genjang alas 6 tinggi 4 sisi 5', () {
      expect(luasJajarGenjang(6, 4), 24);
      expect(kelilingJajarGenjang(6, 5), 22);
    });

    test('Belah Ketupat diagonal 6, 8 sisi 5', () {
      expect(luasBelahKetupat(6, 8), 24);
      expect(kelilingBelahKetupat(5), 20);
    });

    test('Layang-layang diagonal 6, 10 sisi 4, 7', () {
      expect(luasLayangLayang(6, 10), 30);
      expect(kelilingLayangLayang(4, 7), 22);
    });

    test('Hexagon sisi 4', () {
      expect(luasHexagon(4), round2((3 * math.sqrt(3) / 2) * 16));
      expect(kelilingHexagon(4), 24);
    });

    test('Pentagon sisi 5', () {
      expect(luasPentagon(5), round2(0.25 * math.sqrt(5 * (5 + 2 * math.sqrt(5))) * 25));
      expect(kelilingPentagon(5), 25);
    });
  });

  group('Bangun Ruang (3D)', () {
    test('Kubus rusuk 3', () {
      expect(volumeKubus(3), 27);
      expect(luasPermukaanKubus(3), 54);
    });

    test('Balok 2 × 3 × 4', () {
      expect(volumeBalok(2, 3, 4), 24);
      expect(luasPermukaanBalok(2, 3, 4), 52);
    });

    test('Tabung r = 7, t = 10', () {
      expect(volumeTabung(7, 10), round2(math.pi * 49 * 10));
      expect(luasPermukaanTabung(7, 10), round2(2 * math.pi * 7 * 17));
    });

    test('Kerucut r = 3, t = 4 (pelukis 5)', () {
      expect(volumeKerucut(3, 4), round2(math.pi * 9 * 4 / 3));
      expect(luasPermukaanKerucut(3, 4), round2(math.pi * 3 * 8));
    });

    test('Bola r = 6', () {
      expect(volumeBola(6), round2((4 / 3) * math.pi * 216));
      expect(luasPermukaanBola(6), round2(4 * math.pi * 36));
    });

    test('Prisma Segitiga alas 6 tinggi 4 prisma 10', () {
      expect(volumePrismaSegitiga(6, 4, 10), 120);
    });

    test('Limas Segiempat 6 × 6 tinggi 4', () {
      expect(volumeLimasSegiempat(6, 6, 4), 48);
    });

    test('Limas Segitiga sisi 3,4,5 tinggi 10', () {
      // Luas alas Heron = 6, volume = 1/3 × 6 × 10 = 20
      expect(volumeLimasSegitiga(3, 4, 5, 10), 20);
    });

    test('Hemisphere r = 6', () {
      expect(volumeHemisphere(6), round2((2 / 3) * math.pi * 216));
      expect(luasPermukaanHemisphere(6), round2(3 * math.pi * 36));
    });
  });
}
