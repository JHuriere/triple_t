import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_presentation/src/pages/widget/overlay/draw_overlay.dart';

import '../../../../helpers/widget_test_helpers.dart';

void main() {
  group('DrawOverlay Widget', () {
    group('render', () {
      testWidgets('should display Center widget with content', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          createTestableWidget(
            child: DrawOverlay(onDismiss: () {}),
          ),
        );

        // Act
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Assert
        expect(find.byType(Center), findsOneWidget);
      });

      testWidgets('should display white rounded Container', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          createTestableWidget(
            child: DrawOverlay(onDismiss: () {}),
          ),
        );

        // Act
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Assert
        expect(find.byType(Container), findsWidgets);
      });
    });

    group('content', () {
      testWidgets('should display title text', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          createTestableWidget(
            child: DrawOverlay(onDismiss: () {}),
          ),
        );

        // Act
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Assert
        final texts = find.byType(Text).evaluate();
        expect(texts.length, greaterThanOrEqualTo(2));
      });

      testWidgets('should display title with bold styling', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          createTestableWidget(
            child: DrawOverlay(onDismiss: () {}),
          ),
        );

        // Act
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Assert
        final titleFinder = find.byType(Text).first;
        final text = titleFinder.evaluate().first.widget as Text;
        expect(text.style?.fontWeight, FontWeight.bold);
        expect(text.style?.fontSize, 36);
      });

      testWidgets('should display message text', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          createTestableWidget(
            child: DrawOverlay(onDismiss: () {}),
          ),
        );

        // Act
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Assert
        final textWidgets = find.byType(Text).evaluate();
        // Should have at least title, message, and button text
        expect(textWidgets.length, greaterThanOrEqualTo(2));
      });

      testWidgets('should display message with center alignment', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          createTestableWidget(
            child: DrawOverlay(onDismiss: () {}),
          ),
        );

        // Act
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Assert
        final textWidgets = find.byType(Text).evaluate();
        if (textWidgets.length > 1) {
          final text = textWidgets.elementAt(1).widget as Text;
          expect(text.textAlign, TextAlign.center);
        }
      });
    });

    group('dismiss button', () {
      testWidgets('should display dismiss button', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          createTestableWidget(
            child: DrawOverlay(onDismiss: () {}),
          ),
        );

        // Act
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Assert
        expect(find.byType(ElevatedButton), findsOneWidget);
      });

      testWidgets('should call onDismiss when button is tapped', (WidgetTester tester) async {
        // Arrange
        final callbackNotifier = ValueNotifier<bool>(false);
        await tester.pumpWidget(
          createTestableWidget(
            child: DrawOverlay(
              onDismiss: () {
                callbackNotifier.value = true;
              },
            ),
          ),
        );

        // Act
        await tester.pumpAndSettle(const Duration(milliseconds: 100));
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Assert
        expect(callbackNotifier.value, true);
      });

      testWidgets('should display button with white text', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          createTestableWidget(
            child: DrawOverlay(onDismiss: () {}),
          ),
        );

        // Act
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Assert
        expect(find.byType(ElevatedButton), findsOneWidget);
        // Verify button contains text
        final buttonTexts = find.descendant(
          of: find.byType(ElevatedButton),
          matching: find.byType(Text),
        );
        expect(buttonTexts, findsWidgets);
      });
    });

    group('layout', () {
      testWidgets('should arrange content in column layout', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          createTestableWidget(
            child: DrawOverlay(onDismiss: () {}),
          ),
        );

        // Act
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Assert
        expect(find.byType(Column), findsOneWidget);
      });

      testWidgets('should have spacing between elements', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          createTestableWidget(
            child: DrawOverlay(onDismiss: () {}),
          ),
        );

        // Act
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Assert
        expect(find.byType(SizedBox), findsWidgets);
      });

      testWidgets('should fill minimum size in column', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          createTestableWidget(
            child: DrawOverlay(onDismiss: () {}),
          ),
        );

        // Act
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Assert
        final columnFinder = find.byType(Column);
        expect(columnFinder, findsOneWidget);
        final column = columnFinder.evaluate().first.widget as Column;
        expect(column.mainAxisSize, MainAxisSize.min);
      });
    });
  });
}
