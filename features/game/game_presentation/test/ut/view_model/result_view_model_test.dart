import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/src/pages/view_model/current_game_view_model.dart';
import 'package:game_presentation/src/pages/view_model/result_view_model.dart';
import 'package:game_presentation/src/pages/view_model/state/result_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../fixtures/test_data.dart';

void main() {
  group('ResultViewModel', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          getCurrentGameUseCaseProvider.overrideWithValue(testCurrentGameEntity),
          getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
          getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
          updateCurrentGameStateUseCaseProvider(state: CurrentGameState.playerOneWon).overrideWithValue(testCurrentGameEntity),
          updateUserStatisticsUseCaseProvider(
            currentPlayerId: testPlayerOne.id,
            opponentPlayerId: testPlayerTwo.id,
            result: GameResult.win,
          ).overrideWithValue(null),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('build should return InitialResultState', () {
      // Act
      final state = container.read(resultViewModelProvider);

      // Assert
      expect(state, isA<InitialResultState>());
    });

    test('checkResult should set WinnerResultState when winner found', () async {
      // Arrange
      final showOverlay = ValueNotifier<bool>(false);

      final gameWithWinner = testCurrentGameEntity.copyWith(
        elements: [testPlayerOne.emoticon, testPlayerOne.emoticon, testPlayerOne.emoticon, '', '', '', '', '', ''],
        oTurn: true,
      );

      container = ProviderContainer(
        overrides: [
          getCurrentGameUseCaseProvider.overrideWithValue(gameWithWinner),
          getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
          getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
          updateCurrentGameStateUseCaseProvider(state: CurrentGameState.playerOneWon).overrideWithValue(gameWithWinner),
          updateUserStatisticsUseCaseProvider(
            currentPlayerId: testPlayerOne.id,
            opponentPlayerId: testPlayerTwo.id,
            result: GameResult.win,
          ).overrideWithValue(null),
          updateUserStatisticsUseCaseProvider(
            currentPlayerId: testPlayerTwo.id,
            opponentPlayerId: testPlayerOne.id,
            result: GameResult.lose,
          ).overrideWithValue(null),
        ],
      );

      // Act
      final notifier = container.read(resultViewModelProvider.notifier);
      await notifier.checkResult(showOverlay);

      // Assert
      final state = container.read(resultViewModelProvider);
      expect(state, isA<WinnerResultState>());
    });

    test('checkResult should set DrawResultState when board is full', () async {
      // Arrange
      final showOverlay = ValueNotifier<bool>(false);

      final drawGame = testGameDraw.copyWith(oTurn: true);

      container = ProviderContainer(
        overrides: [
          getCurrentGameUseCaseProvider.overrideWithValue(drawGame),
          getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
          getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
          updateCurrentGameStateUseCaseProvider(state: CurrentGameState.draw).overrideWithValue(drawGame),
          updateUserStatisticsUseCaseProvider(
            currentPlayerId: testPlayerOne.id,
            opponentPlayerId: testPlayerTwo.id,
            result: GameResult.draw,
          ).overrideWithValue(null),
          updateUserStatisticsUseCaseProvider(
            currentPlayerId: testPlayerTwo.id,
            opponentPlayerId: testPlayerOne.id,
            result: GameResult.draw,
          ).overrideWithValue(null),
        ],
      );

      // Act
      final notifier = container.read(resultViewModelProvider.notifier);
      await notifier.checkResult(showOverlay);

      // Assert
      final state = container.read(resultViewModelProvider);
      expect(state, isA<DrawResultState>());
      await Future<void>.delayed(const Duration(milliseconds: 600));
      expect(showOverlay.value, true);
    });

    test('checkResult should set NoResultState when game continues', () async {
      // Arrange
      final showOverlay = ValueNotifier<bool>(false);

      final ongoingGame = testCurrentGameEntity.copyWith(
        elements: [testPlayerOne.emoticon, '', '', '', '', '', '', '', ''],
        oTurn: false,
      );

      container = ProviderContainer(
        overrides: [
          getCurrentGameUseCaseProvider.overrideWithValue(ongoingGame),
          getUserByIdUseCaseProvider(testPlayerOne.id).overrideWithValue(testPlayerOne),
          getUserByIdUseCaseProvider(testPlayerTwo.id).overrideWithValue(testPlayerTwo),
        ],
      );

      // Act
      final notifier = container.read(resultViewModelProvider.notifier);
      await notifier.checkResult(showOverlay);

      // Assert
      final state = container.read(resultViewModelProvider);
      expect(state, isA<NoResultState>());
      expect(showOverlay.value, false);
    });
  });
}
