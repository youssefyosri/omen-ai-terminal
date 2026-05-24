import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/storage/history_provider.dart';
import '../../../shared/widgets/language_selector.dart';
import '../domain/ai_provider.dart';
import '../../../l10n/app_localizations.dart';

class PromptScreen extends ConsumerStatefulWidget {
  const PromptScreen({super.key});

  @override
  ConsumerState<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends ConsumerState<PromptScreen> {
  final TextEditingController _promptController = TextEditingController();

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final aiState = ref.watch(aiProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.terminalTitle),
        actions: [
          const LanguageSelector(),
          IconButton(
            icon: const Icon(Icons.folder_special_outlined),
            tooltip: l10n.viewArchive,
            onPressed: () => context.push('/history'),
          ),
          SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: TextField(
                  controller: _promptController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                  decoration: InputDecoration(
                    hintText: l10n.awaitingDirective,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Dynamic Button[cite: 5]
              SizedBox(
                height: 64,
                child: ElevatedButton(
                  onPressed: aiState.isLoading ? null : () async {
                    final text = _promptController.text.trim();
                    if (text.isEmpty) return;

                    FocusScope.of(context).unfocus();

                    await ref.read(aiProvider.notifier).sendDirective(text);

                    if (context.mounted) {
                      final currentState = ref.read(aiProvider);

                      currentState.when(
                        data: (result) {
                          if (result != null) {
                            ref.read(historyProvider.notifier).saveRecord(text, result);
                            context.push('/result', extra: result);
                            _promptController.clear();
                          }
                        },
                        error: (err, stack) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(err.toString())),
                          );
                        },
                        loading: () {},
                      );
                    }
                  },
                  child: aiState.isLoading
                      ? const CircularProgressIndicator(color: Colors.black)
                      : Text(l10n.generate),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}