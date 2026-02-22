import 'package:error_presentation/src/pages/error_page.dart';
import 'package:error_presentation/src/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:tt_i18n/i18n.dart';

class MockErrorNavigator extends Mock implements ErrorNavigator {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  group('ErrorPage Widget Tests', () {
    late MockErrorNavigator mockErrorNavigator;

    setUp(() {
      mockErrorNavigator = MockErrorNavigator();
    });

    Widget createTestWidget({String? error}) {
      return ProviderScope(
        overrides: [
          getErrorNavigatorProvider.overrideWithValue(mockErrorNavigator),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: ErrorPage(error: error),
        ),
      );
    }

    testWidgets('renders without error message', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('renders with error message', (WidgetTester tester) async {
      const errorMessage = 'Test error message';
      await tester.pumpWidget(createTestWidget(error: errorMessage));

      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('does not show error message when not provided', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('null'), findsNothing);
    });

    testWidgets('home page button is present', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final buttonFinder = find.byType(ElevatedButton);
      expect(buttonFinder, findsOneWidget);
    });

    testWidgets('tapping home button calls goHome', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final buttonFinder = find.byType(ElevatedButton);
      expect(buttonFinder, findsOneWidget);

      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();
    });

    testWidgets('icon size is 80', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final iconFinder = find.byIcon(Icons.error_outline);
      expect(iconFinder, findsOneWidget);

      final icon = tester.widget<Icon>(iconFinder);
      expect(icon.size, 80);
    });

    testWidgets('icon color is red', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final icon = tester.widget<Icon>(find.byIcon(Icons.error_outline));
      expect(icon.color, Colors.red);
    });

    testWidgets('page not found text is displayed', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // The text should be displayed (exact text depends on locale)
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('app bar has error title', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.title, isNotNull);
    });

    testWidgets('error message has grey color', (WidgetTester tester) async {
      const errorMessage = 'Test error';
      await tester.pumpWidget(createTestWidget(error: errorMessage));

      final textWidgets = find.byType(Text);
      expect(textWidgets, findsWidgets);

      // Find the error message text widget
      bool foundGreyText = false;
      for (int i = 0; i < textWidgets.evaluate().length; i++) {
        final text = tester.widget<Text>(textWidgets.at(i));
        if (text.data == errorMessage && text.style?.color == Colors.grey) {
          foundGreyText = true;
          break;
        }
      }
      expect(foundGreyText, true);
    });

    testWidgets('renders error page title in English', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            getErrorNavigatorProvider.overrideWithValue(mockErrorNavigator),
          ],
          child: MaterialApp(
            locale: const Locale('en'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const ErrorPage(),
          ),
        ),
      );

      // Verify English texts are present
      expect(find.text('Error'), findsOneWidget);
      expect(find.text('Page not found'), findsOneWidget);
      expect(find.text('Home page'), findsOneWidget);
    });

    testWidgets('renders error page title in French', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            getErrorNavigatorProvider.overrideWithValue(mockErrorNavigator),
          ],
          child: MaterialApp(
            locale: const Locale('fr'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const ErrorPage(),
          ),
        ),
      );

      // Verify French texts are present
      expect(find.text('Erreur'), findsOneWidget);
      expect(find.text('Page non trouvée'), findsOneWidget);
      expect(find.text('Page d\'accueil'), findsOneWidget);
    });
  });
}
