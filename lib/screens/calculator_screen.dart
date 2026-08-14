/// Form Kalkulator: input variabel dengan auto-hitung realtime (onChanged),
/// tanpa perlu tombol "Hitung" (tombol "Reset" tetap disediakan).
/// Hasil ditampilkan lengkap dengan satuan, rumus yang dipakai, dan
/// validasi input kosong/invalid/negatif.
library;

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:app_bangunruang/models/shape.dart';
import 'package:app_bangunruang/theme/app_theme.dart';
import 'package:app_bangunruang/utils/formulas.dart';
import 'package:app_bangunruang/widgets/history_provider.dart';

/// Kalkulasi satu bentuk bangun berdasarkan id & nilai input.
class _CalcResult {
  final List<({String nama, String formula, String value, String satuan})> hasil;
  final Map<String, String> errors; // id input -> pesan error

  const _CalcResult({required this.hasil, required this.errors});
}

_CalcResult calculate(String id, Map<String, double> values) {
  final errors = <String, String>{};
  final hasil = <({String nama, String formula, String value, String satuan})>[];

  switch (id) {
    case 'persegi':
      final s = values['sisi']!;
      if (s <= 0) errors['sisi'] = 'Sisi harus lebih dari 0';
      if (errors.isEmpty) {
        hasil.add((
          nama: 'Luas',
          formula: 'Luas = sisi × sisi = ${formatAngka(s)} × ${formatAngka(s)}',
          value: formatAngka(luasPersegi(s)),
          satuan: satuanLuas,
        ));
        hasil.add((
          nama: 'Keliling',
          formula: 'Keliling = 4 × sisi = 4 × ${formatAngka(s)}',
          value: formatAngka(kelilingPersegi(s)),
          satuan: satuanKeliling,
        ));
      }
      break;
    case 'persegi_panjang':
      final p = values['panjang']!;
      final l = values['lebar']!;
      if (p <= 0) errors['panjang'] = 'Panjang harus lebih dari 0';
      if (l <= 0) errors['lebar'] = 'Lebar harus lebih dari 0';
      if (errors.isEmpty) {
        hasil.add((
          nama: 'Luas',
          formula: 'Luas = p × l = ${formatAngka(p)} × ${formatAngka(l)}',
          value: formatAngka(luasPersegiPanjang(p, l)),
          satuan: satuanLuas,
        ));
        hasil.add((
          nama: 'Keliling',
          formula: 'Keliling = 2 × (p + l) = 2 × (${formatAngka(p)} + ${formatAngka(l)})',
          value: formatAngka(kelilingPersegiPanjang(p, l)),
          satuan: satuanKeliling,
        ));
      }
      break;
    case 'segitiga':
      final a = values['alas']!;
      final t = values['tinggi']!;
      final sa = values['sisiA']!;
      final sb = values['sisiB']!;
      final sc = values['sisiC']!;
      if (a <= 0) errors['alas'] = 'Alas harus lebih dari 0';
      if (t <= 0) errors['tinggi'] = 'Tinggi harus lebih dari 0';
      if (sa <= 0) errors['sisiA'] = 'Sisi harus lebih dari 0';
      if (sb <= 0) errors['sisiB'] = 'Sisi harus lebih dari 0';
      if (sc <= 0) errors['sisiC'] = 'Sisi harus lebih dari 0';
      if (sa + sb <= sc || sa + sc <= sb || sb + sc <= sa) {
        errors['sisiC'] = 'Ketiga sisi tidak dapat membentuk segitiga';
      }
      if (errors.isEmpty) {
        hasil.add((
          nama: 'Luas',
          formula: 'Luas = ½ × alas × tinggi = ½ × ${formatAngka(a)} × ${formatAngka(t)}',
          value: formatAngka(luasSegitiga(a, t)),
          satuan: satuanLuas,
        ));
        hasil.add((
          nama: 'Keliling',
          formula: 'Keliling = ${formatAngka(sa)} + ${formatAngka(sb)} + ${formatAngka(sc)}',
          value: formatAngka(kelilingSegitiga(sa, sb, sc)),
          satuan: satuanKeliling,
        ));
      }
      break;
    case 'lingkaran':
      final r = values['jariJari']!;
      if (r <= 0) errors['jariJari'] = 'Jari-jari harus lebih dari 0';
      if (errors.isEmpty) {
        hasil.add((
          nama: 'Luas',
          formula: 'Luas = π × r² = π × ${formatAngka(r)}²',
          value: formatAngka(luasLingkaran(r)),
          satuan: satuanLuas,
        ));
        hasil.add((
          nama: 'Keliling',
          formula: 'Keliling = 2 × π × r = 2 × π × ${formatAngka(r)}',
          value: formatAngka(kelilingLingkaran(r)),
          satuan: satuanKeliling,
        ));
      }
      break;
    case 'trapesium':
      final at = values['sisiAtas']!;
      final ab = values['sisiBawah']!;
      final t = values['tinggi']!;
      final c = values['sisiC']!;
      final d = values['sisiD']!;
      if (at <= 0) errors['sisiAtas'] = 'Sisi atas harus lebih dari 0';
      if (ab <= 0) errors['sisiBawah'] = 'Sisi bawah harus lebih dari 0';
      if (t <= 0) errors['tinggi'] = 'Tinggi harus lebih dari 0';
      if (c <= 0) errors['sisiC'] = 'Sisi miring harus lebih dari 0';
      if (d <= 0) errors['sisiD'] = 'Sisi miring harus lebih dari 0';
      if (errors.isEmpty) {
        hasil.add((
          nama: 'Luas',
          formula: 'Luas = ½ × (a + b) × t = ½ × (${formatAngka(at)} + ${formatAngka(ab)}) × ${formatAngka(t)}',
          value: formatAngka(luasTrapesium(at, ab, t)),
          satuan: satuanLuas,
        ));
        hasil.add((
          nama: 'Keliling',
          formula: 'Keliling = ${formatAngka(at)} + ${formatAngka(ab)} + ${formatAngka(c)} + ${formatAngka(d)}',
          value: formatAngka(kelilingTrapesium(at, ab, c, d)),
          satuan: satuanKeliling,
        ));
      }
      break;
    case 'jajar_genjang':
      final a = values['alas']!;
      final t = values['tinggi']!;
      final sm = values['sisiMiring']!;
      if (a <= 0) errors['alas'] = 'Alas harus lebih dari 0';
      if (t <= 0) errors['tinggi'] = 'Tinggi harus lebih dari 0';
      if (sm <= 0) errors['sisiMiring'] = 'Sisi miring harus lebih dari 0';
      if (errors.isEmpty) {
        hasil.add((
          nama: 'Luas',
          formula: 'Luas = a × t = ${formatAngka(a)} × ${formatAngka(t)}',
          value: formatAngka(luasJajarGenjang(a, t)),
          satuan: satuanLuas,
        ));
        hasil.add((
          nama: 'Keliling',
          formula: 'Keliling = 2 × (a + b) = 2 × (${formatAngka(a)} + ${formatAngka(sm)})',
          value: formatAngka(kelilingJajarGenjang(a, sm)),
          satuan: satuanKeliling,
        ));
      }
      break;
    case 'belah_ketupat':
      final d1 = values['diagonal1']!;
      final d2 = values['diagonal2']!;
      final s = values['sisi']!;
      if (d1 <= 0) errors['diagonal1'] = 'Diagonal 1 harus lebih dari 0';
      if (d2 <= 0) errors['diagonal2'] = 'Diagonal 2 harus lebih dari 0';
      if (s <= 0) errors['sisi'] = 'Sisi harus lebih dari 0';
      if (errors.isEmpty) {
        hasil.add((
          nama: 'Luas',
          formula: 'Luas = ½ × d1 × d2 = ½ × ${formatAngka(d1)} × ${formatAngka(d2)}',
          value: formatAngka(luasBelahKetupat(d1, d2)),
          satuan: satuanLuas,
        ));
        hasil.add((
          nama: 'Keliling',
          formula: 'Keliling = 4 × sisi = 4 × ${formatAngka(s)}',
          value: formatAngka(kelilingBelahKetupat(s)),
          satuan: satuanKeliling,
        ));
      }
      break;
    case 'layang_layang':
      final d1 = values['diagonal1']!;
      final d2 = values['diagonal2']!;
      final sp = values['sisiPendek']!;
      final spj = values['sisiPanjang']!;
      if (d1 <= 0) errors['diagonal1'] = 'Diagonal 1 harus lebih dari 0';
      if (d2 <= 0) errors['diagonal2'] = 'Diagonal 2 harus lebih dari 0';
      if (sp <= 0) errors['sisiPendek'] = 'Sisi pendek harus lebih dari 0';
      if (spj <= 0) errors['sisiPanjang'] = 'Sisi panjang harus lebih dari 0';
      if (errors.isEmpty) {
        hasil.add((
          nama: 'Luas',
          formula: 'Luas = ½ × d1 × d2 = ½ × ${formatAngka(d1)} × ${formatAngka(d2)}',
          value: formatAngka(luasLayangLayang(d1, d2)),
          satuan: satuanLuas,
        ));
        hasil.add((
          nama: 'Keliling',
          formula: 'Keliling = 2 × (a + b) = 2 × (${formatAngka(sp)} + ${formatAngka(spj)})',
          value: formatAngka(kelilingLayangLayang(sp, spj)),
          satuan: satuanKeliling,
        ));
      }
      break;
    case 'hexagon':
      final s = values['sisi']!;
      if (s <= 0) errors['sisi'] = 'Sisi harus lebih dari 0';
      if (errors.isEmpty) {
        hasil.add((
          nama: 'Luas',
          formula: 'Luas = (3√3 ÷ 2) × s² = (3√3 ÷ 2) × ${formatAngka(s)}²',
          value: formatAngka(luasHexagon(s)),
          satuan: satuanLuas,
        ));
        hasil.add((
          nama: 'Keliling',
          formula: 'Keliling = 6 × sisi = 6 × ${formatAngka(s)}',
          value: formatAngka(kelilingHexagon(s)),
          satuan: satuanKeliling,
        ));
      }
      break;
    case 'pentagon':
      final s = values['sisi']!;
      if (s <= 0) errors['sisi'] = 'Sisi harus lebih dari 0';
      if (errors.isEmpty) {
        hasil.add((
          nama: 'Luas',
          formula: 'Luas = ¼ × √(5(5+2√5)) × s² ≈ 1,72 × ${formatAngka(s)}²',
          value: formatAngka(luasPentagon(s)),
          satuan: satuanLuas,
        ));
        hasil.add((
          nama: 'Keliling',
          formula: 'Keliling = 5 × sisi = 5 × ${formatAngka(s)}',
          value: formatAngka(kelilingPentagon(s)),
          satuan: satuanKeliling,
        ));
      }
      break;
    case 'kubus':
      final s = values['sisi']!;
      if (s <= 0) errors['sisi'] = 'Rusuk harus lebih dari 0';
      if (errors.isEmpty) {
        hasil.add((
          nama: 'Volume',
          formula: 'Volume = s³ = ${formatAngka(s)}³',
          value: formatAngka(volumeKubus(s)),
          satuan: satuanVolume,
        ));
        hasil.add((
          nama: 'Luas Permukaan',
          formula: 'Luas = 6 × s² = 6 × ${formatAngka(s)}²',
          value: formatAngka(luasPermukaanKubus(s)),
          satuan: satuanLuas,
        ));
      }
      break;
    case 'balok':
      final p = values['panjang']!;
      final l = values['lebar']!;
      final t = values['tinggi']!;
      if (p <= 0) errors['panjang'] = 'Panjang harus lebih dari 0';
      if (l <= 0) errors['lebar'] = 'Lebar harus lebih dari 0';
      if (t <= 0) errors['tinggi'] = 'Tinggi harus lebih dari 0';
      if (errors.isEmpty) {
        hasil.add((
          nama: 'Volume',
          formula: 'Volume = p × l × t = ${formatAngka(p)} × ${formatAngka(l)} × ${formatAngka(t)}',
          value: formatAngka(volumeBalok(p, l, t)),
          satuan: satuanVolume,
        ));
        hasil.add((
          nama: 'Luas Permukaan',
          formula:
              'Luas = 2 × (pl + pt + lt) = 2 × (${formatAngka(p * l)} + ${formatAngka(p * t)} + ${formatAngka(l * t)})',
          value: formatAngka(luasPermukaanBalok(p, l, t)),
          satuan: satuanLuas,
        ));
      }
      break;
    case 'tabung':
      final r = values['jariJari']!;
      final t = values['tinggi']!;
      if (r <= 0) errors['jariJari'] = 'Jari-jari harus lebih dari 0';
      if (t <= 0) errors['tinggi'] = 'Tinggi harus lebih dari 0';
      if (errors.isEmpty) {
        hasil.add((
          nama: 'Volume',
          formula: 'Volume = π × r² × t = π × ${formatAngka(r)}² × ${formatAngka(t)}',
          value: formatAngka(volumeTabung(r, t)),
          satuan: satuanVolume,
        ));
        hasil.add((
          nama: 'Luas Permukaan',
          formula: 'Luas = 2πr(r + t) = 2 × π × ${formatAngka(r)} × (${formatAngka(r)} + ${formatAngka(t)})',
          value: formatAngka(luasPermukaanTabung(r, t)),
          satuan: satuanLuas,
        ));
      }
      break;
    case 'kerucut':
      final r = values['jariJari']!;
      final t = values['tinggi']!;
      if (r <= 0) errors['jariJari'] = 'Jari-jari harus lebih dari 0';
      if (t <= 0) errors['tinggi'] = 'Tinggi harus lebih dari 0';
      if (errors.isEmpty) {
        final s = garisPelukisKerucut(r, t);
        hasil.add((
          nama: 'Garis Pelukis',
          formula: 's = √(r² + t²) = √(${formatAngka(r * r)} + ${formatAngka(t * t)})',
          value: formatAngka(s),
          satuan: 'satuan',
        ));
        hasil.add((
          nama: 'Volume',
          formula: 'Volume = ⅓ × π × r² × t = ⅓ × π × ${formatAngka(r)}² × ${formatAngka(t)}',
          value: formatAngka(volumeKerucut(r, t)),
          satuan: satuanVolume,
        ));
        hasil.add((
          nama: 'Luas Permukaan',
          formula: 'Luas = π × r × (r + s) = π × ${formatAngka(r)} × (${formatAngka(r)} + ${formatAngka(s)})',
          value: formatAngka(luasPermukaanKerucut(r, t)),
          satuan: satuanLuas,
        ));
      }
      break;
    case 'bola':
      final r = values['jariJari']!;
      if (r <= 0) errors['jariJari'] = 'Jari-jari harus lebih dari 0';
      if (errors.isEmpty) {
        hasil.add((
          nama: 'Volume',
          formula: 'Volume = 4/3 × π × r³ = 4/3 × π × ${formatAngka(r)}³',
          value: formatAngka(volumeBola(r)),
          satuan: satuanVolume,
        ));
        hasil.add((
          nama: 'Luas Permukaan',
          formula: 'Luas = 4 × π × r² = 4 × π × ${formatAngka(r)}²',
          value: formatAngka(luasPermukaanBola(r)),
          satuan: satuanLuas,
        ));
      }
      break;
    case 'prisma_segitiga':
      final a = values['alasSegitiga']!;
      final tSeg = values['tinggiSegitiga']!;
      final tP = values['tPrisma']!;
      final sm1 = values['sisiMiring1'];
      final sm2 = values['sisiMiring2'];
      if (a <= 0) errors['alasSegitiga'] = 'Alas segitiga harus lebih dari 0';
      if (tSeg <= 0) errors['tinggiSegitiga'] = 'Tinggi segitiga harus lebih dari 0';
      if (tP <= 0) errors['tPrisma'] = 'Tinggi prisma harus lebih dari 0';
      if (sm1 != null && sm1 <= 0) errors['sisiMiring1'] = 'Sisi miring harus lebih dari 0';
      if (sm2 != null && sm2 <= 0) errors['sisiMiring2'] = 'Sisi miring harus lebih dari 0';
      if (errors.isEmpty) {
        hasil.add((
          nama: 'Volume',
          formula:
              'Volume = (½ × a × t) × h = (½ × ${formatAngka(a)} × ${formatAngka(tSeg)}) × ${formatAngka(tP)}',
          value: formatAngka(volumePrismaSegitiga(a, tSeg, tP)),
          satuan: satuanVolume,
        ));
        hasil.add((
          nama: 'Luas Permukaan',
          formula:
              'Luas = 2 × luas alas + keliling × h = 2 × ${formatAngka(0.5 * a * tSeg)} + (${formatAngka(sm1 ?? a)} + ${formatAngka(sm2 ?? a)} + ${formatAngka(a)}) × ${formatAngka(tP)}',
          value: formatAngka(luasPermukaanPrismaSegitiga(a, tSeg, tP,
              sisiMiring1: sm1, sisiMiring2: sm2)),
          satuan: satuanLuas,
        ));
      }
      break;
    case 'limas_segiempat':
      final p = values['panjang']!;
      final l = values['lebar']!;
      final t = values['tinggi']!;
      if (p <= 0) errors['panjang'] = 'Panjang alas harus lebih dari 0';
      if (l <= 0) errors['lebar'] = 'Lebar alas harus lebih dari 0';
      if (t <= 0) errors['tinggi'] = 'Tinggi limas harus lebih dari 0';
      if (errors.isEmpty) {
        hasil.add((
          nama: 'Volume',
          formula:
              'Volume = ⅓ × (p × l) × t = ⅓ × (${formatAngka(p)} × ${formatAngka(l)}) × ${formatAngka(t)}',
          value: formatAngka(volumeLimasSegiempat(p, l, t)),
          satuan: satuanVolume,
        ));
        hasil.add((
          nama: 'Luas Permukaan',
          formula:
              'Luas = luas alas + 4 sisi tegak = ${formatAngka(p * l)} + (2×½×${formatAngka(p)}×apotema + 2×½×${formatAngka(l)}×apotema)',
          value: formatAngka(luasPermukaanLimasSegiempat(p, l, t)),
          satuan: satuanLuas,
        ));
      }
      break;
    case 'limas_segitiga':
      final a = values['sisiA']!;
      final b = values['sisiB']!;
      final c = values['sisiC']!;
      final t = values['tinggi']!;
      if (a <= 0) errors['sisiA'] = 'Sisi harus lebih dari 0';
      if (b <= 0) errors['sisiB'] = 'Sisi harus lebih dari 0';
      if (c <= 0) errors['sisiC'] = 'Sisi harus lebih dari 0';
      if (t <= 0) errors['tinggi'] = 'Tinggi limas harus lebih dari 0';
      if (a + b <= c || a + c <= b || b + c <= a) {
        errors['sisiC'] = 'Sisi alas tidak dapat membentuk segitiga';
      }
      if (errors.isEmpty) {
        final sHeron = (a + b + c) / 2;
        hasil.add((
          nama: 'Volume',
          formula:
              'Volume = ⅓ × luas alas(Heron) × t = ⅓ × ${formatAngka(math.sqrt(sHeron * (sHeron - a) * (sHeron - b) * (sHeron - c)))} × ${formatAngka(t)}',
          value: formatAngka(volumeLimasSegitiga(a, b, c, t)),
          satuan: satuanVolume,
        ));
        hasil.add((
          nama: 'Luas Permukaan',
          formula: 'Luas = luas alas + ½ × keliling × apotema',
          value: formatAngka(luasPermukaanLimasSegitiga(a, b, c, t)),
          satuan: satuanLuas,
        ));
      }
      break;
    case 'hemisphere':
      final r = values['jariJari']!;
      if (r <= 0) errors['jariJari'] = 'Jari-jari harus lebih dari 0';
      if (errors.isEmpty) {
        hasil.add((
          nama: 'Volume',
          formula: 'Volume = ⅔ × π × r³ = ⅔ × π × ${formatAngka(r)}³',
          value: formatAngka(volumeHemisphere(r)),
          satuan: satuanVolume,
        ));
        hasil.add((
          nama: 'Luas Permukaan',
          formula: 'Luas = 3 × π × r² = 3 × π × ${formatAngka(r)}²',
          value: formatAngka(luasPermukaanHemisphere(r)),
          satuan: satuanLuas,
        ));
      }
      break;
  }
  return _CalcResult(hasil: hasil, errors: errors);
}

/// Layar kalkulator untuk satu bangun.
class CalculatorScreen extends StatefulWidget {
  final Shape shape;

  const CalculatorScreen({super.key, required this.shape});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, String> _errors = {};
  late _CalcResult _result;

  @override
  void initState() {
    super.initState();
    for (final input in widget.shape.inputs) {
      final controller = TextEditingController();
      _controllers[input.id] = controller;
      // Auto-hitung realtime: hitung ulang setiap perubahan input.
      controller.addListener(_recalculate);
    }
    _result = _emptyResult();
  }

  _CalcResult _emptyResult() => _CalcResult(hasil: const [], errors: const {});

  void _recalculate() {
    final values = <String, double>{};
    final newErrors = <String, String>{};
    for (final input in widget.shape.inputs) {
      final text = _controllers[input.id]!.text.trim();
      if (text.isEmpty) {
        newErrors[input.id] = 'Isi ${input.label.toLowerCase()} terlebih dahulu';
      } else {
        final v = double.tryParse(text);
        if (v == null) {
          newErrors[input.id] = 'Masukkan angka yang valid';
        } else if (v < 0) {
          newErrors[input.id] = 'Nilai tidak boleh negatif';
        } else {
          values[input.id] = v;
        }
      }
    }
    setState(() {
      _errors.clear();
      _errors.addAll(newErrors);
      if (values.length == widget.shape.inputs.length) {
        _result = calculate(widget.shape.id, values);
        _errors.addAll(_result.errors);
      } else {
        _result = _emptyResult();
      }
    });
  }

  void _reset() {
    for (final c in _controllers.values) {
      c.clear();
    }
    setState(() {
      _errors.clear();
      _result = _emptyResult();
    });
  }

  /// Catat ke riwayat saat hasil berhasil dihitung.
  void _saveHistory() {
    final shape = widget.shape;
    final textPrimary =
        Theme.of(context).brightness == Brightness.dark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final resultText = _result.hasil
        .map((h) => '${h.nama}: ${h.value} ${h.satuan}')
        .join(' | ');
    final inputText = shape.inputs
        .map((i) => '${i.label}: ${_controllers[i.id]!.text.trim()}')
        .join(', ');
    final history = context.read<HistoryProvider>();
    history.add(HistoryEntry(
      shapeName: shape.nama,
      formulaUsed: shape.formulas.map((f) => f.rumusTeks).join(' ; '),
      inputText: inputText,
      resultText: resultText,
      timestamp: DateTime.now(),
    ));
    // Feedback singkat ke user.
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: const Text('Perhitungan disimpan ke riwayat',
            style: TextStyle(fontFamily: 'Poppins', color: Colors.white)),
        backgroundColor: AppColors.lavenderDark,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ));
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textPrimary =
        Theme.of(context).brightness == Brightness.dark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator ${widget.shape.nama}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          // Input form
          Text('Masukkan Nilai',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18)),
          const SizedBox(height: 12),
          ...widget.shape.inputs.map((input) {
            final isOptional = input.label.toLowerCase().contains('opsional');
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TextField(
                controller: _controllers[input.id],
                style: TextStyle(color: textPrimary, fontFamily: 'Poppins', fontSize: 15),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,6}')),
                ],
                decoration: InputDecoration(
                  labelText: input.label,
                  hintText: input.placeholder,
                  errorText: _errors[input.id],
                  labelStyle: const TextStyle(fontFamily: 'Poppins', color: AppColors.textSecondary),
                  hintStyle: const TextStyle(fontFamily: 'Poppins', color: AppColors.textSecondary),
                ),
              ),
            );
          }),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _reset,
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Reset'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.peachDark.withOpacity(0.85),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _result.hasil.isEmpty ? null : _saveHistory,
                  icon: const Icon(Icons.bookmark_add_outlined),
                  label: const Text('Simpan ke Riwayat'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Hasil
          Text('Hasil Perhitungan',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18)),
          const SizedBox(height: 12),
          if (_result.hasil.isEmpty && _errors.isNotEmpty)
            Card(
              color: AppColors.errorColor.withOpacity(0.12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline_rounded, color: AppColors.errorColor),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _errors.values.first,
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: AppColors.errorColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else if (_result.hasil.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Center(
                  child: Text('Isi semua input untuk melihat hasil otomatis.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AppColors.textSecondary,
                          fontSize: 14)),
                ),
              ),
            )
          else
            ..._result.hasil.map((h) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                color: widget.shape.warna.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.check_circle_outline_rounded,
                                  color: widget.shape.warna, size: 18),
                            ),
                            const SizedBox(width: 10),
                            Text(h.nama,
                                style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600)),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: widget.shape.warna.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text('${h.value} ${h.satuan}',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: widget.shape.warna)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.background.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(h.formula,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  color: AppColors.textSecondary)),
                        ),
                      ],
                    ),
                  ),
                )),
        ],
      ),
    );
  }
}
