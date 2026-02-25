import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/src/pages/widget/dropdown_player.dart';
import 'package:game_presentation/src/pages/widget/select_players.dart';
import 'package:user_domain/user_domain.dart';

import '../../../fixtures/test_data.dart';
import '../../../helpers/widget_test_helpers.dart';

void main() {
  group('SelectPlayers', () {
    group('render', () {
      testWidgets('should display two DropdownPlayer widgets', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo, testPlayerThree];
        final overrides = [
          getAllUsersUseCaseProvider.overrideWithValue(users),
          getCurrentGameUseCaseProvider.overrideWithValue(testCurrentGameEntity),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const SelectPlayers(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        expect(find.byType(DropdownPlayer), findsNWidgets(2));
      });

      testWidgets('should display Column container', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo];
        final overrides = [
          getAllUsersUseCaseProvider.overrideWithValue(users),
          getCurrentGameUseCaseProvider.overrideWithValue(testCurrentGameEntity),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const SelectPlayers(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        expect(find.byType(Column), findsOneWidget);
      });

      testWidgets('should display Row with spacing', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo];
        final overrides = [
          getAllUsersUseCaseProvider.overrideWithValue(users),
          getCurrentGameUseCaseProvider.overrideWithValue(testCurrentGameEntity),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const SelectPlayers(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        expect(find.byType(SelectPlayers), findsOneWidget);
        expect(find.byType(SizedBox), findsWidgets);
      });
    });

    group('player one dropdown', () {
      testWidgets('should exclude AI (id 1) from player one dropdown', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo, testPlayerThree];
        final overrides = [
          getAllUsersUseCaseProvider.overrideWithValue(users),
          getCurrentGameUseCaseProvider.overrideWithValue(testCurrentGameEntity),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const SelectPlayers(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        final dropdown = tester.widget<DropdownPlayer>(find.byType(DropdownPlayer).first);
        expect(dropdown.excludedUserIds, contains(1));
      });

      testWidgets('should exclude player two from player one dropdown', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo, testPlayerThree];
        final gameWithPlayers = testCurrentGameEntity.copyWith(
          playerOneId: testPlayerOne.id,
          playerTwoId: testPlayerTwo.id,
        );
        final overrides = [
          getAllUsersUseCaseProvider.overrideWithValue(users),
          getCurrentGameUseCaseProvider.overrideWithValue(gameWithPlayers),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const SelectPlayers(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        final dropdown = tester.widget<DropdownPlayer>(find.byType(DropdownPlayer).first);
        expect(dropdown.excludedUserIds, contains(testPlayerTwo.id));
      });

      testWidgets('should display selected player one', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo, testPlayerThree];
        final gameWithPlayers = testCurrentGameEntity.copyWith(
          playerOneId: testPlayerOne.id,
        );
        final overrides = [
          getAllUsersUseCaseProvider.overrideWithValue(users),
          getCurrentGameUseCaseProvider.overrideWithValue(gameWithPlayers),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const SelectPlayers(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        final dropdown = tester.widget<DropdownPlayer>(find.byType(DropdownPlayer).first);
        expect(dropdown.value, testPlayerOne.id);
      });

      testWidgets('should display null value when player one id is 0', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo, testPlayerThree];
        final gameWithNoPlayers = testCurrentGameEntity.copyWith(playerOneId: 0);
        final overrides = [
          getAllUsersUseCaseProvider.overrideWithValue(users),
          getCurrentGameUseCaseProvider.overrideWithValue(gameWithNoPlayers),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const SelectPlayers(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        final dropdown = tester.widget<DropdownPlayer>(find.byType(DropdownPlayer).first);
        expect(dropdown.value, isNull);
      });
    });

    group('player two dropdown', () {
      testWidgets('should exclude player one from player two dropdown', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo, testPlayerThree];
        final gameWithPlayers = testCurrentGameEntity.copyWith(
          playerOneId: testPlayerOne.id,
          playerTwoId: testPlayerTwo.id,
        );
        final overrides = [
          getAllUsersUseCaseProvider.overrideWithValue(users),
          getCurrentGameUseCaseProvider.overrideWithValue(gameWithPlayers),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const SelectPlayers(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        final dropdown = tester.widget<DropdownPlayer>(find.byType(DropdownPlayer).last);
        expect(dropdown.excludedUserIds, contains(testPlayerOne.id));
      });

      testWidgets('should not exclude AI (id 1) from player two dropdown', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo, testPlayerThree];
        final overrides = [
          getAllUsersUseCaseProvider.overrideWithValue(users),
          getCurrentGameUseCaseProvider.overrideWithValue(testCurrentGameEntity),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const SelectPlayers(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        final dropdown = tester.widget<DropdownPlayer>(find.byType(DropdownPlayer).last);
        expect(dropdown.excludedUserIds, isNot(contains(1)));
      });

      testWidgets('should display selected player two', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo, testPlayerThree];
        final gameWithPlayers = testCurrentGameEntity.copyWith(
          playerTwoId: testPlayerTwo.id,
        );
        final overrides = [
          getAllUsersUseCaseProvider.overrideWithValue(users),
          getCurrentGameUseCaseProvider.overrideWithValue(gameWithPlayers),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const SelectPlayers(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        final dropdown = tester.widget<DropdownPlayer>(find.byType(DropdownPlayer).last);
        expect(dropdown.value, testPlayerTwo.id);
      });

      testWidgets('should display null value when player two id is 0', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo, testPlayerThree];
        final gameWithNoPlayers = testCurrentGameEntity.copyWith(playerTwoId: 0);
        final overrides = [
          getAllUsersUseCaseProvider.overrideWithValue(users),
          getCurrentGameUseCaseProvider.overrideWithValue(gameWithNoPlayers),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const SelectPlayers(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        final dropdown = tester.widget<DropdownPlayer>(find.byType(DropdownPlayer).last);
        expect(dropdown.value, isNull);
      });
    });

    group('enabled state', () {
      testWidgets('should enable dropdowns when game state is initial', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo, testPlayerThree];
        final gameInitial = testCurrentGameEntity.copyWith(state: CurrentGameState.initial);
        final overrides = [
          getAllUsersUseCaseProvider.overrideWithValue(users),
          getCurrentGameUseCaseProvider.overrideWithValue(gameInitial),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const SelectPlayers(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        final dropdowns = tester.widgetList<DropdownPlayer>(find.byType(DropdownPlayer));
        for (final dropdown in dropdowns) {
          expect(dropdown.enabled, isTrue);
        }
      });

      testWidgets('should disable dropdowns when game state is inProgress', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo, testPlayerThree];
        final gameInProgress = testCurrentGameEntity.copyWith(state: CurrentGameState.inProgress);
        final overrides = [
          getAllUsersUseCaseProvider.overrideWithValue(users),
          getCurrentGameUseCaseProvider.overrideWithValue(gameInProgress),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const SelectPlayers(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        final dropdowns = tester.widgetList<DropdownPlayer>(find.byType(DropdownPlayer));
        for (final dropdown in dropdowns) {
          expect(dropdown.enabled, isFalse);
        }
      });

      testWidgets('should disable dropdowns when game state is playerOneWon', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo, testPlayerThree];
        final gamePlayerOneWon = testCurrentGameEntity.copyWith(state: CurrentGameState.playerOneWon);
        final overrides = [
          getAllUsersUseCaseProvider.overrideWithValue(users),
          getCurrentGameUseCaseProvider.overrideWithValue(gamePlayerOneWon),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const SelectPlayers(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        final dropdowns = tester.widgetList<DropdownPlayer>(find.byType(DropdownPlayer));
        for (final dropdown in dropdowns) {
          expect(dropdown.enabled, isFalse);
        }
      });

      testWidgets('should disable dropdowns when game state is playerTwoWon', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo, testPlayerThree];
        final gamePlayerTwoWon = testCurrentGameEntity.copyWith(state: CurrentGameState.playerTwoWon);
        final overrides = [
          getAllUsersUseCaseProvider.overrideWithValue(users),
          getCurrentGameUseCaseProvider.overrideWithValue(gamePlayerTwoWon),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const SelectPlayers(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        final dropdowns = tester.widgetList<DropdownPlayer>(find.byType(DropdownPlayer));
        for (final dropdown in dropdowns) {
          expect(dropdown.enabled, isFalse);
        }
      });

      testWidgets('should disable dropdowns when game state is draw', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo, testPlayerThree];
        final gameDraw = testCurrentGameEntity.copyWith(state: CurrentGameState.draw);
        final overrides = [
          getAllUsersUseCaseProvider.overrideWithValue(users),
          getCurrentGameUseCaseProvider.overrideWithValue(gameDraw),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const SelectPlayers(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        final dropdowns = tester.widgetList<DropdownPlayer>(find.byType(DropdownPlayer));
        for (final dropdown in dropdowns) {
          expect(dropdown.enabled, isFalse);
        }
      });
    });

    group('layout', () {
      testWidgets('should have row with two expanded children', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo];
        final overrides = [
          getAllUsersUseCaseProvider.overrideWithValue(users),
          getCurrentGameUseCaseProvider.overrideWithValue(testCurrentGameEntity),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const SelectPlayers(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        expect(find.byType(Row), findsWidgets);
        expect(find.byType(Expanded), findsAtLeastNWidgets(2));
      });

      testWidgets('should have spacing between dropdowns', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo];
        final overrides = [
          getAllUsersUseCaseProvider.overrideWithValue(users),
          getCurrentGameUseCaseProvider.overrideWithValue(testCurrentGameEntity),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const SelectPlayers(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
        final spacingBox = sizedBoxes.firstWhere(
          (box) => box.width == 20,
          orElse: () => const SizedBox(),
        );
        expect(spacingBox.width, 20);
      });
    });

    group('_changePlayerOne', () {
      testWidgets('should call updateCurrentGamePlayerUseCase when player one changes', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo, testPlayerThree];
        bool updateCalled = false;
        final gameInitial = testCurrentGameEntity.copyWith(
          state: CurrentGameState.initial,
          playerOneId: testPlayerOne.id,
        );

        final overrides = [
          getAllUsersUseCaseProvider.overrideWithValue(users),
          getCurrentGameUseCaseProvider.overrideWithValue(gameInitial),
          updateCurrentGamePlayerUseCaseProvider(playerOneId: testPlayerThree.id).overrideWith((ref) async {
            updateCalled = true;
          }),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const SelectPlayers(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        final dropdown = tester.widget<DropdownPlayer>(find.byType(DropdownPlayer).first);
        await dropdown.onChanged(testPlayerThree.id);
        await tester.pump();

        // Assert
        expect(updateCalled, isTrue);
      });

      testWidgets('should not call updateCurrentGamePlayerUseCase when same player one selected', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo, testPlayerThree];
        bool updateCalled = false;
        final gameWithPlayers = testCurrentGameEntity.copyWith(
          playerOneId: testPlayerOne.id,
        );

        final overrides = [
          getAllUsersUseCaseProvider.overrideWithValue(users),
          getCurrentGameUseCaseProvider.overrideWithValue(gameWithPlayers),
          updateCurrentGamePlayerUseCaseProvider(playerOneId: testPlayerOne.id).overrideWith((ref) async {
            updateCalled = true;
          }),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const SelectPlayers(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        final dropdown = tester.widget<DropdownPlayer>(find.byType(DropdownPlayer).first);
        await dropdown.onChanged(testPlayerOne.id);
        await tester.pump();

        // Assert
        expect(updateCalled, isFalse);
      });

      testWidgets('should invalidate getCurrentGameUseCaseProvider after player one change', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo, testPlayerThree];
        final gameInitial = testCurrentGameEntity.copyWith(
          state: CurrentGameState.initial,
          playerOneId: testPlayerOne.id,
        );

        final overrides = [
          getAllUsersUseCaseProvider.overrideWithValue(users),
          getCurrentGameUseCaseProvider.overrideWithValue(gameInitial),
          updateCurrentGamePlayerUseCaseProvider(playerOneId: testPlayerThree.id).overrideWith((ref) async {}),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const SelectPlayers(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        final dropdown = tester.widget<DropdownPlayer>(find.byType(DropdownPlayer).first);
        await dropdown.onChanged(testPlayerThree.id);
        await tester.pump();

        // Assert
        expect(find.byType(SelectPlayers), findsOneWidget);
      });
    });

    group('_changePlayerTwo', () {
      testWidgets('should call updateCurrentGamePlayerUseCase when player two changes', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo, testPlayerThree];
        bool updateCalled = false;
        final gameInitial = testCurrentGameEntity.copyWith(
          state: CurrentGameState.initial,
          playerTwoId: testPlayerTwo.id,
        );

        final overrides = [
          getAllUsersUseCaseProvider.overrideWithValue(users),
          getCurrentGameUseCaseProvider.overrideWithValue(gameInitial),
          updateCurrentGamePlayerUseCaseProvider(playerTwoId: testPlayerThree.id).overrideWith((ref) async {
            updateCalled = true;
          }),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const SelectPlayers(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        final dropdown = tester.widget<DropdownPlayer>(find.byType(DropdownPlayer).last);
        await dropdown.onChanged(testPlayerThree.id);
        await tester.pump();

        // Assert
        expect(updateCalled, isTrue);
      });

      testWidgets('should not call updateCurrentGamePlayerUseCase when same player two selected', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo, testPlayerThree];
        bool updateCalled = false;
        final gameWithPlayers = testCurrentGameEntity.copyWith(
          playerTwoId: testPlayerTwo.id,
        );

        final overrides = [
          getAllUsersUseCaseProvider.overrideWithValue(users),
          getCurrentGameUseCaseProvider.overrideWithValue(gameWithPlayers),
          updateCurrentGamePlayerUseCaseProvider(playerTwoId: testPlayerTwo.id).overrideWith((ref) async {
            updateCalled = true;
          }),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const SelectPlayers(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        final dropdown = tester.widget<DropdownPlayer>(find.byType(DropdownPlayer).last);
        await dropdown.onChanged(testPlayerTwo.id);
        await tester.pump();

        // Assert
        expect(updateCalled, isFalse);
      });

      testWidgets('should invalidate getCurrentGameUseCaseProvider after player two change', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne, testPlayerTwo, testPlayerThree];
        final gameInitial = testCurrentGameEntity.copyWith(
          state: CurrentGameState.initial,
          playerTwoId: testPlayerTwo.id,
        );

        final overrides = [
          getAllUsersUseCaseProvider.overrideWithValue(users),
          getCurrentGameUseCaseProvider.overrideWithValue(gameInitial),
          updateCurrentGamePlayerUseCaseProvider(playerTwoId: testPlayerThree.id).overrideWith((ref) async {}),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const SelectPlayers(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        final dropdown = tester.widget<DropdownPlayer>(find.byType(DropdownPlayer).last);
        await dropdown.onChanged(testPlayerThree.id);
        await tester.pump();

        // Assert
        expect(find.byType(SelectPlayers), findsOneWidget);
      });
    });

    group('edge cases', () {
      testWidgets('should handle empty users list', (WidgetTester tester) async {
        // Arrange
        final overrides = [
          getAllUsersUseCaseProvider.overrideWithValue([]),
          getCurrentGameUseCaseProvider.overrideWithValue(testCurrentGameEntity),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const SelectPlayers(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        expect(find.byType(DropdownPlayer), findsNWidgets(2));
      });

      testWidgets('should handle single user in list', (WidgetTester tester) async {
        // Arrange
        final users = [testPlayerOne];
        final overrides = [
          getAllUsersUseCaseProvider.overrideWithValue(users),
          getCurrentGameUseCaseProvider.overrideWithValue(testCurrentGameEntity),
        ];

        // Act
        await tester.pumpWidget(
          createTestableWidget(
            child: const SelectPlayers(),
            overrides: overrides,
          ),
        );
        await tester.pump();

        // Assert
        expect(find.byType(DropdownPlayer), findsNWidgets(2));
      });
    });
  });
}
