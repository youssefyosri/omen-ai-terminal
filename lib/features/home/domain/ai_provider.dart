import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/gemini_service.dart';

class AiController extends Notifier<AsyncValue<String?>> {
  @override
  AsyncValue<String?> build() {
    return const AsyncData(null);
  }

  Future<void> sendDirective(String prompt) async {
    state = const AsyncLoading();

    try {
      final service = ref.read(geminiServiceProvider);
      final response = await service.generateText(prompt);
      state = AsyncData(response);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}

final aiProvider = NotifierProvider<AiController, AsyncValue<String?>>(AiController.new);