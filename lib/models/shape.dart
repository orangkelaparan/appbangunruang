/// Model data tiap bangun & rumus.
/// Menambah bangun baru cukup menambahkan satu entry di daftar `shapes2D`
/// atau `shapes3D` — tidak perlu mengubah UI.
library;

import 'package:flutter/material.dart';
import 'package:app_bangunruang/theme/app_theme.dart';

/// Kategori bangun.
enum ShapeCategory { datar, ruang }

/// Satu variabel input pada kalkulator.
class ShapeInput {
  final String id;
  final String label;
  final String placeholder;
  final String simbol;

  const ShapeInput({
    required this.id,
    required this.label,
    required this.placeholder,
    this.simbol = '',
  });
}

/// Rumus yang ditampilkan pada detail & kalkulator.
class ShapeFormula {
  final String nama; // misal "Luas"
  final String rumusTeks; // misal "Luas = s × s"
  final String penjelasan; // deskripsi singkat variabel

  const ShapeFormula({
    required this.nama,
    required this.rumusTeks,
    required this.penjelasan,
  });
}

/// Model data satu bangun (datar atau ruang).
class Shape {
  final String id;
  final String nama;
  final ShapeCategory kategori;
  final String deskripsi;
  final Color warna;
  final IconData icon;
  final List<ShapeInput> inputs;
  final List<ShapeFormula> formulas;

  const Shape({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.deskripsi,
    required this.warna,
    required this.icon,
    required this.inputs,
    required this.formulas,
  });
}

// ==================== BANGUN DATAR (2D) ====================

const List<Shape> shapes2D = [
  Shape(
    id: 'persegi',
    nama: 'Persegi',
    kategori: ShapeCategory.datar,
    deskripsi:
        'Bangun datar dengan empat sisi sama panjang dan empat sudut siku-siku.',
    warna: AppColors.mintDark,
    icon: Icons.crop_square_outlined,
    inputs: [
      ShapeInput(id: 'sisi', label: 'Sisi', placeholder: 'Masukkan panjang sisi'),
    ],
    formulas: [
      ShapeFormula(
        nama: 'Luas',
        rumusTeks: 'Luas = sisi × sisi',
        penjelasan: 's = panjang sisi persegi',
      ),
      ShapeFormula(
        nama: 'Keliling',
        rumusTeks: 'Keliling = 4 × sisi',
        penjelasan: 's = panjang sisi persegi',
      ),
    ],
  ),
  Shape(
    id: 'persegi_panjang',
    nama: 'Persegi Panjang',
    kategori: ShapeCategory.datar,
    deskripsi:
        'Bangun datar dengan dua pasang sisi sejajar sama panjang dan empat sudut siku-siku.',
    warna: AppColors.softBlueDark,
    icon: Icons.rectangle_outlined,
    inputs: [
      ShapeInput(id: 'panjang', label: 'Panjang', placeholder: 'Masukkan panjang'),
      ShapeInput(id: 'lebar', label: 'Lebar', placeholder: 'Masukkan lebar'),
    ],
    formulas: [
      ShapeFormula(
        nama: 'Luas',
        rumusTeks: 'Luas = panjang × lebar',
        penjelasan: 'p = panjang, l = lebar',
      ),
      ShapeFormula(
        nama: 'Keliling',
        rumusTeks: 'Keliling = 2 × (panjang + lebar)',
        penjelasan: 'p = panjang, l = lebar',
      ),
    ],
  ),
  Shape(
    id: 'segitiga',
    nama: 'Segitiga',
    kategori: ShapeCategory.datar,
    deskripsi:
        'Bangun datar dengan tiga sisi. Luas memakai alas dan tinggi; keliling memakai tiga sisi.',
    warna: AppColors.peachDark,
    icon: Icons.change_history_outlined,
    inputs: [
      ShapeInput(id: 'alas', label: 'Alas', placeholder: 'Masukkan panjang alas'),
      ShapeInput(id: 'tinggi', label: 'Tinggi', placeholder: 'Masukkan tinggi'),
      ShapeInput(id: 'sisiA', label: 'Sisi A', placeholder: 'Masukkan sisi A'),
      ShapeInput(id: 'sisiB', label: 'Sisi B', placeholder: 'Masukkan sisi B'),
      ShapeInput(id: 'sisiC', label: 'Sisi C', placeholder: 'Masukkan sisi C'),
    ],
    formulas: [
      ShapeFormula(
        nama: 'Luas',
        rumusTeks: 'Luas = ½ × alas × tinggi',
        penjelasan: 'alas dan tinggi segitiga',
      ),
      ShapeFormula(
        nama: 'Keliling',
        rumusTeks: 'Keliling = sisi A + sisi B + sisi C',
        penjelasan: 'jumlah ketiga sisi segitiga',
      ),
    ],
  ),
  Shape(
    id: 'lingkaran',
    nama: 'Lingkaran',
    kategori: ShapeCategory.datar,
    deskripsi:
        'Bangun datar yang terdiri dari semua titik berjarak sama dari titik pusat.',
    warna: AppColors.lavenderDark,
    icon: Icons.circle_outlined,
    inputs: [
      ShapeInput(id: 'jariJari', label: 'Jari-jari (r)', placeholder: 'Masukkan jari-jari'),
    ],
    formulas: [
      ShapeFormula(
        nama: 'Luas',
        rumusTeks: 'Luas = π × r²',
        penjelasan: 'r = jari-jari lingkaran, π ≈ 3,14159',
      ),
      ShapeFormula(
        nama: 'Keliling',
        rumusTeks: 'Keliling = 2 × π × r',
        penjelasan: 'r = jari-jari lingkaran',
      ),
    ],
  ),
  Shape(
    id: 'trapesium',
    nama: 'Trapesium',
    kategori: ShapeCategory.datar,
    deskripsi:
        'Bangun datar segiempat dengan sepasang sisi sejajar (sisi atas & sisi bawah).',
    warna: AppColors.mintDark,
    icon: Icons.check_box_outline_blank_outlined,
    inputs: [
      ShapeInput(id: 'sisiAtas', label: 'Sisi Atas', placeholder: 'Masukkan sisi atas'),
      ShapeInput(id: 'sisiBawah', label: 'Sisi Bawah', placeholder: 'Masukkan sisi bawah'),
      ShapeInput(id: 'tinggi', label: 'Tinggi', placeholder: 'Masukkan tinggi'),
      ShapeInput(id: 'sisiC', label: 'Sisi Miring C', placeholder: 'Masukkan sisi miring C'),
      ShapeInput(id: 'sisiD', label: 'Sisi Miring D', placeholder: 'Masukkan sisi miring D'),
    ],
    formulas: [
      ShapeFormula(
        nama: 'Luas',
        rumusTeks: 'Luas = ½ × (sisi atas + sisi bawah) × tinggi',
        penjelasan: 'kedua sisi sejajar dan tinggi trapesium',
      ),
      ShapeFormula(
        nama: 'Keliling',
        rumusTeks: 'Keliling = sisi atas + sisi bawah + sisi C + sisi D',
        penjelasan: 'jumlah keempat sisi trapesium',
      ),
    ],
  ),
  Shape(
    id: 'jajar_genjang',
    nama: 'Jajar Genjang',
    kategori: ShapeCategory.datar,
    deskripsi:
        'Bangun datar segiempat dengan dua pasang sisi sejajar & sama panjang.',
    warna: AppColors.peachDark,
    icon: Icons.transform_outlined,
    inputs: [
      ShapeInput(id: 'alas', label: 'Alas', placeholder: 'Masukkan panjang alas'),
      ShapeInput(id: 'tinggi', label: 'Tinggi', placeholder: 'Masukkan tinggi'),
      ShapeInput(id: 'sisiMiring', label: 'Sisi Miring', placeholder: 'Masukkan sisi miring'),
    ],
    formulas: [
      ShapeFormula(
        nama: 'Luas',
        rumusTeks: 'Luas = alas × tinggi',
        penjelasan: 'a = alas, t = tinggi jajar genjang',
      ),
      ShapeFormula(
        nama: 'Keliling',
        rumusTeks: 'Keliling = 2 × (alas + sisi miring)',
        penjelasan: 'a = alas, b = sisi miring',
      ),
    ],
  ),
  Shape(
    id: 'belah_ketupat',
    nama: 'Belah Ketupat',
    kategori: ShapeCategory.datar,
    deskripsi:
        'Bangun datar dengan empat sisi sama panjang dan dua diagonal berpotongan tegak lurus.',
    warna: AppColors.lavenderDark,
    icon: Icons.diamond_outlined,
    inputs: [
      ShapeInput(id: 'diagonal1', label: 'Diagonal 1 (d1)', placeholder: 'Masukkan diagonal 1'),
      ShapeInput(id: 'diagonal2', label: 'Diagonal 2 (d2)', placeholder: 'Masukkan diagonal 2'),
      ShapeInput(id: 'sisi', label: 'Sisi', placeholder: 'Masukkan panjang sisi'),
    ],
    formulas: [
      ShapeFormula(
        nama: 'Luas',
        rumusTeks: 'Luas = ½ × d1 × d2',
        penjelasan: 'd1 dan d2 = panjang kedua diagonal',
      ),
      ShapeFormula(
        nama: 'Keliling',
        rumusTeks: 'Keliling = 4 × sisi',
        penjelasan: 's = panjang sisi belah ketupat',
      ),
    ],
  ),
  Shape(
    id: 'layang_layang',
    nama: 'Layang-layang',
    kategori: ShapeCategory.datar,
    deskripsi:
        'Bangun datar dengan dua pasang sisi sama panjang dan diagonal berpotongan tegak lurus.',
    warna: AppColors.softBlueDark,
    icon: Icons.airplay_outlined,
    inputs: [
      ShapeInput(id: 'diagonal1', label: 'Diagonal 1 (d1)', placeholder: 'Masukkan diagonal 1'),
      ShapeInput(id: 'diagonal2', label: 'Diagonal 2 (d2)', placeholder: 'Masukkan diagonal 2'),
      ShapeInput(id: 'sisiPendek', label: 'Sisi Pendek', placeholder: 'Masukkan sisi pendek'),
      ShapeInput(id: 'sisiPanjang', label: 'Sisi Panjang', placeholder: 'Masukkan sisi panjang'),
    ],
    formulas: [
      ShapeFormula(
        nama: 'Luas',
        rumusTeks: 'Luas = ½ × d1 × d2',
        penjelasan: 'd1 dan d2 = panjang kedua diagonal',
      ),
      ShapeFormula(
        nama: 'Keliling',
        rumusTeks: 'Keliling = 2 × (sisi pendek + sisi panjang)',
        penjelasan: 'a = sisi pendek, b = sisi panjang',
      ),
    ],
  ),
  Shape(
    id: 'hexagon',
    nama: 'Segi Enam Beraturan',
    kategori: ShapeCategory.datar,
    deskripsi:
        'Bangun datar dengan enam sisi sama panjang dan enam sudut sama besar (120°).',
    warna: AppColors.mintDark,
    icon: Icons.hexagon_outlined,
    inputs: [
      ShapeInput(id: 'sisi', label: 'Sisi', placeholder: 'Masukkan panjang sisi'),
    ],
    formulas: [
      ShapeFormula(
        nama: 'Luas',
        rumusTeks: 'Luas = (3√3 ÷ 2) × s²',
        penjelasan: 's = panjang sisi hexagon, √3 ≈ 1,732',
      ),
      ShapeFormula(
        nama: 'Keliling',
        rumusTeks: 'Keliling = 6 × sisi',
        penjelasan: 's = panjang sisi hexagon',
      ),
    ],
  ),
  Shape(
    id: 'pentagon',
    nama: 'Segi Lima Beraturan',
    kategori: ShapeCategory.datar,
    deskripsi:
        'Bangun datar dengan lima sisi sama panjang dan lima sudut sama besar (108°).',
    warna: AppColors.peachDark,
    icon: Icons.pentagon_outlined,
    inputs: [
      ShapeInput(id: 'sisi', label: 'Sisi', placeholder: 'Masukkan panjang sisi'),
    ],
    formulas: [
      ShapeFormula(
        nama: 'Luas',
        rumusTeks: 'Luas = ¼ × √(5(5+2√5)) × s² ≈ 1,72 × s²',
        penjelasan: 's = panjang sisi pentagon',
      ),
      ShapeFormula(
        nama: 'Keliling',
        rumusTeks: 'Keliling = 5 × sisi',
        penjelasan: 's = panjang sisi pentagon',
      ),
    ],
  ),
];

// ==================== BANGUN RUANG (3D) ====================

const List<Shape> shapes3D = [
  Shape(
    id: 'kubus',
    nama: 'Kubus',
    kategori: ShapeCategory.ruang,
    deskripsi: 'Bangun ruang dengan enam sisi persegi yang sama besar.',
    warna: AppColors.mintDark,
    icon: Icons.check_box_outline_blank_outlined,
    inputs: [
      ShapeInput(id: 'sisi', label: 'Sisi (rusuk)', placeholder: 'Masukkan panjang rusuk'),
    ],
    formulas: [
      ShapeFormula(
        nama: 'Volume',
        rumusTeks: 'Volume = s³',
        penjelasan: 's = panjang rusuk kubus',
      ),
      ShapeFormula(
        nama: 'Luas Permukaan',
        rumusTeks: 'Luas Permukaan = 6 × s²',
        penjelasan: 's = panjang rusuk kubus',
      ),
    ],
  ),
  Shape(
    id: 'balok',
    nama: 'Balok',
    kategori: ShapeCategory.ruang,
    deskripsi: 'Bangun ruang dengan tiga pasang sisi persegi panjang.',
    warna: AppColors.softBlueDark,
    icon: Icons.view_in_ar_outlined,
    inputs: [
      ShapeInput(id: 'panjang', label: 'Panjang', placeholder: 'Masukkan panjang'),
      ShapeInput(id: 'lebar', label: 'Lebar', placeholder: 'Masukkan lebar'),
      ShapeInput(id: 'tinggi', label: 'Tinggi', placeholder: 'Masukkan tinggi'),
    ],
    formulas: [
      ShapeFormula(
        nama: 'Volume',
        rumusTeks: 'Volume = p × l × t',
        penjelasan: 'p = panjang, l = lebar, t = tinggi',
      ),
      ShapeFormula(
        nama: 'Luas Permukaan',
        rumusTeks: 'Luas Permukaan = 2 × (pl + pt + lt)',
        penjelasan: 'p = panjang, l = lebar, t = tinggi',
      ),
    ],
  ),
  Shape(
    id: 'tabung',
    nama: 'Tabung (Silinder)',
    kategori: ShapeCategory.ruang,
    deskripsi: 'Bangun ruang dengan alas & tutup lingkaran dan selimut lengkung.',
    warna: AppColors.lavenderDark,
    icon: Icons.view_column_outlined,
    inputs: [
      ShapeInput(id: 'jariJari', label: 'Jari-jari (r)', placeholder: 'Masukkan jari-jari'),
      ShapeInput(id: 'tinggi', label: 'Tinggi (t)', placeholder: 'Masukkan tinggi'),
    ],
    formulas: [
      ShapeFormula(
        nama: 'Volume',
        rumusTeks: 'Volume = π × r² × t',
        penjelasan: 'r = jari-jari alas, t = tinggi tabung',
      ),
      ShapeFormula(
        nama: 'Luas Permukaan',
        rumusTeks: 'Luas Permukaan = 2 × π × r × (r + t)',
        penjelasan: 'r = jari-jari, t = tinggi tabung',
      ),
    ],
  ),
  Shape(
    id: 'kerucut',
    nama: 'Kerucut',
    kategori: ShapeCategory.ruang,
    deskripsi: 'Bangun ruang dengan alas lingkaran dan satu titik puncak.',
    warna: AppColors.peachDark,
    icon: Icons.near_me_outlined,
    inputs: [
      ShapeInput(id: 'jariJari', label: 'Jari-jari (r)', placeholder: 'Masukkan jari-jari'),
      ShapeInput(id: 'tinggi', label: 'Tinggi (t)', placeholder: 'Masukkan tinggi'),
    ],
    formulas: [
      ShapeFormula(
        nama: 'Garis Pelukis',
        rumusTeks: 's = √(r² + t²)',
        penjelasan: 's = garis pelukis, r = jari-jari, t = tinggi',
      ),
      ShapeFormula(
        nama: 'Volume',
        rumusTeks: 'Volume = ⅓ × π × r² × t',
        penjelasan: 'r = jari-jari alas, t = tinggi kerucut',
      ),
      ShapeFormula(
        nama: 'Luas Permukaan',
        rumusTeks: 'Luas Permukaan = π × r × (r + s)',
        penjelasan: 's = garis pelukis = √(r² + t²)',
      ),
    ],
  ),
  Shape(
    id: 'bola',
    nama: 'Bola',
    kategori: ShapeCategory.ruang,
    deskripsi: 'Bangun ruang yang semua titik permukaannya berjarak sama dari pusat.',
    warna: AppColors.mintDark,
    icon: Icons.sports_soccer_outlined,
    inputs: [
      ShapeInput(id: 'jariJari', label: 'Jari-jari (r)', placeholder: 'Masukkan jari-jari'),
    ],
    formulas: [
      ShapeFormula(
        nama: 'Volume',
        rumusTeks: 'Volume = 4/3 × π × r³',
        penjelasan: 'r = jari-jari bola',
      ),
      ShapeFormula(
        nama: 'Luas Permukaan',
        rumusTeks: 'Luas Permukaan = 4 × π × r²',
        penjelasan: 'r = jari-jari bola',
      ),
    ],
  ),
  Shape(
    id: 'prisma_segitiga',
    nama: 'Prisma Segitiga',
    kategori: ShapeCategory.ruang,
    deskripsi: 'Bangun ruang dengan alas & tutup berbentuk segitiga dan tiga sisi tegak.',
    warna: AppColors.softBlueDark,
    icon: Icons.filter_none_outlined,
    inputs: [
      ShapeInput(id: 'alasSegitiga', label: 'Alas Segitiga', placeholder: 'Masukkan alas segitiga'),
      ShapeInput(id: 'tinggiSegitiga', label: 'Tinggi Segitiga', placeholder: 'Masukkan tinggi segitiga'),
      ShapeInput(id: 'tPrisma', label: 'Tinggi Prisma', placeholder: 'Masukkan tinggi prisma'),
      ShapeInput(id: 'sisiMiring1', label: 'Sisi Miring 1 (opsional)', placeholder: 'Sisi miring segitiga 1'),
      ShapeInput(id: 'sisiMiring2', label: 'Sisi Miring 2 (opsional)', placeholder: 'Sisi miring segitiga 2'),
    ],
    formulas: [
      ShapeFormula(
        nama: 'Volume',
        rumusTeks: 'Volume = (½ × alas × tinggi segitiga) × t',
        penjelasan: 'luas alas segitiga × tinggi prisma',
      ),
      ShapeFormula(
        nama: 'Luas Permukaan',
        rumusTeks: 'Luas = 2 × luas alas + keliling alas × t',
        penjelasan: 'dua alas segitiga + tiga sisi tegak',
      ),
    ],
  ),
  Shape(
    id: 'limas_segiempat',
    nama: 'Limas Segiempat',
    kategori: ShapeCategory.ruang,
    deskripsi: 'Bangun ruang dengan alas persegi/persegi panjang dan empat sisi tegak segitiga.',
    warna: AppColors.lavenderDark,
    icon: Icons.terrain_outlined,
    inputs: [
      ShapeInput(id: 'panjang', label: 'Panjang Alas', placeholder: 'Masukkan panjang alas'),
      ShapeInput(id: 'lebar', label: 'Lebar Alas', placeholder: 'Masukkan lebar alas'),
      ShapeInput(id: 'tinggi', label: 'Tinggi Limas', placeholder: 'Masukkan tinggi limas'),
    ],
    formulas: [
      ShapeFormula(
        nama: 'Volume',
        rumusTeks: 'Volume = ⅓ × (p × l) × t',
        penjelasan: '⅓ × luas alas × tinggi limas',
      ),
      ShapeFormula(
        nama: 'Luas Permukaan',
        rumusTeks: 'Luas = luas alas + luas keempat sisi tegak',
        penjelasan: 'sisi tegak dihitung via apotema = √(t² + (sisi÷2)²)',
      ),
    ],
  ),
  Shape(
    id: 'limas_segitiga',
    nama: 'Limas Segitiga',
    kategori: ShapeCategory.ruang,
    deskripsi: 'Bangun ruang dengan alas segitiga dan tiga sisi tegak segitiga.',
    warna: AppColors.peachDark,
    icon: Icons.change_history_outlined,
    inputs: [
      ShapeInput(id: 'sisiA', label: 'Sisi Alas A', placeholder: 'Masukkan sisi A'),
      ShapeInput(id: 'sisiB', label: 'Sisi Alas B', placeholder: 'Masukkan sisi B'),
      ShapeInput(id: 'sisiC', label: 'Sisi Alas C', placeholder: 'Masukkan sisi C'),
      ShapeInput(id: 'tinggi', label: 'Tinggi Limas', placeholder: 'Masukkan tinggi limas'),
    ],
    formulas: [
      ShapeFormula(
        nama: 'Luas Alas (Heron)',
        rumusTeks: 'Luas alas = √(s(s-a)(s-b)(s-c)), s = (a+b+c)/2',
        penjelasan: 'rumus Heron untuk segitiga sembarang',
      ),
      ShapeFormula(
        nama: 'Volume',
        rumusTeks: 'Volume = ⅓ × luas alas × t',
        penjelasan: 't = tinggi limas',
      ),
      ShapeFormula(
        nama: 'Luas Permukaan',
        rumusTeks: 'Luas = luas alas + ½ × keliling alas × apotema',
        penjelasan: 'apotema ≈ √(t² + rᵢn²), rᵢn = 2×luas÷keliling',
      ),
    ],
  ),
  Shape(
    id: 'hemisphere',
    nama: 'Setengah Bola',
    kategori: ShapeCategory.ruang,
    deskripsi: 'Bangun ruang hasil pemotongan bola menjadi dua bagian sama besar.',
    warna: AppColors.mintDark,
    icon: Icons.wb_twilight_outlined,
    inputs: [
      ShapeInput(id: 'jariJari', label: 'Jari-jari (r)', placeholder: 'Masukkan jari-jari'),
    ],
    formulas: [
      ShapeFormula(
        nama: 'Volume',
        rumusTeks: 'Volume = ⅔ × π × r³',
        penjelasan: 'setengah dari volume bola',
      ),
      ShapeFormula(
        nama: 'Luas Permukaan',
        rumusTeks: 'Luas Permukaan = 3 × π × r²',
        penjelasan: 'selimut 2πr² + alas lingkaran πr²',
      ),
    ],
  ),
];

/// Gabungan semua bangun untuk pencarian.
List<Shape> get allShapes => [...shapes2D, ...shapes3D];

/// Satuan hasil bangun datar & ruang.
const String satuanLuas = 'satuan²';
const String satuanKeliling = 'satuan';
const String satuanVolume = 'satuan³';
