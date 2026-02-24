import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/src/entity/current_game_entity.dart';
import 'package:game_domain/src/repository/get_current_game_repository.dart';
import 'package:game_domain/src/use_case/update_current_game_player_use_case.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';

import '../repository/mock_current_game_repository.dart';

void main() {
  group('UpdateCurrentGamePlayerUseCase', () {
    late MockCurrentGameRepository mockRepository;
    late ProviderContainer container;

    setUp(() {
      mockRepository = MockCurrentGameRepository();
      container = ProviderContainer(
        overrides: [
          getCurrentGameRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('should update player one ID and reset scores', () async {
      // Arrange
      const currentGame = CurrentGameEntity(
        playerOneId: 2,
        playerTwoId: 1,
        playerOneWins: 5,
        playerTwoWins: 3,
        draws: 2,
      );

      const expectedGame = CurrentGameEntity(
        playerOneId: 10,
        playerTwoId: 1,
        playerOneWins: 0,
        playerTwoWins: 0,
        draws: 0,
      );

      when(mockRepository.get()).thenReturn(currentGame);
      when(mockRepository.save(argThat(isA<CurrentGameEntity>()))).thenAnswer((_) async => expectedGame);

      // Act
      await container.read(
        updateCurrentGamePlayerUseCaseProvider(playerOneId: 10).future,
      );

      // Assert
      final captured = verify(mockRepository.save(captureAny)).captured.single as CurrentGameEntity;
      expect(captured.playerOneId, 10);
      expect(captured.playerTwoId, 1);
      expect(captured.playerOneWins, 0);
      expect(captured.playerTwoWins, 0);
      expect(captured.draws, 0);
    });

    test('should update player two ID and reset scores', () async {
      // Arrange
      const currentGame = CurrentGameEntity(
        playerOneId: 2,
        playerTwoId: 1,
        playerOneWins: 5,
        playerTwoWins: 3,
        draws: 2,
      );

      const expectedGame = CurrentGameEntity(
        playerOneId: 2,
        playerTwoId: 20,
        playerOneWins: 0,
        playerTwoWins: 0,
        draws: 0,
      );

      when(mockRepository.get()).thenReturn(currentGame);
      when(mockRepository.save(argThat(isA<CurrentGameEntity>()))).thenAnswer((_) async => expectedGame);

      // Act
      await container.read(
        updateCurrentGamePlayerUseCaseProvider(playerTwoId: 20).future,
      );

      // Assert
      final captured = verify(mockRepository.save(captureAny)).captured.single as CurrentGameEntity;
      expect(captured.playerOneId, 2);
      expect(captured.playerTwoId, 20);
      expect(captured.playerOneWins, 0);
      expect(captured.playerTwoWins, 0);
      expect(captured.draws, 0);
    });

    test('should update both player IDs and reset scores', () async {
      // Arrange
      const currentGame = CurrentGameEntity(
        playerOneId: 2,
        playerTwoId: 1,
        playerOneWins: 5,
        playerTwoWins: 3,
        draws: 2,
      );

      const expectedGame = CurrentGameEntity(
        playerOneId: 10,
        playerTwoId: 20,
        playerOneWins: 0,
        playerTwoWins: 0,
        draws: 0,
      );

      when(mockRepository.get()).thenReturn(currentGame);
      when(mockRepository.save(argThat(isA<CurrentGameEntity>()))).thenAnswer((_) async => expectedGame);

      // Act
      await container.read(
        updateCurrentGamePlayerUseCaseProvider(playerOneId: 10, playerTwoId: 20).future,
      );

      // Assert
      final captured = verify(mockRepository.save(captureAny)).captured.single as CurrentGameEntity;
      expect(captured.playerOneId, 10);
      expect(captured.playerTwoId, 20);
      expect(captured.playerOneWins, 0);
      expect(captured.playerTwoWins, 0);
      expect(captured.draws, 0);
    });

    test('should not update player IDs when both are null', () async {
      // Arrange
      const currentGame = CurrentGameEntity(
        playerOneId: 2,
        playerTwoId: 1,
        playerOneWins: 5,
        playerTwoWins: 3,
        draws: 2,
      );

      const expectedGame = CurrentGameEntity(
        playerOneId: 2,
        playerTwoId: 1,
        playerOneWins: 0,
        playerTwoWins: 0,
        draws: 0,
      );

      when(mockRepository.get()).thenReturn(currentGame);
      when(mockRepository.save(argThat(isA<CurrentGameEntity>()))).thenAnswer((_) async => expectedGame);

      // Act
      await container.read(
        updateCurrentGamePlayerUseCaseProvider().future,
      );

      // Assert
      final captured = verify(mockRepository.save(captureAny)).captured.single as CurrentGameEntity;
      expect(captured.playerOneId, 2);
      expect(captured.playerTwoId, 1);
      expect(captured.playerOneWins, 0);
      expect(captured.playerTwoWins, 0);
      expect(captured.draws, 0);
    });

    test('should preserve game state and elements when updating players', () async {
      // Arrange
      const currentGame = CurrentGameEntity(
        elements: ['X', 'O', 'X', '', '', '', '', '', ''],
        state: CurrentGameState.inProgress,
        oTurn: false,
        playerOneId: 2,
        playerTwoId: 1,
        playerOneWins: 5,
        playerTwoWins: 3,
        draws: 2,
      );

      const expectedGame = CurrentGameEntity(
        elements: ['X', 'O', 'X', '', '', '', '', '', ''],
        state: CurrentGameState.inProgress,
        oTurn: false,
        playerOneId: 10,
        playerTwoId: 1,
        playerOneWins: 0,
        playerTwoWins: 0,
        draws: 0,
      );

      when(mockRepository.get()).thenReturn(currentGame);
      when(mockRepository.save(argThat(isA<CurrentGameEntity>()))).thenAnswer((_) async => expectedGame);

      // Act
      await container.read(
        updateCurrentGamePlayerUseCaseProvider(playerOneId: 10).future,
      );

      // Assert
      final captured = verify(mockRepository.save(captureAny)).captured.single as CurrentGameEntity;
      expect(captured.elements, ['X', 'O', 'X', '', '', '', '', '', '']);
      expect(captured.state, CurrentGameState.inProgress);
      expect(captured.oTurn, false);
    });

    test('should always reset scores to zero when updating players', () async {
      // Arrange
      const currentGame = CurrentGameEntity(
        playerOneId: 5,
        playerTwoId: 3,
        playerOneWins: 100,
        playerTwoWins: 200,
        draws: 50,
      );

      const expectedGame = CurrentGameEntity(
        playerOneId: 10,
        playerTwoId: 3,
        playerOneWins: 0,
        playerTwoWins: 0,
        draws: 0,
      );

      when(mockRepository.get()).thenReturn(currentGame);
      when(mockRepository.save(argThat(isA<CurrentGameEntity>()))).thenAnswer((_) async => expectedGame);

      // Act
      await container.read(
        updateCurrentGamePlayerUseCaseProvider(playerOneId: 10).future,
      );

      // Assert
      final captured = verify(mockRepository.save(captureAny)).captured.single as CurrentGameEntity;
      expect(captured.playerOneWins, 0);
      expect(captured.playerTwoWins, 0);
      expect(captured.draws, 0);
    });

    test('should call repository get and save', () async {
      // Arrange
      const currentGame = CurrentGameEntity();

      when(mockRepository.get()).thenReturn(currentGame);
      when(mockRepository.save(argThat(isA<CurrentGameEntity>()))).thenAnswer((_) async => currentGame);

      // Act
      await container.read(
        updateCurrentGamePlayerUseCaseProvider(playerOneId: 10).future,
      );

      // Assert
      verify(mockRepository.get()).called(1);
      verify(mockRepository.save(argThat(isA<CurrentGameEntity>()))).called(1);
    });
  });
}
