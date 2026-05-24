import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GeminiService {
  final Dio _dio;

  GeminiService() : _dio = Dio(BaseOptions(
    baseUrl: 'https://generativelanguage.googleapis.com/v1beta/models/',
    headers: {
      'Content-Type': 'application/json',
      'X-goog-api-key': dotenv.env["GEMINI_API_KEY"] ?? "KEY_NOT_FOUND",
    },
  ));

  Future<String> generateText(String prompt) async {
    try {
      final response = await _dio.post(
        'gemini-flash-latest:generateContent',
        data: {
          "contents": [
            {
              "parts": [
                {
                  "text": "You are OMEN, a highly analytical, brutalist AI assistant. Keep responses concise, formatting them clearly in markdown. Do not use friendly pleasantries and answer in the same language as the question. Answer the following: $prompt"
                }
              ]
            }
          ]
        },
      );

      final String generatedText = response.data['candidates'][0]['content']['parts'][0]['text'];
      return generatedText;

    } on DioException catch (e) {
      throw Exception('UPLINK FAILED: ${e.message}');
    } catch (e) {
      throw Exception('SYSTEM ERROR: $e');
    }
  }
}

final geminiServiceProvider = Provider((ref) => GeminiService());