import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/locale_provider.dart';

class LanguageSelector extends ConsumerWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);

    return PopupMenuButton<String>(
      icon: const Icon(Icons.language),
      tooltip: 'Change Language',
      onSelected: (String languageCode) {
        ref.read(localeProvider.notifier).setLocale(languageCode);
      },
      itemBuilder: (BuildContext context) {
        return supportedLanguages.map((lang) {
          final isSelected = currentLocale.languageCode == lang['code'];
          return PopupMenuItem<String>(
            value: lang['code'] as String,
            child: Row(
              children: [
                Text(
                  lang['name'] as String,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Theme.of(context).colorScheme.primary : null,
                  ),
                ),
                if (isSelected) ...[
                  const Spacer(),
                  Icon(Icons.check, size: 18, color: Theme.of(context).colorScheme.primary),
                ]
              ],
            ),
          );
        }).toList();
      },
    );
  }
}