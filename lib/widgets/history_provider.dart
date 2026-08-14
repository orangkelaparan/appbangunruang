/// Riwayat perhitungan — menyimpan history hitungan terakhir secara lokal
/// memakai `shared_preferences` (JSON-encoded).
library;

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Satu entri riwayat perhitungan.
class HistoryEntry {
  final String shapeName;
  final String formulaUsed;
  final String inputText;
  final String resultText;
  final DateTime timestamp;

  HistoryEntry({
    required this.shapeName,
    required this.formulaUsed,
    required this.inputText,
    required this.resultText,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'shapeName': shapeName,
        'formulaUsed': formulaUsed,
        'inputText': inputText,
        'resultText': resultText,
        'timestamp': timestamp.toIso8601String(),
      };

  factory HistoryEntry.fromJson(Map<String, dynamic> json) => HistoryEntry(
        shapeName: json['shapeName'] as String,
        formulaUsed: json['formulaUsed'] as String,
        inputText: json['inputText'] as String,
        resultText: json['resultText'] as String,
        timestamp: DateTime.parse(json['timestamp'] as String),
      );
}

/// Provider riwayat perhitungan (ChangeNotifier via Provider).
class HistoryProvider extends ChangeNotifier {
  static const String _key = 'history_entries_v1';
  final List<HistoryEntry> _entries = [];
  bool _loaded = false;

  List<HistoryEntry> get entries => List.unmodifiable(_entries);

  bool get isLoaded => _loaded;

  /// Muat riwayat dari shared_preferences (dipanggil sekali saat start).
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key) ?? [];
    _entries.clear();
    for (final item in raw.reversed) {
      try {
        _entries.add(HistoryEntry.fromJson(jsonDecode(item) as Map<String, dynamic>));
      } catch (_) {
        // Abaikan entri rusak.
      }
    }
    // Batasi 50 entri terakhir.
    if (_entries.length > 50) _entries.removeRange(0, _entries.length - 50);
    _loaded = true;
    notifyListeners();
  }

  /// Tambah entri perhitungan baru.
  Future<void> add(HistoryEntry entry) async {
    _entries.insert(0, entry);
    if (_entries.length > 50) _entries.removeLast();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _key,
      _entries.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }

  /// Kosongkan riwayat.
  Future<void> clear() async {
    _entries.clear();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
