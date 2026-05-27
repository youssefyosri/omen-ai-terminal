import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  late final GenerativeModel _model;

  GeminiService() {
    final apiKey = dotenv.env["GEMINI_API_KEY"] ?? "KEY_NOT_FOUND";

    _model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: apiKey,
      systemInstruction: Content.system("You are OMEN, a highly analytical, brutalist AI assistant. Keep responses concise, formatting them clearly in markdown. Do not use friendly pleasantries and answer in the same language as the question."),
    );
  }

  Stream<String> generateTextStream(String prompt) async* {
    try {
      final stream = _model.generateContentStream([Content.text(prompt)]);

      await for (final chunk in stream) {
        if (chunk.text != null) {
          yield chunk.text!;
        }
      }
    } catch (e) {
      throw Exception('SYSTEM ERROR: $e');
    }
  }
}

final geminiServiceProvider = Provider((ref) => GeminiService());