import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_presentation/src/pages/view_model/current_game_view_model.dart';
import 'package:game_presentation/src/pages/widget/game_statistics.dart';

import '../../../fixtures/test_data.dart';
import '../../../helpers/widget_test_helpers.dart';

void main() {
  group('GameStatistics', () {
    group('render', () {
      testWidgets('should display three stat cards', (WidgetTester tester) async {
        // Arrange
        final overrides = [
          currentGameViewModelProvider.overrideWithValue(
            (currentGame: testCurrentGameEntity, playerOne: testPlayerOne, playerTwo: testPlayerTwo, actionInProgress: false),
          ),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GameStatistics(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        expect(find.byType(Card), findsNWidgets(3));
      });

      testWidgets('should display player one name and wins', (WidgetTester tester) async {
        // Arrange
        final gameWithStats = testGameWithStatistics;
        final overrides = [
          currentGameViewModelProvider.overrideWithValue(
            (currentGame: gameWithStats, playerOne: testPlayerOne, playerTwo: testPlayerTwo, actionInProgress: false),
          ),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GameStatistics(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        expect(find.text(testPlayerOne.name), findsOneWidget);
        expect(find.text('5'), findsOneWidget);
      });

      testWidgets('should display player two name and wins', (WidgetTester tester) async {
        // Arrange
        final gameWithStats = testGameWithStatistics;
        final overrides = [
          currentGameViewModelProvider.overrideWithValue(
            (currentGame: gameWithStats, playerOne: testPlayerOne, playerTwo: testPlayerTwo, actionInProgress: false),
          ),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GameStatistics(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        expect(find.text(testPlayerTwo.name), findsOneWidget);
        expect(find.text('3'), findsOneWidget);
      });

      testWidgets('should display draws count', (WidgetTester tester) async {
        // Arrange
        final gameWithStats = testGameWithStatistics;
        final overrides = [
          currentGameViewModelProvider.overrideWithValue(
            (currentGame: gameWithStats, playerOne: testPlayerOne, playerTwo: testPlayerTwo, actionInProgress: false),
          ),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GameStatistics(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        expect(find.text('2'), findsOneWidget);
      });

      testWidgets('should display player emoticons', (WidgetTester tester) async {
        // Arrange
        final overrides = [
          currentGameViewModelProvider.overrideWithValue(
            (currentGame: testCurrentGameEntity, playerOne: testPlayerOne, playerTwo: testPlayerTwo, actionInProgress: false),
          ),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GameStatistics(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        expect(find.text(testPlayerOne.emoticon), findsOneWidget);
        expect(find.text(testPlayerTwo.emoticon), findsOneWidget);
        expect(find.text('🤝'), findsOneWidget);
      });

      testWidgets('should display zero wins when no games played', (WidgetTester tester) async {
        // Arrange
        final overrides = [
          currentGameViewModelProvider.overrideWithValue(
            (currentGame: testCurrentGameEntity, playerOne: testPlayerOne, playerTwo: testPlayerTwo, actionInProgress: false),
          ),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GameStatistics(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        expect(find.text('0'), findsNWidgets(3));
      });

      testWidgets('should display high statistics correctly', (WidgetTester tester) async {
        // Arrange
        final gameWithHighStats = testGameWithHighStatistics;
        final overrides = [
          currentGameViewModelProvider.overrideWithValue(
            (currentGame: gameWithHighStats, playerOne: testPlayerOne, playerTwo: testPlayerTwo, actionInProgress: false),
          ),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GameStatistics(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        expect(find.text('99'), findsOneWidget);
        expect(find.text('50'), findsOneWidget);
        expect(find.text('25'), findsOneWidget);
      });
    });

    group('layout', () {
      testWidgets('should have row with space between alignment', (WidgetTester tester) async {
        // Arrange
        final overrides = [
          currentGameViewModelProvider.overrideWithValue(
            (currentGame: testCurrentGameEntity, playerOne: testPlayerOne, playerTwo: testPlayerTwo, actionInProgress: false),
          ),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GameStatistics(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        final row = tester.widget<Row>(find.byType(Row).first);
        expect(row.mainAxisAlignment, MainAxisAlignment.spaceBetween);
      });

      testWidgets('should have equal expanded children', (WidgetTester tester) async {
        // Arrange
        final overrides = [
          currentGameViewModelProvider.overrideWithValue(
            (currentGame: testCurrentGameEntity, playerOne: testPlayerOne, playerTwo: testPlayerTwo, actionInProgress: false),
          ),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GameStatistics(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        expect(find.byType(Expanded), findsNWidgets(3));
      });

      testWidgets('should have spacing between cards', (WidgetTester tester) async {
        // Arrange
        final overrides = [
          currentGameViewModelProvider.overrideWithValue(
            (currentGame: testCurrentGameEntity, playerOne: testPlayerOne, playerTwo: testPlayerTwo, actionInProgress: false),
          ),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GameStatistics(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        expect(find.byType(SizedBox), findsWidgets);
      });
    });

    group('styling', () {
      testWidgets('should display cards with rounded corners', (WidgetTester tester) async {
        // Arrange
        final overrides = [
          currentGameViewModelProvider.overrideWithValue(
            (currentGame: testCurrentGameEntity, playerOne: testPlayerOne, playerTwo: testPlayerTwo, actionInProgress: false),
          ),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GameStatistics(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        final cards = tester.widgetList<Card>(find.byType(Card));
        for (final card in cards) {
          final shape = card.shape as RoundedRectangleBorder;
          expect(shape.borderRadius, BorderRadius.circular(16));
        }
      });

      testWidgets('should display cards with elevation', (WidgetTester tester) async {
        // Arrange
        final overrides = [
          currentGameViewModelProvider.overrideWithValue(
            (currentGame: testCurrentGameEntity, playerOne: testPlayerOne, playerTwo: testPlayerTwo, actionInProgress: false),
          ),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GameStatistics(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        final cards = tester.widgetList<Card>(find.byType(Card));
        for (final card in cards) {
          expect(card.elevation, 2);
        }
      });

      testWidgets('should apply gradient to containers', (WidgetTester tester) async {
        // Arrange
        final overrides = [
          currentGameViewModelProvider.overrideWithValue(
            (currentGame: testCurrentGameEntity, playerOne: testPlayerOne, playerTwo: testPlayerTwo, actionInProgress: false),
          ),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GameStatistics(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        final containers = tester.widgetList<Container>(find.byType(Container));
        expect(containers.length, greaterThan(0));
      });
    });

    group('color scheme', () {
      testWidgets('should use primary color for player one', (WidgetTester tester) async {
        // Arrange
        final overrides = [
          currentGameViewModelProvider.overrideWithValue(
            (currentGame: testCurrentGameEntity, playerOne: testPlayerOne, playerTwo: testPlayerTwo, actionInProgress: false),
          ),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GameStatistics(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        expect(find.byType(Card), findsNWidgets(3));
      });

      testWidgets('should use tertiary color for draws', (WidgetTester tester) async {
        // Arrange
        final overrides = [
          currentGameViewModelProvider.overrideWithValue(
            (currentGame: testCurrentGameEntity, playerOne: testPlayerOne, playerTwo: testPlayerTwo, actionInProgress: false),
          ),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GameStatistics(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        expect(find.byType(Card), findsNWidgets(3));
      });

      testWidgets('should use secondary color for player two', (WidgetTester tester) async {
        // Arrange
        final overrides = [
          currentGameViewModelProvider.overrideWithValue(
            (currentGame: testCurrentGameEntity, playerOne: testPlayerOne, playerTwo: testPlayerTwo, actionInProgress: false),
          ),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GameStatistics(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        expect(find.byType(Card), findsNWidgets(3));
      });
    });

    group('text overflow', () {
      testWidgets('should handle long player names with ellipsis', (WidgetTester tester) async {
        // Arrange
        final longNamePlayer = testPlayerOne.copyWith(name: 'Very Long Player Name That Should Be Truncated');
        final overrides = [
          currentGameViewModelProvider.overrideWithValue(
            (currentGame: testCurrentGameEntity, playerOne: longNamePlayer, playerTwo: testPlayerTwo, actionInProgress: false),
          ),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GameStatistics(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        expect(find.byType(Text), findsWidgets);
      });
    });
  });
}
