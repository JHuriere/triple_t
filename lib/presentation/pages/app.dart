import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:triple_t/domain/use_case/settings/get_theme_mode_use_case.dart';
import 'package:triple_t/presentation/router/router_provider.dart';

class TripleTApp extends ConsumerWidget {
  const TripleTApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(getThemeModeUseCaseProvider);

    return MaterialApp.router(
      title: 'Triple T',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
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
