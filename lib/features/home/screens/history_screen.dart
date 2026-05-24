import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/storage/history_provider.dart';
import '../../../shared/widgets/language_selector.dart';
import '../../../l10n/app_localizations.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(historyProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.archiveTitle),
        actions: [
          const LanguageSelector(),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.grey),
            tooltip: l10n.purgeArchive,
            onPressed: () {
              ref.read(historyProvider.notifier).clearHistory();
            },
          ),
        ],
      ),
      body: history.isEmpty
          ? Center(
        child: Text(
          l10n.archiveEmpty,
          style: const TextStyle(color: Colors.grey, letterSpacing: 2.0),
        ),
      )
          : ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: history.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final record = history[index];

          return InkWell(
            onTap: () {
              context.push('/result', extra: record['response']);
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.directivePrefix,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontFamily: 'monospace',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    record['prompt'] ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}