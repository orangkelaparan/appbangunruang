/// Halaman Home: grid kategori "Bangun Datar" & "Bangun Ruang" dengan card
/// modern, search bar untuk mencari nama bangun, dan riwayat perhitungan.
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_bangunruang/models/shape.dart';
import 'package:app_bangunruang/theme/app_theme.dart';
import 'package:app_bangunruang/widgets/shape_painter.dart';
import 'package:app_bangunruang/widgets/history_provider.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  List<Shape> _filtered(ShapeCategory kategori) {
    final source = kategori == ShapeCategory.datar ? shapes2D : shapes3D;
    if (_query.isEmpty) return source;
    return source
        .where((s) => s.nama.toLowerCase().contains(_query.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textPrimary = isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rumus Bangun Ruang & Datar'),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
            child: TextField(
              controller: _searchController,
              style: TextStyle(color: textPrimary, fontFamily: 'Poppins'),
              decoration: InputDecoration(
                hintText: 'Cari bangun, misal "kubus"...',
                hintStyle: const TextStyle(fontFamily: 'Poppins', color: AppColors.textSecondary),
                prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textSecondary),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.close_rounded, color: AppColors.textSecondary),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                      ),
              ),
              onChanged: (value) => setState(() => _query = value.trim()),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              children: [
                _buildSection(context, 'Bangun Datar (2D)', ShapeCategory.datar,
                    palette: [AppColors.mint, AppColors.softBlue, AppColors.peach, AppColors.lavender]),
                const SizedBox(height: 24),
                _buildSection(context, 'Bangun Ruang (3D)', ShapeCategory.ruang,
                    palette: [AppColors.lavender, AppColors.peach, AppColors.mint, AppColors.softBlue]),
                const SizedBox(height: 8),
                _buildHistorySection(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, ShapeCategory kategori,
      {required List<Color> palette}) {
    final items = _filtered(kategori);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Row(
            children: [
              Icon(kategori == ShapeCategory.datar ? Icons.category_outlined : Icons.view_in_ar_outlined,
                  color: AppColors.mintDark, size: 22),
              const SizedBox(width: 8),
              Text(title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18)),
            ],
          ),
        ),
        items.isEmpty
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(child: Text('Tidak ada bangun yang cocok.',
                    style: TextStyle(fontFamily: 'Poppins', color: AppColors.textSecondary))),
              )
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 1.05,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final shape = items[index];
                  return _ShapeCard(
                    shape: shape,
                    bgColor: palette[index % palette.length],
                    onTap: () => _openDetail(context, shape),
                  );
                },
              ),
      ],
    );
  }

  void _openDetail(BuildContext context, Shape shape) {
    Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 280),
      pageBuilder: (_, __, ___) => DetailScreen(shape: shape),
      transitionsBuilder: (_, animation, __, child) {
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0.05, 0), end: Offset.zero)
              .chain(CurveTween(curve: Curves.easeOutCubic))
              .animate(animation),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    ));
  }

  /// Bagian riwayat perhitungan (opsional, dari shared_preferences).
  Widget _buildHistorySection(BuildContext context) {
    return Consumer<HistoryProvider>(
      builder: (context, history, _) {
        if (!history.isLoaded || history.entries.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 12, top: 12),
              child: Row(
                children: [
                  const Icon(Icons.history_rounded, color: AppColors.lavenderDark, size: 22),
                  const SizedBox(width: 8),
                  Text('Riwayat Perhitungan',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18)),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () => history.clear(),
                    icon: const Icon(Icons.delete_outline_rounded, size: 16),
                    label: const Text('Hapus'),
                  ),
                ],
              ),
            ),
            ...history.entries.take(5).map((entry) => Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    title: Text(entry.shapeName,
                        style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
                    subtitle: Text('${entry.formulaUsed}\n${entry.inputText}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontFamily: 'Poppins')),
                    trailing: Text(entry.resultText,
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: AppColors.mintDark,
                            fontWeight: FontWeight.w600)),
                  ),
                )),
          ],
        );
      },
    );
  }
}

/// Card bangun dengan ilustrasi CustomPainter.
class _ShapeCard extends StatelessWidget {
  final Shape shape;
  final Color bgColor;
  final VoidCallback onTap;

  const _ShapeCard({required this.shape, required this.bgColor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: bgColor.withOpacity(0.55),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: ShapePainter(shape: painterShapeFor(shape.id), color: shape.warna),
                ),
              ),
              const SizedBox(height: 10),
              Text(shape.nama,
                  style: const TextStyle(
                      fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}
