import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/gemini_service.dart';
import '../../../core/storage/history_provider.dart';

class AiController extends Notifier<AsyncValue<String?>> {
  bool _isGenerating = false;

  @override
  AsyncValue<String?> build() {
    return const AsyncData(null);
  }

  Future<void> sendDirective(String prompt) async {
    if (_isGenerating) return;

    _isGenerating = true;

    state = const AsyncData("");
    String accumulatedText = "";

    try {
      final service = ref.read(geminiServiceProvider);
      final stream = service.generateTextStream(prompt);

      await for (final chunk in stream) {
        for (int i = 0; i < chunk.length; i++) {
          accumulatedText += chunk[i];

          state = AsyncData(accumulatedText);

          await Future.delayed(const Duration(milliseconds: 5));
        }
      }

      ref.read(historyProvider.notifier).saveRecord(prompt, accumulatedText);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    } finally {
      _isGenerating = false;
    }
  }
}

final aiProvider = NotifierProvider<AiController, AsyncValue<String?>>(AiController.new);