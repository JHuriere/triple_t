import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:triple_t/domain/use_case/settings/get_settings_use_case.dart';
import 'package:triple_t/domain/use_case/settings/get_theme_mode_use_case.dart';
import 'package:triple_t/domain/use_case/settings/update_theme_mode_use_case.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(getSettingsUseCaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Langue'),
            subtitle: const Text('Français'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),

          const Divider(),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('Thème'),
            subtitle: Text(_getThemeModeLabel(settings.themeMode)),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => _showThemeDialog(context, ref, settings.themeMode),
          ),
        ],
      ),
    );
  }

  String _getThemeModeLabel(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }

  void _showThemeDialog(BuildContext context, WidgetRef ref, ThemeMode currentMode) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select a theme'),
        content: RadioGroup<ThemeMode>(
          onChanged: (value) async {
            if (value != null) {
              await ref.read(updateThemeModeUseCaseProvider(themeMode: value).future);
              ref.invalidate(getSettingsUseCaseProvider);
              if (context.mounted) {
                Navigator.pop(context);
              }
            }
          },
          groupValue: ref.watch(getThemeModeUseCaseProvider),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<ThemeMode>(
                title: const Text('Light'),
                value: ThemeMode.light,
              ),
              RadioListTile<ThemeMode>(
                title: const Text('Dark'),
                value: ThemeMode.dark,
              ),
              RadioListTile<ThemeMode>(
                title: const Text('System'),
                value: ThemeMode.system,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
