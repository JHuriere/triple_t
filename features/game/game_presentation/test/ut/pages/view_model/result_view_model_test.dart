import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/src/pages/view_model/result_view_model.dart';
import 'package:game_presentation/src/pages/view_model/state/result_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:user_domain/user_domain.dart';

import '../../../fixtures/test_data.dart';
import '../../../helpers/mock_current_game_repository.dart';

void main() {
  group('ResultViewModel', () {
    late ProviderContainer container;
    late MockCurrentGameRepository mockRepository;

    ProviderContainer _createContainer({
      required CurrentGameEntity currentGame,
      MockCurrentGameRepository? repository,
    }) {
      final repo = repository ?? MockCurrentGameRepository();
      return ProviderContainer(
        overrides: [
          getCurrentGameUseCaseProvider.overrideWithValue(currentGame),
          getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
          getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
          getCurrentGameRepositoryProvider.overrideWithValue(repo),
          updateCurrentGameStateUseCaseProvider(state: CurrentGameState.playerOneWon).overrideWith((ref) => currentGame),
          updateCurrentGameStateUseCaseProvider(state: CurrentGameState.playerTwoWon).overrideWith((ref) => currentGame),
          updateCurrentGameStateUseCaseProvider(state: CurrentGameState.draw).overrideWith((ref) => currentGame),
          updateUserStatisticsUseCaseProvider(
            currentPlayerId: testPlayerOne.id,
            opponentPlayerId: testPlayerTwo.id,
            result: GameResult.win,
          ).overrideWith((ref) => null),
          updateUserStatisticsUseCaseProvider(
            currentPlayerId: testPlayerOne.id,
            opponentPlayerId: testPlayerTwo.id,
            result: GameResult.lose,
          ).overrideWith((ref) => null),
          updateUserStatisticsUseCaseProvider(
            currentPlayerId: testPlayerOne.id,
            opponentPlayerId: testPlayerTwo.id,
            result: GameResult.draw,
          ).overrideWith((ref) => null),
          updateUserStatisticsUseCaseProvider(
            currentPlayerId: testPlayerTwo.id,
            opponentPlayerId: testPlayerOne.id,
            result: GameResult.lose,
          ).overrideWith((ref) => null),
          updateUserStatisticsUseCaseProvider(
            currentPlayerId: testPlayerTwo.id,
            opponentPlayerId: testPlayerOne.id,
            result: GameResult.draw,
          ).overrideWith((ref) => null),
        ],
      );
    }

    setUp(() {
      mockRepository = MockCurrentGameRepository();
      container = _createContainer(
        currentGame: testCurrentGameEntity,
        repository: mockRepository,
      );
    });

    tearDown(() {
      container.dispose();
    });

    group('build', () {
      test('should return initial result state', () {
        // Arrange & Act
        final state = container.read(resultViewModelProvider);

        // Assert
        expect(state, isA<InitialResultState>());
      });
    });

    group('checkResult', () {
      test('should set winner result state when winner found', () async {
        // Arrange
        final showOverlay = ValueNotifier<bool>(false);
        final gameWithWinner = testCurrentGameEntity.copyWith(
          elements: [testPlayerOne.emoticon, testPlayerOne.emoticon, testPlayerOne.emoticon, '', '', '', '', '', ''],
          oTurn: true,
        );

        final newMockRepository = MockCurrentGameRepository();
        container.dispose();
        container = _createContainer(
          currentGame: gameWithWinner,
          repository: newMockRepository,
        );

        // Act
        final notifier = container.read(resultViewModelProvider.notifier);
        await notifier.checkResult(showOverlay);

        // Assert
        final state = container.read(resultViewModelProvider);
        expect(state, isA<WinnerResultState>());
        expect((state as WinnerResultState).winner, testPlayerTwo.name);
      });

      test('should set no result state when game continues', () async {
        // Arrange
        final showOverlay = ValueNotifier<bool>(false);
        final ongoingGame = testCurrentGameEntity.copyWith(
          elements: [testPlayerOne.emoticon, '', '', '', '', '', '', '', ''],
          oTurn: false,
        );

        final newMockRepository = MockCurrentGameRepository();
        container.dispose();
        container = _createContainer(
          currentGame: ongoingGame,
          repository: newMockRepository,
        );

        // Act
        final notifier = container.read(resultViewModelProvider.notifier);
        await notifier.checkResult(showOverlay);

        // Assert
        final state = container.read(resultViewModelProvider);
        expect(state, isA<NoResultState>());
        expect(showOverlay.value, false);
      });

      test('should update player two statistics when player two wins', () async {
        // Arrange
        final showOverlay = ValueNotifier<bool>(false);
        final gameWithPlayerTwoWin = testCurrentGameEntity.copyWith(
          elements: [testPlayerTwo.emoticon, testPlayerTwo.emoticon, testPlayerTwo.emoticon, '', '', '', '', '', ''],
          oTurn: false,
        );

        final newMockRepository = MockCurrentGameRepository();
        container.dispose();
        container = _createContainer(
          currentGame: gameWithPlayerTwoWin,
          repository: newMockRepository,
        );

        // Act
        final notifier = container.read(resultViewModelProvider.notifier);
        await notifier.checkResult(showOverlay);

        // Assert
        final state = container.read(resultViewModelProvider);
        expect(state, isA<WinnerResultState>());
        expect((state as WinnerResultState).winner, testPlayerOne.name);
      });
    });
  });
}
