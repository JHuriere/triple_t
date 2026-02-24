import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/src/entity/current_game_entity.dart';
import 'package:game_domain/src/repository/get_current_game_repository.dart';
import 'package:game_domain/src/use_case/update_current_game_elements_use_case.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';

import '../repository/mock_current_game_repository.dart';

void main() {
  group('UpdateCurrentGameElementsUseCase', () {
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

    test('should update elements and toggle turn', () async {
      // Arrange
      const currentGame = CurrentGameEntity(
        elements: ['', '', '', '', '', '', '', '', ''],
        state: CurrentGameState.initial,
        oTurn: true,
      );

      final newElements = ['X', '', '', '', '', '', '', '', ''];

      const expectedGame = CurrentGameEntity(
        elements: ['X', '', '', '', '', '', '', '', ''],
        state: CurrentGameState.inProgress,
        oTurn: false,
      );

      when(mockRepository.get()).thenReturn(currentGame);
      when(mockRepository.save(argThat(isA<CurrentGameEntity>()))).thenAnswer((_) async => expectedGame);

      // Act
      final result = await container.read(
        updateCurrentGameElementsUseCaseProvider(elements: newElements).future,
      );

      // Assert
      expect(result.elements, newElements);
      expect(result.state, CurrentGameState.inProgress);
      expect(result.oTurn, false);

      final captured = verify(mockRepository.save(captureAny)).captured.single as CurrentGameEntity;
      expect(captured.elements, newElements);
      expect(captured.oTurn, false);
      expect(captured.state, CurrentGameState.inProgress);
    });

    test('should update elements and toggle turn from false to true', () async {
      // Arrange
      const currentGame = CurrentGameEntity(
        elements: ['X', '', '', '', '', '', '', '', ''],
        state: CurrentGameState.inProgress,
        oTurn: false,
      );

      final newElements = ['X', 'O', '', '', '', '', '', '', ''];

      const expectedGame = CurrentGameEntity(
        elements: ['X', 'O', '', '', '', '', '', '', ''],
        state: CurrentGameState.inProgress,
        oTurn: true,
      );

      when(mockRepository.get()).thenReturn(currentGame);
      when(mockRepository.save(argThat(isA<CurrentGameEntity>()))).thenAnswer((_) async => expectedGame);

      // Act
      final result = await container.read(
        updateCurrentGameElementsUseCaseProvider(elements: newElements).future,
      );

      // Assert
      expect(result.elements, newElements);
      expect(result.oTurn, true);

      final captured = verify(mockRepository.save(captureAny)).captured.single as CurrentGameEntity;
      expect(captured.oTurn, true);
    });

    test('should set state to inProgress when updating elements', () async {
      // Arrange
      const currentGame = CurrentGameEntity(
        state: CurrentGameState.initial,
      );

      final newElements = ['X', '', '', '', '', '', '', '', ''];

      const expectedGame = CurrentGameEntity(
        elements: ['X', '', '', '', '', '', '', '', ''],
        state: CurrentGameState.inProgress,
        oTurn: false,
      );

      when(mockRepository.get()).thenReturn(currentGame);
      when(mockRepository.save(argThat(isA<CurrentGameEntity>()))).thenAnswer((_) async => expectedGame);

      // Act
      final result = await container.read(
        updateCurrentGameElementsUseCaseProvider(elements: newElements).future,
      );

      // Assert
      expect(result.state, CurrentGameState.inProgress);
    });

    test('should update elements with multiple moves', () async {
      // Arrange
      const currentGame = CurrentGameEntity(
        elements: ['X', 'O', 'X', '', '', '', '', '', ''],
        state: CurrentGameState.inProgress,
        oTurn: false,
      );

      final newElements = ['X', 'O', 'X', 'O', '', '', '', '', ''];

      const expectedGame = CurrentGameEntity(
        elements: ['X', 'O', 'X', 'O', '', '', '', '', ''],
        state: CurrentGameState.inProgress,
        oTurn: true,
      );

      when(mockRepository.get()).thenReturn(currentGame);
      when(mockRepository.save(argThat(isA<CurrentGameEntity>()))).thenAnswer((_) async => expectedGame);

      // Act
      final result = await container.read(
        updateCurrentGameElementsUseCaseProvider(elements: newElements).future,
      );

      // Assert
      expect(result.elements, newElements);
    });

    test('should preserve player IDs and scores when updating elements', () async {
      // Arrange
      const currentGame = CurrentGameEntity(
        elements: ['', '', '', '', '', '', '', '', ''],
        playerOneId: 10,
        playerTwoId: 20,
        playerOneWins: 5,
        playerTwoWins: 3,
        draws: 2,
      );

      final newElements = ['X', '', '', '', '', '', '', '', ''];

      const expectedGame = CurrentGameEntity(
        elements: ['X', '', '', '', '', '', '', '', ''],
        state: CurrentGameState.inProgress,
        oTurn: false,
        playerOneId: 10,
        playerTwoId: 20,
        playerOneWins: 5,
        playerTwoWins: 3,
        draws: 2,
      );

      when(mockRepository.get()).thenReturn(currentGame);
      when(mockRepository.save(argThat(isA<CurrentGameEntity>()))).thenAnswer((_) async => expectedGame);

      // Act
      final result = await container.read(
        updateCurrentGameElementsUseCaseProvider(elements: newElements).future,
      );

      // Assert
      expect(result.playerOneId, 10);
      expect(result.playerTwoId, 20);
      expect(result.playerOneWins, 5);
      expect(result.playerTwoWins, 3);
      expect(result.draws, 2);
    });

    test('should call repository get and save', () async {
      // Arrange
      const currentGame = CurrentGameEntity();
      final newElements = ['X', '', '', '', '', '', '', '', ''];

      when(mockRepository.get()).thenReturn(currentGame);
      when(mockRepository.save(argThat(isA<CurrentGameEntity>()))).thenAnswer((_) async => currentGame);

      // Act
      await container.read(
        updateCurrentGameElementsUseCaseProvider(elements: newElements).future,
      );

      // Assert
      verify(mockRepository.get()).called(1);
      verify(mockRepository.save(argThat(isA<CurrentGameEntity>()))).called(1);
    });
  });
}
