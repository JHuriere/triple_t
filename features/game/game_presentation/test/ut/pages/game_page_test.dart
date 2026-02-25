import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/src/pages/game_page.dart';
import 'package:user_domain/user_domain.dart';

import '../../fixtures/test_data.dart';
import '../../helpers/widget_test_helpers.dart';

void main() {
  group('GamePage Widget Tests', () {
    setUp(() {
      // No setup needed for widget tests
    });

    testWidgets('GamePage renders AppBar with title', (WidgetTester tester) async {
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
      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });

    testWidgets('GamePage renders GameView', (WidgetTester tester) async {
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

    testWidgets('GamePage displays refresh button', (WidgetTester tester) async {
      // Arrange
      final overrides = [
        getCurrentGameUseCaseProvider.overrideWithValue(testCurrentGameEntity),
        getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
        getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
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

    testWidgets('GamePage can tap refresh button', (WidgetTester tester) async {
      // Arrange
      final overrides = [
        getCurrentGameUseCaseProvider.overrideWithValue(testCurrentGameEntity),
        getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
        getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
        resetCurrentGameUseCaseProvider.overrideWith((ref) => null),
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
      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });

    testWidgets('GamePage renders with initial state', (WidgetTester tester) async {
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
  });
}
