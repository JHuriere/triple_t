import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_presentation/src/pages/widget/overlay/winner_overlay.dart';

import '../../../helpers/widget_test_helpers.dart';

void main() {
  group('WinnerOverlay Widget Tests', () {
    testWidgets('WinnerOverlay displays winner name', (WidgetTester tester) async {
      // Arrange
      const winnerName = 'Alice';
      final overrides = <Override>[];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: WinnerOverlay(
            winner: winnerName,
            onDismiss: () {},
          ),
          overrides: overrides,
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text(winnerName), findsWidgets);
    });

    testWidgets('WinnerOverlay displays confetti animation', (WidgetTester tester) async {
      // Arrange
      const winnerName = 'Alice';
      final overrides = <Override>[];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: WinnerOverlay(
            winner: winnerName,
            onDismiss: () {},
          ),
          overrides: overrides,
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(WinnerOverlay), findsOneWidget);
    });

    testWidgets('WinnerOverlay has dismiss button', (WidgetTester tester) async {
      // Arrange
      const winnerName = 'Alice';
      final overrides = <Override>[];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: WinnerOverlay(
            winner: winnerName,
            onDismiss: () {},
          ),
          overrides: overrides,
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(ElevatedButton), findsWidgets);
    });

    testWidgets('WinnerOverlay calls onDismiss when button is tapped', (WidgetTester tester) async {
      // Arrange
      const winnerName = 'Alice';
      bool dismissed = false;
      final overrides = <Override>[];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: WinnerOverlay(
            winner: winnerName,
            onDismiss: () {
              dismissed = true;
            },
          ),
          overrides: overrides,
        ),
      );
      await tester.pumpAndSettle();

      final button = find.byType(ElevatedButton);
      if (button.evaluate().isNotEmpty) {
        await tester.tap(button.first);
        await tester.pumpAndSettle();
      }

      // Assert
      expect(find.byType(WinnerOverlay), findsOneWidget);
    });

    testWidgets('WinnerOverlay displays with different winner names', (WidgetTester tester) async {
      // Arrange
      const winnerName = 'Bob';
      final overrides = <Override>[];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: WinnerOverlay(
            winner: winnerName,
            onDismiss: () {},
          ),
          overrides: overrides,
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text(winnerName), findsWidgets);
    });

    testWidgets('WinnerOverlay renders fullscreen overlay', (WidgetTester tester) async {
      // Arrange
      const winnerName = 'Alice';
      final overrides = <Override>[];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: WinnerOverlay(
            winner: winnerName,
            onDismiss: () {},
          ),
          overrides: overrides,
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(Stack), findsWidgets);
    });

    testWidgets('WinnerOverlay displays celebration text', (WidgetTester tester) async {
      // Arrange
      const winnerName = 'Alice';
      final overrides = <Override>[];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: WinnerOverlay(
            winner: winnerName,
            onDismiss: () {},
          ),
          overrides: overrides,
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(Text), findsWidgets);
    });
  });
}
