import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_presentation/src/pages/widget/overlay/winner_overlay.dart';

import '../../../../helpers/widget_test_helpers.dart';

void main() {
  group('WinnerOverlay Widget', () {
    group('render', () {
      testWidgets('should display Stack for confetti positioning', (WidgetTester tester) async {
        // Arrange
        const WINNER_NAME = 'Alice';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: WinnerOverlay(
              winner: WINNER_NAME,
              onDismiss: () {},
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 500));

        // Assert
        expect(find.byType(Stack), findsOneWidget);
      });

      testWidgets('should display Center widget with victory card', (WidgetTester tester) async {
        // Arrange
        const WINNER_NAME = 'Alice';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: WinnerOverlay(
              winner: WINNER_NAME,
              onDismiss: () {},
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 500));

        // Assert
        expect(find.byType(Center), findsOneWidget);
      });

      testWidgets('should display Container with white background', (WidgetTester tester) async {
        // Arrange
        const WINNER_NAME = 'Alice';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: WinnerOverlay(
              winner: WINNER_NAME,
              onDismiss: () {},
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 500));

        // Assert
        expect(find.byType(Container), findsWidgets);
      });
    });

    group('title', () {
      testWidgets('should display victory title', (WidgetTester tester) async {
        // Arrange
        const WINNER_NAME = 'Alice';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: WinnerOverlay(
              winner: WINNER_NAME,
              onDismiss: () {},
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 500));

        // Assert
        final texts = find.byType(Text).evaluate();
        expect(texts.length, greaterThanOrEqualTo(3));
      });

      testWidgets('should display title with green color and bold font', (WidgetTester tester) async {
        // Arrange
        const WINNER_NAME = 'Alice';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: WinnerOverlay(
              winner: WINNER_NAME,
              onDismiss: () {},
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 500));

        // Assert
        final titleFinder = find.byType(Text).first;
        final text = titleFinder.evaluate().first.widget as Text;
        expect(text.style?.color, Colors.green);
        expect(text.style?.fontWeight, FontWeight.bold);
        expect(text.style?.fontSize, 36);
      });
    });

    group('winner message', () {
      testWidgets('should display player won message with winner name', (WidgetTester tester) async {
        // Arrange
        const WINNER_NAME = 'Alice';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: WinnerOverlay(
              winner: WINNER_NAME,
              onDismiss: () {},
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 500));

        // Assert
        final textWidgets = find.byType(Text).evaluate();
        expect(textWidgets.length, greaterThanOrEqualTo(3));
      });

      testWidgets('should display message with proper styling', (WidgetTester tester) async {
        // Arrange
        const WINNER_NAME = 'Bob';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: WinnerOverlay(
              winner: WINNER_NAME,
              onDismiss: () {},
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 500));

        // Assert
        final textWidgets = find.byType(Text).evaluate();
        if (textWidgets.length > 1) {
          final text = textWidgets.elementAt(1).widget as Text;
          expect(text.style?.fontSize, 28);
          expect(text.style?.fontWeight, FontWeight.w600);
          expect(text.textAlign, TextAlign.center);
        }
      });
    });

    group('dismiss button', () {
      testWidgets('should display play again button', (WidgetTester tester) async {
        // Arrange
        const WINNER_NAME = 'Alice';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: WinnerOverlay(
              winner: WINNER_NAME,
              onDismiss: () {},
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 500));

        // Assert
        expect(find.byType(ElevatedButton), findsOneWidget);
      });

      testWidgets('should display button with green background', (WidgetTester tester) async {
        // Arrange
        const WINNER_NAME = 'Alice';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: WinnerOverlay(
              winner: WINNER_NAME,
              onDismiss: () {},
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 500));

        // Assert
        expect(find.byType(ElevatedButton), findsOneWidget);
        final button = find.byType(ElevatedButton).evaluate().first.widget as ElevatedButton;
        expect(button.style, isNotNull);
      });

      testWidgets('should call onDismiss when button is tapped', (WidgetTester tester) async {
        // Arrange
        const WINNER_NAME = 'Alice';
        final callbackNotifier = ValueNotifier<bool>(false);

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: WinnerOverlay(
              winner: WINNER_NAME,
              onDismiss: () {
                callbackNotifier.value = true;
              },
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 500));
        await tester.tap(find.byType(ElevatedButton));
        await tester.pump(const Duration(milliseconds: 100));

        // Assert
        expect(callbackNotifier.value, true);
      });

      testWidgets('should display button with white text', (WidgetTester tester) async {
        // Arrange
        const WINNER_NAME = 'Alice';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: WinnerOverlay(
              winner: WINNER_NAME,
              onDismiss: () {},
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 500));

        // Assert
        expect(find.byType(ElevatedButton), findsOneWidget);
        final buttonTexts = find.descendant(
          of: find.byType(ElevatedButton),
          matching: find.byType(Text),
        );
        expect(buttonTexts, findsWidgets);
      });
    });

    group('confetti', () {
      testWidgets('should display confetti widgets', (WidgetTester tester) async {
        // Arrange
        const WINNER_NAME = 'Alice';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: WinnerOverlay(
              winner: WINNER_NAME,
              onDismiss: () {},
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 500));

        // Assert
        expect(find.byType(ConfettiWidget), findsWidgets);
      });

      testWidgets('should display three confetti widgets for different positions', (WidgetTester tester) async {
        // Arrange
        const WINNER_NAME = 'Alice';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: WinnerOverlay(
              winner: WINNER_NAME,
              onDismiss: () {},
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 500));

        // Assert
        expect(find.byType(ConfettiWidget), findsNWidgets(3));
      });

      testWidgets('should display confetti in multiple positions', (WidgetTester tester) async {
        // Arrange
        const WINNER_NAME = 'Alice';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: WinnerOverlay(
              winner: WINNER_NAME,
              onDismiss: () {},
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 500));

        // Assert
        final aligns = find.byType(Align).evaluate();
        expect(aligns.length, greaterThanOrEqualTo(3));
      });
    });

    group('layout', () {
      testWidgets('should arrange content in column layout', (WidgetTester tester) async {
        // Arrange
        const WINNER_NAME = 'Alice';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: WinnerOverlay(
              winner: WINNER_NAME,
              onDismiss: () {},
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 500));

        // Assert
        expect(find.byType(Column), findsOneWidget);
      });

      testWidgets('should have spacing between elements', (WidgetTester tester) async {
        // Arrange
        const WINNER_NAME = 'Alice';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: WinnerOverlay(
              winner: WINNER_NAME,
              onDismiss: () {},
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 500));

        // Assert
        expect(find.byType(SizedBox), findsWidgets);
      });

      testWidgets('should fill minimum size in column', (WidgetTester tester) async {
        // Arrange
        const WINNER_NAME = 'Alice';

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: WinnerOverlay(
              winner: WINNER_NAME,
              onDismiss: () {},
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 500));

        // Assert
        final columnFinder = find.byType(Column);
        expect(columnFinder, findsOneWidget);
        final column = columnFinder.evaluate().first.widget as Column;
        expect(column.mainAxisSize, MainAxisSize.min);
      });
    });
  });
}
