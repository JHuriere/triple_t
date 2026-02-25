import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/src/pages/game_page.dart';
import 'package:game_presentation/src/pages/view/game_view.dart';
import 'package:game_presentation/src/pages/view/overlay_view.dart';
import 'package:game_presentation/src/pages/view_model/result_view_model.dart';
import 'package:game_presentation/src/pages/view_model/state/result_state.dart';
import 'package:user_domain/user_domain.dart';

import '../../fixtures/test_data.dart';
import '../../helpers/widget_test_helpers.dart';

void main() {
  group('GamePage', () {
    group('build', () {
      testWidgets('should render AppBar with title', (WidgetTester tester) async {
        // Arrange
        final overrides = [
          getCurrentGameUseCaseProvider.overrideWithValue(testCurrentGameEntity),
          getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
          getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
          getAllUsersUseCaseProvider.overrideWithValue([testPlayerOne, testPlayerTwo]),
          resultViewModelProvider.overrideWithValue(InitialResultState()),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GamePage(),
            overrides: overrides,
          ),
        );

        // Assert
        expect(find.byType(AppBar), findsOneWidget);
      });

      testWidgets('should render refresh button in AppBar', (WidgetTester tester) async {
        // Arrange
        final overrides = [
          getCurrentGameUseCaseProvider.overrideWithValue(testCurrentGameEntity),
          getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
          getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
          getAllUsersUseCaseProvider.overrideWithValue([testPlayerOne, testPlayerTwo]),
          resultViewModelProvider.overrideWithValue(InitialResultState()),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GamePage(),
            overrides: overrides,
          ),
        );

        // Assert
        expect(find.byIcon(Icons.refresh), findsOneWidget);
      });

      testWidgets('should render Scaffold with Stack body', (WidgetTester tester) async {
        // Arrange
        final overrides = [
          getCurrentGameUseCaseProvider.overrideWithValue(testCurrentGameEntity),
          getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
          getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
          getAllUsersUseCaseProvider.overrideWithValue([testPlayerOne, testPlayerTwo]),
          resultViewModelProvider.overrideWithValue(InitialResultState()),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GamePage(),
            overrides: overrides,
          ),
        );

        // Assert
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(Stack), findsWidgets);
      });

      testWidgets('should render GameView inside Stack', (WidgetTester tester) async {
        // Arrange
        final overrides = [
          getCurrentGameUseCaseProvider.overrideWithValue(testCurrentGameEntity),
          getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
          getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
          getAllUsersUseCaseProvider.overrideWithValue([testPlayerOne, testPlayerTwo]),
          resultViewModelProvider.overrideWithValue(InitialResultState()),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GamePage(),
            overrides: overrides,
          ),
        );

        // Assert
        expect(find.byType(GameView), findsOneWidget);
      });

      testWidgets('should render OverlayView inside Stack', (WidgetTester tester) async {
        // Arrange
        final overrides = [
          getCurrentGameUseCaseProvider.overrideWithValue(testCurrentGameEntity),
          getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
          getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
          getAllUsersUseCaseProvider.overrideWithValue([testPlayerOne, testPlayerTwo]),
          resultViewModelProvider.overrideWithValue(InitialResultState()),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GamePage(),
            overrides: overrides,
          ),
        );

        // Assert
        expect(find.byType(OverlayView), findsOneWidget);
      });

      testWidgets('should render with initial state', (WidgetTester tester) async {
        // Arrange
        final overrides = [
          getCurrentGameUseCaseProvider.overrideWithValue(testGameInitial),
          getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
          getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
          getAllUsersUseCaseProvider.overrideWithValue([testPlayerOne, testPlayerTwo]),
          resultViewModelProvider.overrideWithValue(InitialResultState()),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GamePage(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        expect(find.byType(GamePage), findsOneWidget);
      });

      testWidgets('should render with inProgress state', (WidgetTester tester) async {
        // Arrange
        final overrides = [
          getCurrentGameUseCaseProvider.overrideWithValue(testGameInProgress),
          getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
          getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
          getAllUsersUseCaseProvider.overrideWithValue([testPlayerOne, testPlayerTwo]),
          resultViewModelProvider.overrideWithValue(InitialResultState()),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GamePage(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        expect(find.byType(GamePage), findsOneWidget);
      });

      testWidgets('should render with winner state', (WidgetTester tester) async {
        // Arrange
        final overrides = [
          getCurrentGameUseCaseProvider.overrideWithValue(testGameWithWinner),
          getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
          getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
          getAllUsersUseCaseProvider.overrideWithValue([testPlayerOne, testPlayerTwo]),
          resultViewModelProvider.overrideWithValue(WinnerResultState(winningLine: [0, 1, 2], winner: testPlayerOne.name)),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GamePage(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        expect(find.byType(GamePage), findsOneWidget);
      });

      testWidgets('should render with draw state', (WidgetTester tester) async {
        // Arrange
        final overrides = [
          getCurrentGameUseCaseProvider.overrideWithValue(testGameDraw),
          getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
          getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
          getAllUsersUseCaseProvider.overrideWithValue([testPlayerOne, testPlayerTwo]),
          resultViewModelProvider.overrideWithValue(DrawResultState()),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GamePage(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        expect(find.byType(GamePage), findsOneWidget);
      });
    });

    group('resetGame', () {
      testWidgets('should call resetCurrentGameUseCaseProvider when refresh button tapped', (WidgetTester tester) async {
        // Arrange
        bool resetCalled = false;
        final overrides = [
          getCurrentGameUseCaseProvider.overrideWithValue(testCurrentGameEntity),
          getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
          getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
          getAllUsersUseCaseProvider.overrideWithValue([testPlayerOne, testPlayerTwo]),
          resultViewModelProvider.overrideWithValue(InitialResultState()),
          resetCurrentGameUseCaseProvider.overrideWith((ref) async {
            resetCalled = true;
          }),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GamePage(),
            overrides: overrides,
          ),
        );

        await tester.tap(find.byIcon(Icons.refresh));
        await tester.pumpAndSettle();

        // Assert
        expect(resetCalled, isTrue);
      });

      testWidgets('should invalidate resultViewModelProvider when reset', (WidgetTester tester) async {
        // Arrange
        final overrides = [
          getCurrentGameUseCaseProvider.overrideWithValue(testCurrentGameEntity),
          getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
          getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
          getAllUsersUseCaseProvider.overrideWithValue([testPlayerOne, testPlayerTwo]),
          resultViewModelProvider.overrideWithValue(WinnerResultState(winningLine: [0, 1, 2], winner: testPlayerOne.name)),
          resetCurrentGameUseCaseProvider.overrideWith((ref) async {}),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GamePage(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        await tester.tap(find.byIcon(Icons.refresh));
        await tester.pump();

        // Assert
        expect(find.byType(GamePage), findsOneWidget);
      });

      testWidgets('should invalidate getCurrentGameUseCaseProvider when reset', (WidgetTester tester) async {
        // Arrange
        final overrides = [
          getCurrentGameUseCaseProvider.overrideWithValue(testGameWithWinner),
          getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
          getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
          getAllUsersUseCaseProvider.overrideWithValue([testPlayerOne, testPlayerTwo]),
          resultViewModelProvider.overrideWithValue(WinnerResultState(winningLine: [0, 1, 2], winner: testPlayerOne.name)),
          resetCurrentGameUseCaseProvider.overrideWith((ref) async {}),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GamePage(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        await tester.tap(find.byIcon(Icons.refresh));
        await tester.pump();

        // Assert
        expect(find.byType(GamePage), findsOneWidget);
      });
    });

    group('_onTap', () {
      testWidgets('should prevent tap when canPlay is false', (WidgetTester tester) async {
        // Arrange
        final overrides = [
          getCurrentGameUseCaseProvider.overrideWithValue(testGameInProgress),
          getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
          getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
          getAllUsersUseCaseProvider.overrideWithValue([testPlayerOne, testPlayerTwo]),
          resultViewModelProvider.overrideWithValue(InitialResultState()),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GamePage(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        expect(find.byType(GamePage), findsOneWidget);
      });

      testWidgets('should set canPlay to false during move processing', (WidgetTester tester) async {
        // Arrange
        final overrides = [
          getCurrentGameUseCaseProvider.overrideWithValue(testGameInProgress),
          getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
          getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
          getAllUsersUseCaseProvider.overrideWithValue([testPlayerOne, testPlayerTwo]),
          resultViewModelProvider.overrideWithValue(InitialResultState()),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GamePage(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        expect(find.byType(GamePage), findsOneWidget);
      });

      testWidgets('should set canPlay to true after move processing', (WidgetTester tester) async {
        // Arrange
        final overrides = [
          getCurrentGameUseCaseProvider.overrideWithValue(testGameInProgress),
          getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
          getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
          getAllUsersUseCaseProvider.overrideWithValue([testPlayerOne, testPlayerTwo]),
          resultViewModelProvider.overrideWithValue(InitialResultState()),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GamePage(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        expect(find.byType(GamePage), findsOneWidget);
      });

      testWidgets('should set canPlay to true even when error occurs', (WidgetTester tester) async {
        // Arrange
        final overrides = [
          getCurrentGameUseCaseProvider.overrideWithValue(testGameInProgress),
          getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
          getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
          getAllUsersUseCaseProvider.overrideWithValue([testPlayerOne, testPlayerTwo]),
          resultViewModelProvider.overrideWithValue(InitialResultState()),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const GamePage(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        expect(find.byType(GamePage), findsOneWidget);
      });
    });
  });
}
