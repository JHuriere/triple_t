import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Crée un MaterialApp testé avec ProviderContainer pour les tests widget
Widget createTestableWidget({
  required Widget child,
  required List<Override> overrides,
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

/// Estension pour tester les états de widget plus facilement
extension WidgetTesterExtension on WidgetTester {
  /// Trouve et tape sur un widget avec le texte fourni
  Future<void> tapText(String text) async {
    await tap(find.text(text));
    await pumpAndSettle();
  }

  /// Vérifie qu'un widget avec le texte fourni existe
  void expectTextExists(String text) {
    expect(find.text(text), findsOneWidget);
  }

  /// Vérifie qu'un widget avec le texte fourni n'existe pas
  void expectTextNotExists(String text) {
    expect(find.text(text), findsNothing);
  }

  /// Trouve et remplit un champ de saisie
  Future<void> fillInputField(String inputKey, String value) async {
    await enterText(find.byKey(Key(inputKey)), value);
    await pumpAndSettle();
  }
}
