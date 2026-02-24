import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

Widget createTestableWidget({
  required Widget child,
  List<Override> overrides = const [],
}) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      home: child,
      localizationsDelegates: const [],
      supportedLocales: const [Locale('en')],
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
