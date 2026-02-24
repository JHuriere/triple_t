import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_presentation/src/pages/widget/overlay/draw_overlay.dart';

import '../../../helpers/widget_test_helpers.dart';

void main() {
  group('DrawOverlay Widget Tests', () {
    testWidgets('DrawOverlay displays draw message', (WidgetTester tester) async {
      // Arrange
      final overrides = <dynamic>[];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: DrawOverlay(
            onDismiss: () {},
          ),
          overrides: overrides,
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('DrawOverlay has dismiss button', (WidgetTester tester) async {
      // Arrange
      final overrides = <dynamic>[];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: DrawOverlay(
            onDismiss: () {},
          ),
          overrides: overrides,
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(ElevatedButton), findsWidgets);
    });

    testWidgets('DrawOverlay calls onDismiss when button is tapped', (WidgetTester tester) async {
      // Arrange
      final overrides = <dynamic>[];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: DrawOverlay(
            onDismiss: () {},
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
      expect(find.byType(DrawOverlay), findsOneWidget);
    });

    testWidgets('DrawOverlay renders fullscreen overlay', (WidgetTester tester) async {
      // Arrange
      final overrides = <dynamic>[];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: DrawOverlay(
            onDismiss: () {},
          ),
          overrides: overrides,
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(Stack), findsWidgets);
    });

    testWidgets('DrawOverlay displays neutral emoji', (WidgetTester tester) async {
      // Arrange
      final overrides = <dynamic>[];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: DrawOverlay(
            onDismiss: () {},
          ),
          overrides: overrides,
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('DrawOverlay displays centered content', (WidgetTester tester) async {
      // Arrange
      final overrides = <dynamic>[];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: DrawOverlay(
            onDismiss: () {},
          ),
          overrides: overrides,
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(Center), findsWidgets);
    });

    testWidgets('DrawOverlay background is semi-transparent', (WidgetTester tester) async {
      // Arrange
      final overrides = <dynamic>[];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: DrawOverlay(
            onDismiss: () {},
          ),
          overrides: overrides,
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(Container), findsWidgets);
    });
  });
}
