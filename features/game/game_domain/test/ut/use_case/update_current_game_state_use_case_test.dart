import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/src/entity/current_game_entity.dart';
import 'package:game_domain/src/repository/get_current_game_repository.dart';
import 'package:game_domain/src/use_case/update_current_game_state_use_case.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';

import '../repository/mock_current_game_repository.dart';

void main() {
  group('UpdateCurrentGameStateUseCase', () {
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

    test('should update state to playerOneWon and increment playerOneWins', () async {
      // Arrange
      const currentGame = CurrentGameEntity(
        state: CurrentGameState.inProgress,
        playerOneWins: 2,
        playerTwoWins: 1,
        draws: 0,
      );

      const expectedGame = CurrentGameEntity(
        state: CurrentGameState.playerOneWon,
        playerOneWins: 3,
        playerTwoWins: 1,
        draws: 0,
      );

      when(mockRepository.get()).thenReturn(currentGame);
      when(mockRepository.save(argThat(isA<CurrentGameEntity>()))).thenAnswer((_) async => expectedGame);

      // Act
      await container.read(
        updateCurrentGameStateUseCaseProvider(state: CurrentGameState.playerOneWon).future,
      );

      // Assert
      final captured = verify(mockRepository.save(captureAny)).captured.single as CurrentGameEntity;
      expect(captured.state, CurrentGameState.playerOneWon);
      expect(captured.playerOneWins, 3);
      expect(captured.playerTwoWins, 1);
      expect(captured.draws, 0);
    });

    test('should update state to playerTwoWon and increment playerTwoWins', () async {
      // Arrange
      const currentGame = CurrentGameEntity(
        state: CurrentGameState.inProgress,
        playerOneWins: 2,
        playerTwoWins: 1,
        draws: 0,
      );

      const expectedGame = CurrentGameEntity(
        state: CurrentGameState.playerTwoWon,
        playerOneWins: 2,
        playerTwoWins: 2,
        draws: 0,
      );

      when(mockRepository.get()).thenReturn(currentGame);
      when(mockRepository.save(argThat(isA<CurrentGameEntity>()))).thenAnswer((_) async => expectedGame);

      // Act
      await container.read(
        updateCurrentGameStateUseCaseProvider(state: CurrentGameState.playerTwoWon).future,
      );

      // Assert
      final captured = verify(mockRepository.save(captureAny)).captured.single as CurrentGameEntity;
      expect(captured.state, CurrentGameState.playerTwoWon);
      expect(captured.playerOneWins, 2);
      expect(captured.playerTwoWins, 2);
      expect(captured.draws, 0);
    });

    test('should update state to draw and increment draws', () async {
      // Arrange
      const currentGame = CurrentGameEntity(
        state: CurrentGameState.inProgress,
        playerOneWins: 2,
        playerTwoWins: 1,
        draws: 0,
      );

      const expectedGame = CurrentGameEntity(
        state: CurrentGameState.draw,
        playerOneWins: 2,
        playerTwoWins: 1,
        draws: 1,
      );

      when(mockRepository.get()).thenReturn(currentGame);
      when(mockRepository.save(argThat(isA<CurrentGameEntity>()))).thenAnswer((_) async => expectedGame);

      // Act
      await container.read(
        updateCurrentGameStateUseCaseProvider(state: CurrentGameState.draw).future,
      );

      // Assert
      final captured = verify(mockRepository.save(captureAny)).captured.single as CurrentGameEntity;
      expect(captured.state, CurrentGameState.draw);
      expect(captured.playerOneWins, 2);
      expect(captured.playerTwoWins, 1);
      expect(captured.draws, 1);
    });

    test('should update state to inProgress without incrementing any score', () async {
      // Arrange
      const currentGame = CurrentGameEntity(
        state: CurrentGameState.initial,
        playerOneWins: 2,
        playerTwoWins: 1,
        draws: 0,
      );

      const expectedGame = CurrentGameEntity(
        state: CurrentGameState.inProgress,
        playerOneWins: 2,
        playerTwoWins: 1,
        draws: 0,
      );

      when(mockRepository.get()).thenReturn(currentGame);
      when(mockRepository.save(argThat(isA<CurrentGameEntity>()))).thenAnswer((_) async => expectedGame);

      // Act
      await container.read(
        updateCurrentGameStateUseCaseProvider(state: CurrentGameState.inProgress).future,
      );

      // Assert
      final captured = verify(mockRepository.save(captureAny)).captured.single as CurrentGameEntity;
      expect(captured.state, CurrentGameState.inProgress);
      expect(captured.playerOneWins, 2);
      expect(captured.playerTwoWins, 1);
      expect(captured.draws, 0);
    });

    test('should update state to initial without incrementing any score', () async {
      // Arrange
      const currentGame = CurrentGameEntity(
        state: CurrentGameState.playerOneWon,
        playerOneWins: 2,
        playerTwoWins: 1,
        draws: 0,
      );

      const expectedGame = CurrentGameEntity(
        state: CurrentGameState.initial,
        playerOneWins: 2,
        playerTwoWins: 1,
        draws: 0,
      );

      when(mockRepository.get()).thenReturn(currentGame);
      when(mockRepository.save(argThat(isA<CurrentGameEntity>()))).thenAnswer((_) async => expectedGame);

      // Act
      await container.read(
        updateCurrentGameStateUseCaseProvider(state: CurrentGameState.initial).future,
      );

      // Assert
      final captured = verify(mockRepository.save(captureAny)).captured.single as CurrentGameEntity;
      expect(captured.state, CurrentGameState.initial);
      expect(captured.playerOneWins, 2);
      expect(captured.playerTwoWins, 1);
      expect(captured.draws, 0);
    });

    test('should preserve other properties when updating state', () async {
      // Arrange
      const currentGame = CurrentGameEntity(
        elements: ['X', 'O', 'X', 'O', 'X', 'O', 'X', '', ''],
        state: CurrentGameState.inProgress,
        oTurn: false,
        playerOneId: 10,
        playerTwoId: 20,
        playerOneWins: 5,
        playerTwoWins: 3,
        draws: 2,
      );

      const expectedGame = CurrentGameEntity(
        elements: ['X', 'O', 'X', 'O', 'X', 'O', 'X', '', ''],
        state: CurrentGameState.playerOneWon,
        oTurn: false,
        playerOneId: 10,
        playerTwoId: 20,
        playerOneWins: 6,
        playerTwoWins: 3,
        draws: 2,
      );

      when(mockRepository.get()).thenReturn(currentGame);
      when(mockRepository.save(argThat(isA<CurrentGameEntity>()))).thenAnswer((_) async => expectedGame);

      // Act
      await container.read(
        updateCurrentGameStateUseCaseProvider(state: CurrentGameState.playerOneWon).future,
      );

      // Assert
      final captured = verify(mockRepository.save(captureAny)).captured.single as CurrentGameEntity;
      expect(captured.elements, ['X', 'O', 'X', 'O', 'X', 'O', 'X', '', '']);
      expect(captured.oTurn, false);
      expect(captured.playerOneId, 10);
      expect(captured.playerTwoId, 20);
    });

    test('should handle multiple wins for player one', () async {
      // Arrange
      const currentGame = CurrentGameEntity(
        state: CurrentGameState.inProgress,
        playerOneWins: 99,
        playerTwoWins: 50,
        draws: 25,
      );

      const expectedGame = CurrentGameEntity(
        state: CurrentGameState.playerOneWon,
        playerOneWins: 100,
        playerTwoWins: 50,
        draws: 25,
      );

      when(mockRepository.get()).thenReturn(currentGame);
      when(mockRepository.save(argThat(isA<CurrentGameEntity>()))).thenAnswer((_) async => expectedGame);

      // Act
      await container.read(
        updateCurrentGameStateUseCaseProvider(state: CurrentGameState.playerOneWon).future,
      );

      // Assert
      final captured = verify(mockRepository.save(captureAny)).captured.single as CurrentGameEntity;
      expect(captured.playerOneWins, 100);
    });

    test('should handle multiple draws', () async {
      // Arrange
      const currentGame = CurrentGameEntity(
        state: CurrentGameState.inProgress,
        playerOneWins: 10,
        playerTwoWins: 10,
        draws: 19,
      );

      const expectedGame = CurrentGameEntity(
        state: CurrentGameState.draw,
        playerOneWins: 10,
        playerTwoWins: 10,
        draws: 20,
      );

      when(mockRepository.get()).thenReturn(currentGame);
      when(mockRepository.save(argThat(isA<CurrentGameEntity>()))).thenAnswer((_) async => expectedGame);

      // Act
      await container.read(
        updateCurrentGameStateUseCaseProvider(state: CurrentGameState.draw).future,
      );

      // Assert
      final captured = verify(mockRepository.save(captureAny)).captured.single as CurrentGameEntity;
      expect(captured.draws, 20);
    });

    test('should call repository get and save', () async {
      // Arrange
      const currentGame = CurrentGameEntity();

      when(mockRepository.get()).thenReturn(currentGame);
      when(mockRepository.save(argThat(isA<CurrentGameEntity>()))).thenAnswer((_) async => currentGame);

      // Act
      await container.read(
        updateCurrentGameStateUseCaseProvider(state: CurrentGameState.initial).future,
      );

      // Assert
      verify(mockRepository.get()).called(1);
      verify(mockRepository.save(argThat(isA<CurrentGameEntity>()))).called(1);
    });
  });
}
