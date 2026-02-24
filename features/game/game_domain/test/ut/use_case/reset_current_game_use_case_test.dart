import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/src/entity/current_game_entity.dart';
import 'package:game_domain/src/repository/get_current_game_repository.dart';
import 'package:game_domain/src/use_case/reset_current_game_use_case.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';

import '../repository/mock_current_game_repository.dart';

void main() {
  group('ResetCurrentGameUseCase', () {
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

    test('should reset game to initial state', () async {
      // Arrange
      const currentGame = CurrentGameEntity(
        elements: ['X', 'O', 'X', 'O', 'X', 'O', 'X', 'O', 'X'],
        state: CurrentGameState.playerOneWon,
        oTurn: false,
        playerOneId: 5,
        playerTwoId: 3,
        playerOneWins: 3,
        playerTwoWins: 2,
        draws: 1,
      );

      const expectedResetGame = CurrentGameEntity(
        elements: ['', '', '', '', '', '', '', '', ''],
        state: CurrentGameState.initial,
        oTurn: true,
        playerOneId: 5,
        playerTwoId: 3,
        playerOneWins: 3,
        playerTwoWins: 2,
        draws: 1,
      );

      when(mockRepository.get()).thenReturn(currentGame);
      when(mockRepository.save(argThat(isA<CurrentGameEntity>()))).thenAnswer((_) async => expectedResetGame);

      // Act
      await container.read(resetCurrentGameUseCaseProvider.future);

      // Assert
      final captured = verify(mockRepository.save(captureAny)).captured.single as CurrentGameEntity;
      expect(captured.elements, ['', '', '', '', '', '', '', '', '']);
      expect(captured.state, CurrentGameState.initial);
      expect(captured.oTurn, true);
      expect(captured.playerOneId, 5);
      expect(captured.playerTwoId, 3);
      expect(captured.playerOneWins, 3);
      expect(captured.playerTwoWins, 2);
      expect(captured.draws, 1);
    });

    test('should reset game from initial state', () async {
      // Arrange
      const currentGame = CurrentGameEntity();

      const expectedResetGame = CurrentGameEntity(
        elements: ['', '', '', '', '', '', '', '', ''],
        state: CurrentGameState.initial,
        oTurn: true,
      );

      when(mockRepository.get()).thenReturn(currentGame);
      when(mockRepository.save(argThat(isA<CurrentGameEntity>()))).thenAnswer((_) async => expectedResetGame);

      // Act
      await container.read(resetCurrentGameUseCaseProvider.future);

      // Assert
      final captured = verify(mockRepository.save(captureAny)).captured.single as CurrentGameEntity;
      expect(captured.elements, ['', '', '', '', '', '', '', '', '']);
      expect(captured.state, CurrentGameState.initial);
      expect(captured.oTurn, true);
    });

    test('should reset game from in progress state', () async {
      // Arrange
      const currentGame = CurrentGameEntity(
        elements: ['X', 'O', 'X', '', '', '', '', '', ''],
        state: CurrentGameState.inProgress,
        oTurn: false,
      );

      const expectedResetGame = CurrentGameEntity(
        elements: ['', '', '', '', '', '', '', '', ''],
        state: CurrentGameState.initial,
        oTurn: true,
      );

      when(mockRepository.get()).thenReturn(currentGame);
      when(mockRepository.save(argThat(isA<CurrentGameEntity>()))).thenAnswer((_) async => expectedResetGame);

      // Act
      await container.read(resetCurrentGameUseCaseProvider.future);

      // Assert
      final captured = verify(mockRepository.save(captureAny)).captured.single as CurrentGameEntity;
      expect(captured.elements, ['', '', '', '', '', '', '', '', '']);
      expect(captured.state, CurrentGameState.initial);
      expect(captured.oTurn, true);
    });

    test('should preserve player IDs when resetting', () async {
      // Arrange
      const currentGame = CurrentGameEntity(
        elements: ['X', 'O', 'X', 'O', 'X', 'O', 'X', 'O', 'X'],
        state: CurrentGameState.draw,
        playerOneId: 10,
        playerTwoId: 20,
      );

      when(mockRepository.get()).thenReturn(currentGame);
      when(mockRepository.save(argThat(isA<CurrentGameEntity>()))).thenAnswer((_) async => currentGame);

      // Act
      await container.read(resetCurrentGameUseCaseProvider.future);

      // Assert
      final captured = verify(mockRepository.save(captureAny)).captured.single as CurrentGameEntity;
      expect(captured.playerOneId, 10);
      expect(captured.playerTwoId, 20);
    });

    test('should call repository get and save', () async {
      // Arrange
      const currentGame = CurrentGameEntity();

      when(mockRepository.get()).thenReturn(currentGame);
      when(mockRepository.save(argThat(isA<CurrentGameEntity>()))).thenAnswer((_) async => currentGame);

      // Act
      await container.read(resetCurrentGameUseCaseProvider.future);

      // Assert
      verify(mockRepository.get()).called(1);
      verify(mockRepository.save(argThat(isA<CurrentGameEntity>()))).called(1);
    });
  });
}
