import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/ai_provider.dart';

class ResultScreen extends ConsumerWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    final aiState = ref.watch(aiProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.outputTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: aiState.when(
            data: (output) => MarkdownBody(
              data: output ?? '',
              selectable: true,
              styleSheet: MarkdownStyleSheet(
                p: const TextStyle(fontSize: 16, height: 1.6, fontFamily: 'monospace'),
                h1: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
                h2: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
                h3: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
                strong: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace'),
                listBullet: const TextStyle(fontFamily: 'monospace'),
              ),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
            error: (err, stack) => Text(
              'SYSTEM ERROR: $err',
              style: const TextStyle(color: Colors.redAccent, fontFamily: 'monospace'),
            ),
          ),
        ),
      ),
    );
  }
}