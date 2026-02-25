import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/src/pages/view_model/current_game_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:user_domain/user_domain.dart';

import '../../../fixtures/test_data.dart';
import '../../../helpers/mock_current_game_repository.dart';

void main() {
  group('CurrentGameViewModel', () {
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
      test('should return initial game state with players', () {
        // Arrange & Act
        final viewModel = container.read(currentGameViewModelProvider);

        // Assert
        expect(viewModel.currentGame, testCurrentGameEntity);
        expect(viewModel.playerOne, testPlayerOne);
        expect(viewModel.playerTwo, testPlayerTwo);
      });
    });

    group('playNextMove', () {
      test('should update elements with playerOne emoticon when oTurn is true', () async {
        // Arrange
        const MOVE_INDEX = 0;
        final updatedElements = [...testCurrentGameEntity.elements];
        updatedElements[MOVE_INDEX] = testPlayerOne.emoticon;
        final updatedGame = testCurrentGameEntity.copyWith(elements: updatedElements);

        when(mockRepository.get()).thenReturn(testCurrentGameEntity);
        when(mockRepository.save(argThat(isA<CurrentGameEntity>()))).thenAnswer((_) async => updatedGame);

        // Act
        final notifier = container.read(currentGameViewModelProvider.notifier);
        await notifier.playNextMove(MOVE_INDEX);

        // Assert
        final result = container.read(currentGameViewModelProvider);
        expect(result.currentGame.elements[MOVE_INDEX], testPlayerOne.emoticon);
        verify(mockRepository.get()).called(1);
        verify(mockRepository.save(argThat(isA<CurrentGameEntity>()))).called(1);
      });

      test('should update elements with playerTwo emoticon when oTurn is false', () async {
        // Arrange
        final gameNotOTurn = testCurrentGameEntity.copyWith(oTurn: false);
        const MOVE_INDEX = 1;
        final updatedElements = [...gameNotOTurn.elements];
        updatedElements[MOVE_INDEX] = testPlayerTwo.emoticon;
        final updatedGame = gameNotOTurn.copyWith(elements: updatedElements);

        final newMockRepository = MockCurrentGameRepository();
        container.dispose();
        container = _createContainer(
          currentGame: gameNotOTurn,
          repository: newMockRepository,
        );

        when(newMockRepository.get()).thenReturn(gameNotOTurn);
        when(newMockRepository.save(argThat(isA<CurrentGameEntity>()))).thenAnswer((_) async => updatedGame);

        // Act
        final notifier = container.read(currentGameViewModelProvider.notifier);
        await notifier.playNextMove(MOVE_INDEX);

        // Assert
        final result = container.read(currentGameViewModelProvider);
        expect(result.currentGame.elements[MOVE_INDEX], testPlayerTwo.emoticon);
        verify(newMockRepository.get()).called(1);
        verify(newMockRepository.save(argThat(isA<CurrentGameEntity>()))).called(1);
      });

      test('should preserve other elements when updating single move', () async {
        // Arrange
        const MOVE_INDEX = 4;
        final initialElements = ['😊', '', '', '', '', '', '', '', ''];
        final gameWithElements = testCurrentGameEntity.copyWith(elements: initialElements);
        final updatedElements = [...initialElements];
        updatedElements[MOVE_INDEX] = testPlayerOne.emoticon;
        final updatedGame = gameWithElements.copyWith(elements: updatedElements);

        final newMockRepository = MockCurrentGameRepository();
        container.dispose();
        container = _createContainer(
          currentGame: gameWithElements,
          repository: newMockRepository,
        );

        when(newMockRepository.get()).thenReturn(gameWithElements);
        when(newMockRepository.save(argThat(isA<CurrentGameEntity>()))).thenAnswer((_) async => updatedGame);

        // Act
        final notifier = container.read(currentGameViewModelProvider.notifier);
        await notifier.playNextMove(MOVE_INDEX);

        // Assert
        final result = container.read(currentGameViewModelProvider);
        expect(result.currentGame.elements[0], initialElements[0]);
        expect(result.currentGame.elements[MOVE_INDEX], testPlayerOne.emoticon);
      });
    });

    group('playNextAIMove', () {
      test('should return false when it is playerOne turn', () async {
        // Arrange
        final gameTurn = testCurrentGameEntity.copyWith(oTurn: true);

        final newMockRepository = MockCurrentGameRepository();
        container.dispose();
        container = _createContainer(
          currentGame: gameTurn,
          repository: newMockRepository,
        );

        // Act
        final notifier = container.read(currentGameViewModelProvider.notifier);
        final result = await notifier.playNextAIMove();

        // Assert
        expect(result, false);
      });

      test('should return false when playerTwo is not AI', () async {
        // Arrange
        final gameTurn = testCurrentGameEntity.copyWith(oTurn: false, playerTwoId: 2);

        final newMockRepository = MockCurrentGameRepository();
        container.dispose();
        container = _createContainer(
          currentGame: gameTurn,
          repository: newMockRepository,
        );

        // Act
        final notifier = container.read(currentGameViewModelProvider.notifier);
        final result = await notifier.playNextAIMove();

        // Assert
        expect(result, false);
      });

      test('should return false when no AI move is possible (board full)', () async {
        // Arrange
        final fullBoardGame = testCurrentGameEntity.copyWith(
          oTurn: false,
          elements: ['😊', '🤖', '😊', '🤖', '😊', '🤖', '🤖', '😊', '🤖'],
        );

        final newMockRepository = MockCurrentGameRepository();
        container.dispose();
        container = _createContainer(
          currentGame: fullBoardGame,
          repository: newMockRepository,
        );

        // Act
        final notifier = container.read(currentGameViewModelProvider.notifier);
        final result = await notifier.playNextAIMove();

        // Assert
        expect(result, false);
      });
    });
  });
}
