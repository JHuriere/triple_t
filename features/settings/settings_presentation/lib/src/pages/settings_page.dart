import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_domain/settings_domain.dart';
import 'package:tt_i18n/i18n.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(getSettingsUseCaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(context.l10n.language),
            subtitle: Text(_getLocaleLabel(context, settings.locale)),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => _showLanguageDialog(context, ref, settings.locale),
          ),

          const Divider(),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: Text(context.l10n.theme),
            subtitle: Text(_getThemeModeLabel(context, settings.themeMode)),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => _showThemeDialog(context, ref, settings.themeMode),
          ),
        ],
      ),
    );
  }

  String _getThemeModeLabel(BuildContext context, ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return context.l10n.light;
      case ThemeMode.dark:
        return context.l10n.dark;
      case ThemeMode.system:
        return context.l10n.system;
    }
  }

  void _showThemeDialog(BuildContext context, WidgetRef ref, ThemeMode currentMode) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.selectATheme),
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
                title: Text(context.l10n.light),
                value: ThemeMode.light,
              ),
              RadioListTile<ThemeMode>(
                title: Text(context.l10n.dark),
                value: ThemeMode.dark,
              ),
              RadioListTile<ThemeMode>(
                title: Text(context.l10n.system),
                value: ThemeMode.system,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getLocaleLabel(BuildContext context, String localeCode) {
    switch (localeCode) {
      case 'en':
        return context.l10n.english;
      case 'fr':
      default:
        return context.l10n.french;
    }
  }

  void _showLanguageDialog(BuildContext context, WidgetRef ref, String currentLocale) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.chooseLanguage),
        content: RadioGroup<String>(
          onChanged: (value) async => _onChangeLanguage(value, ref, context),
          groupValue: currentLocale,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: Text(context.l10n.french),
                value: 'fr',
              ),
              RadioListTile<String>(
                title: Text(context.l10n.english),
                value: 'en',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onChangeLanguage(String? value, WidgetRef ref, BuildContext context) async {
    if (value != null) {
      await ref.read(updateLocaleUseCaseProvider(locale: value).future);
      ref.invalidate(getSettingsUseCaseProvider);
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }
}
