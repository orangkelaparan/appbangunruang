/// Aplikasi "Rumus Bangun Ruang & Datar".
/// Entry point: tema pastel, Provider untuk riwayat perhitungan lokal,
/// dan halaman Home sebagai layar awal.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_bangunruang/theme/app_theme.dart';
import 'package:app_bangunruang/widgets/history_provider.dart';
import 'package:app_bangunruang/screens/home_screen.dart';

void main() {
  runApp(const AppBangunruang());
}

class AppBangunruang extends StatelessWidget {
  const AppBangunruang({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HistoryProvider()..load(),
      child: MaterialApp(
        title: 'Rumus Bangun Ruang & Datar',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        home: const HomeScreen(),
      ),
    );
  }
}
