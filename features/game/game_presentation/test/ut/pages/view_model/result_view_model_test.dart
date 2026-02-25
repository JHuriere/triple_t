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

    ProviderContainer createContainer({
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
        ],
      );
    }

    setUp(() {
      mockRepository = MockCurrentGameRepository();
      container = createContainer(
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
        final gameWithWinner = testCurrentGameEntity.copyWith(
          elements: [testPlayerOne.emoticon, testPlayerOne.emoticon, testPlayerOne.emoticon, '', '', '', '', '', ''],
          state: CurrentGameState.playerOneWon,
        );

        final newMockRepository = MockCurrentGameRepository();
        container.dispose();
        container = createContainer(
          currentGame: gameWithWinner,
          repository: newMockRepository,
        );

        // Act
        final notifier = container.read(resultViewModelProvider.notifier);
        await notifier.checkResult();

        // Assert
        final state = container.read(resultViewModelProvider);
        expect(state, isA<WinnerResultState>());
        expect((state as WinnerResultState).winner, testPlayerOne.name);
      });

      test('should set no result state when game continues', () async {
        // Arrange
        final ongoingGame = testCurrentGameEntity.copyWith(
          elements: [testPlayerOne.emoticon, '', '', '', '', '', '', '', ''],
          state: CurrentGameState.inProgress,
        );

        final newMockRepository = MockCurrentGameRepository();
        container.dispose();
        container = createContainer(
          currentGame: ongoingGame,
          repository: newMockRepository,
        );

        // Act
        final notifier = container.read(resultViewModelProvider.notifier);
        await notifier.checkResult();

        // Assert
        final state = container.read(resultViewModelProvider);
        expect(state, isA<NoResultState>());
        expect(state.showOverlay, false);
      });

      test('should update player two statistics when player two wins', () async {
        // Arrange
        final gameWithPlayerTwoWin = testCurrentGameEntity.copyWith(
          elements: [testPlayerTwo.emoticon, testPlayerTwo.emoticon, testPlayerTwo.emoticon, '', '', '', '', '', ''],
          state: CurrentGameState.playerTwoWon,
        );

        final newMockRepository = MockCurrentGameRepository();
        container.dispose();
        container = createContainer(
          currentGame: gameWithPlayerTwoWin,
          repository: newMockRepository,
        );

        // Act
        final notifier = container.read(resultViewModelProvider.notifier);
        await notifier.checkResult();

        // Assert
        final state = container.read(resultViewModelProvider);
        expect(state, isA<WinnerResultState>());
        expect((state as WinnerResultState).winner, testPlayerTwo.name);
      });
    });
  });
}
