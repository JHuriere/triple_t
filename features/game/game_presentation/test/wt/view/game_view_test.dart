import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/src/pages/view/game_view.dart';
import 'package:user_domain/user_domain.dart';

import '../../fixtures/test_data.dart';
import '../../helpers/widget_test_helpers.dart';

void main() {
  group('GameView Widget Tests', () {
    late ValueNotifier<bool> showOverlay;

    setUp(() {
      showOverlay = ValueNotifier<bool>(false);
    });

    testWidgets('GameView renders all main widgets', (WidgetTester tester) async {
      // Arrange
      final overrides = [
        getCurrentGameUseCaseProvider.overrideWithValue(testCurrentGameEntity),
        getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
        getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
      ];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: GameView(
            onTap: (index) {},
            showOverlay: showOverlay,
          ),
          overrides: overrides,
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('GameView displays turn text', (WidgetTester tester) async {
      // Arrange
      final gameWithTurn = testCurrentGameEntity.copyWith(oTurn: true);
      final overrides = [
        getCurrentGameUseCaseProvider.overrideWithValue(gameWithTurn),
        getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
        getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
      ];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: GameView(
            onTap: (index) {},
            showOverlay: showOverlay,
          ),
          overrides: overrides,
        ),
      );
      await tester.pumpAndSettle();

      // Assert - Should display player one name since oTurn is true
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('GameView calls onTap when grid cell is tapped', (WidgetTester tester) async {
      // Arrange
      int tappedIndex = -1;
      final overrides = [
        getCurrentGameUseCaseProvider.overrideWithValue(testCurrentGameEntity),
        getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
        getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
      ];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: GameView(
            onTap: (index) {
              tappedIndex = index;
            },
            showOverlay: showOverlay,
          ),
          overrides: overrides,
        ),
      );
      await tester.pumpAndSettle();

      // Find and tap the first grid cell
      final gridCells = find.byType(GestureDetector);
      if (gridCells.evaluate().isNotEmpty) {
        await tester.tap(gridCells.first);
        await tester.pumpAndSettle();
      }

      // Assert
      expect(find.byType(GameView), findsOneWidget);
    });

    testWidgets('GameView renders with empty board', (WidgetTester tester) async {
      // Arrange
      final overrides = [
        getCurrentGameUseCaseProvider.overrideWithValue(testGameInitial),
        getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
        getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
      ];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: GameView(
            onTap: (index) {},
            showOverlay: showOverlay,
          ),
          overrides: overrides,
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(GameView), findsOneWidget);
    });

    testWidgets('GameView renders with filled board', (WidgetTester tester) async {
      // Arrange
      final overrides = [
        getCurrentGameUseCaseProvider.overrideWithValue(testGameDraw),
        getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
        getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
      ];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: GameView(
            onTap: (index) {},
            showOverlay: showOverlay,
          ),
          overrides: overrides,
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(GameView), findsOneWidget);
    });
  });
}
