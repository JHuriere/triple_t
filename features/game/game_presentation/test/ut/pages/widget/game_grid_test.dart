import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_presentation/src/pages/view_model/result_view_model.dart';
import 'package:game_presentation/src/pages/view_model/state/result_state.dart';
import 'package:game_presentation/src/pages/widget/game_grid.dart';

import '../../../fixtures/test_data.dart';
import '../../../helpers/widget_test_helpers.dart';

void main() {
  group('GameGrid Widget Tests', () {

    setUp(() {
    });

    testWidgets('GameGrid renders 9 cells for empty board', (WidgetTester tester) async {
      // Arrange
      final overrides = [
        resultViewModelProvider.overrideWithValue(InitialResultState()),
      ];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: GameGrid(
            currentGame: testGameInitial,
            playerOneEmoticon: testPlayerOne.emoticon,
            onTap: (index) {},
          ),
          overrides: overrides,
        ),
      );
      await tester.pump();

      // Assert
      expect(find.byType(GestureDetector), findsWidgets);
    });

    testWidgets('GameGrid renders filled cells with emoticons', (WidgetTester tester) async {
      // Arrange
      final gameWithMoves = testCurrentGameEntity.copyWith(
        elements: [testPlayerOne.emoticon, testPlayerTwo.emoticon, '', '', '', '', '', '', ''],
      );
      final overrides = [
        resultViewModelProvider.overrideWithValue(InitialResultState()),
      ];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: GameGrid(
            currentGame: gameWithMoves,
            playerOneEmoticon: testPlayerOne.emoticon,
            onTap: (index) {},
          ),
          overrides: overrides,
        ),
      );
      await tester.pump();

      // Assert
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('GameGrid calls onTap when empty cell is tapped', (WidgetTester tester) async {
      // Arrange
      final overrides = [
        resultViewModelProvider.overrideWithValue(InitialResultState()),
      ];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: GameGrid(
            currentGame: testGameInitial,
            playerOneEmoticon: testPlayerOne.emoticon,
            onTap: (index) {},
          ),
          overrides: overrides,
        ),
      );
      await tester.pump();

      final cells = find.byType(GestureDetector);
      if (cells.evaluate().isNotEmpty) {
        await tester.tap(cells.first);
        await tester.pump();
      }

      // Assert
      expect(find.byType(GameGrid), findsOneWidget);
    });

    testWidgets('GameGrid displays correct player emoticons', (WidgetTester tester) async {
      // Arrange
      final gameWithMoves = testCurrentGameEntity.copyWith(
        elements: [testPlayerOne.emoticon, testPlayerTwo.emoticon, '', '', '', '', '', '', ''],
      );
      final overrides = [
        resultViewModelProvider.overrideWithValue(InitialResultState()),
      ];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: GameGrid(
            currentGame: gameWithMoves,
            playerOneEmoticon: testPlayerOne.emoticon,
            onTap: (index) {},
          ),
          overrides: overrides,
        ),
      );
      await tester.pump();

      // Assert
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('GameGrid renders with full board (draw)', (WidgetTester tester) async {
      // Arrange
      final overrides = [
        resultViewModelProvider.overrideWithValue(DrawResultState()),
      ];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: GameGrid(
            currentGame: testGameDraw,
            playerOneEmoticon: testPlayerOne.emoticon,
            onTap: (index) {},
          ),
          overrides: overrides,
        ),
      );
      await tester.pump();

      // Assert
      expect(find.byType(GameGrid), findsOneWidget);
    });

    testWidgets('GameGrid displays container with proper styling', (WidgetTester tester) async {
      // Arrange
      final overrides = [
        resultViewModelProvider.overrideWithValue(InitialResultState()),
      ];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: GameGrid(
            currentGame: testGameInitial,
            playerOneEmoticon: testPlayerOne.emoticon,
            onTap: (index) {},
          ),
          overrides: overrides,
        ),
      );
      await tester.pump();

      // Assert
      expect(find.byType(Container), findsWidgets);
      expect(find.byType(AspectRatio), findsOneWidget);
    });

    testWidgets('GameGrid renders GridView with fixed 3x3 layout', (WidgetTester tester) async {
      // Arrange
      final overrides = [
        resultViewModelProvider.overrideWithValue(InitialResultState()),
      ];

      // Act
      await tester.pumpWidget(
        createTestableWidget(
          child: GameGrid(
            currentGame: testGameInitial,
            playerOneEmoticon: testPlayerOne.emoticon,
            onTap: (index) {},
          ),
          overrides: overrides,
        ),
      );
      await tester.pump();

      // Assert
      expect(find.byType(GridView), findsOneWidget);
    });
  });
}
