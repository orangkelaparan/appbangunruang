/// Halaman Detail per Bangun: ilustrasi CustomPainter, daftar rumus, dan
/// tombol menuju kalkulator. Animasi transisi halus dari home screen.
library;

import 'package:flutter/material.dart';
import 'package:app_bangunruang/models/shape.dart';
import 'package:app_bangunruang/theme/app_theme.dart';
import 'package:app_bangunruang/widgets/shape_painter.dart';
import 'calculator_screen.dart';

class DetailScreen extends StatelessWidget {
  final Shape shape;

  const DetailScreen({super.key, required this.shape});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shape.nama),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          // Ilustrasi bentuk geometris
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: shape.warna.withOpacity(0.14),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(20),
            child: ShapePainter(shape: painterShapeFor(shape.id), color: shape.warna),
          ),
          const SizedBox(height: 20),
          // Deskripsi
          Text(shape.deskripsi,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6)),
          const SizedBox(height: 20),
          // Daftar rumus
          Text('Rumus',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18)),
          const SizedBox(height: 12),
          ...shape.formulas.map((f) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Card(
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
                                color: shape.warna.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.calculate_rounded, color: shape.warna, size: 18),
                            ),
                            const SizedBox(width: 10),
                            Text(f.nama,
                                style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.background.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(f.rumusTeks,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: shape.warna,
                              )),
                        ),
                        const SizedBox(height: 8),
                        Text(f.penjelasan,
                            style: const TextStyle(
                                fontFamily: 'Poppins', color: AppColors.textSecondary, fontSize: 13)),
                      ],
                    ),
                  ),
                ),
              )),
          const SizedBox(height: 8),
          // Tombol ke kalkulator
          ElevatedButton.icon(
            onPressed: () => Navigator.of(context).push(PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 280),
              pageBuilder: (_, __, ___) => CalculatorScreen(shape: shape),
              transitionsBuilder: (_, animation, __, child) {
                return SlideTransition(
                  position: Tween<Offset>(begin: const Offset(0.05, 0), end: Offset.zero)
                      .chain(CurveTween(curve: Curves.easeOutCubic))
                      .animate(animation),
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
            )),
            icon: const Icon(Icons.calculate_outlined),
            label: const Text('Hitung dengan Kalkulator'),
          ),
        ],
      ),
    );
  }
}
