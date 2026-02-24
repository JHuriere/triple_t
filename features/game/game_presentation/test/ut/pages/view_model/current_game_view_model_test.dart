import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/src/pages/view_model/current_game_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:user_domain/user_domain.dart';

import '../../../fixtures/test_data.dart';

void main() {
  group('CurrentGameViewModel', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          getCurrentGameUseCaseProvider.overrideWithValue(testCurrentGameEntity),
          getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
          getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('build should return initial game state with players', () {
      // Act
      final viewModel = container.read(currentGameViewModelProvider);

      // Assert
      expect(viewModel.currentGame, testCurrentGameEntity);
      expect(viewModel.playerOne, testPlayerOne);
      expect(viewModel.playerTwo, testPlayerTwo);
    });

    test('playNextMove should update elements with player emoticon', () async {
      // Arrange
      const moveIndex = 0;
      final updatedElements = [...testCurrentGameEntity.elements];
      updatedElements[moveIndex] = testPlayerOne.emoticon;
      final updatedGame = testCurrentGameEntity.copyWith(elements: updatedElements);

      container = ProviderContainer(
        overrides: [
          getCurrentGameUseCaseProvider.overrideWithValue(testCurrentGameEntity),
          getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
          getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
          updateCurrentGameElementsUseCaseProvider(elements: updatedElements).overrideWith((ref) => updatedGame),
        ],
      );

      // Act
      final notifier = container.read(currentGameViewModelProvider.notifier);
      await notifier.playNextMove(moveIndex);

      // Assert
      final result = container.read(currentGameViewModelProvider);
      expect(result.currentGame.elements[moveIndex], testPlayerOne.emoticon);
    });

    test('playNextMove should use playerTwo emoticon when not oTurn', () async {
      // Arrange
      final gameNotOTurn = testCurrentGameEntity.copyWith(oTurn: false);
      const moveIndex = 1;
      final updatedElements = [...gameNotOTurn.elements];
      updatedElements[moveIndex] = testPlayerTwo.emoticon;
      final updatedGame = gameNotOTurn.copyWith(elements: updatedElements);

      container = ProviderContainer(
        overrides: [
          getCurrentGameUseCaseProvider.overrideWithValue(gameNotOTurn),
          getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
          getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
          updateCurrentGameElementsUseCaseProvider(elements: updatedElements).overrideWith((ref) => updatedGame),
        ],
      );

      // Act
      final notifier = container.read(currentGameViewModelProvider.notifier);
      await notifier.playNextMove(moveIndex);

      // Assert
      final result = container.read(currentGameViewModelProvider);
      expect(result.currentGame.elements[moveIndex], testPlayerTwo.emoticon);
    });

    test('playNextAIMove should return false when it is playerOne turn', () async {
      // Arrange
      final gameTurn = testCurrentGameEntity.copyWith(oTurn: true);

      container = ProviderContainer(
        overrides: [
          getCurrentGameUseCaseProvider.overrideWithValue(gameTurn),
          getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
          getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
        ],
      );

      // Act
      final notifier = container.read(currentGameViewModelProvider.notifier);
      final result = await notifier.playNextAIMove();

      // Assert
      expect(result, false);
    });

    test('playNextAIMove should return false when playerTwo is not AI', () async {
      // Arrange
      final gameTurn = testCurrentGameEntity.copyWith(oTurn: false, playerTwoId: 2);

      container = ProviderContainer(
        overrides: [
          getCurrentGameUseCaseProvider.overrideWithValue(gameTurn),
          getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
          getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
        ],
      );

      // Act
      final notifier = container.read(currentGameViewModelProvider.notifier);
      final result = await notifier.playNextAIMove();

      // Assert
      expect(result, false);
    });
  });
}
