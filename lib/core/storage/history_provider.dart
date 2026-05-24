import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'shared_prefs_provider.dart';

class HistoryNotifier extends Notifier<List<Map<String, String>>> {
  static const _historyKey = 'omen_history';

  @override
  List<Map<String, String>> build() {
    final prefs = ref.watch(sharedPrefsProvider);
    final historyJson = prefs.getString(_historyKey);

    if (historyJson != null) {
      final List<dynamic> decoded = jsonDecode(historyJson);
      return decoded.map((e) => Map<String, String>.from(e)).toList();
    }
    return [];
  }

  Future<void> saveRecord(String prompt, String response) async {
    final prefs = ref.read(sharedPrefsProvider);

    final newRecord = {
      'prompt': prompt,
      'response': response,
      'timestamp': DateTime.now().toIso8601String(),
    };

    final updatedList = [newRecord, ...state];

    await prefs.setString(_historyKey, jsonEncode(updatedList));

    state = updatedList;
  }

  Future<void> clearHistory() async {
    final prefs = ref.read(sharedPrefsProvider);
    await prefs.remove(_historyKey);
    state = [];
  }
}

final historyProvider = NotifierProvider<HistoryNotifier, List<Map<String, String>>>(HistoryNotifier.new);