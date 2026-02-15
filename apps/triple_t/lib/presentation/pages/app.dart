import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:triple_t/domain/use_case/settings/get_locale_use_case.dart';
import 'package:triple_t/domain/use_case/settings/get_theme_mode_use_case.dart';
import 'package:triple_t/presentation/router/router_provider.dart';
import 'package:triple_t_i18n/l10n/generated/app_localizations.g.dart';

class TripleTApp extends ConsumerWidget {
  const TripleTApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(getThemeModeUseCaseProvider);
    final locale = ref.watch(getLocaleUseCaseProvider);

    return MaterialApp.router(
      title: 'Triple T',
      locale: locale,
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4)),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4), brightness: Brightness.dark),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
