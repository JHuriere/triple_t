import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tt_i18n/i18n.dart';

Widget createTestableWidget({
  required Widget child,
  List<Override> overrides = const [],
}) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      home: Material(child: child),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    ),
  );
}

extension WidgetTesterExtension on WidgetTester {
  Future<void> tapText(String text) async {
    await tap(find.text(text));
    await pumpAndSettle();
  }

  void expectTextExists(String text) {
    expect(find.text(text), findsOneWidget);
  }

  void expectTextNotExists(String text) {
    expect(find.text(text), findsNothing);
  }

  Future<void> fillInputField(String inputKey, String value) async {
    await enterText(find.byKey(Key(inputKey)), value);
    await pumpAndSettle();
  }
}
