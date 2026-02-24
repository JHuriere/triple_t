import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/src/entity/current_game_entity.dart';
import 'package:game_domain/src/repository/get_current_game_repository.dart';
import 'package:game_domain/src/use_case/get_current_game_use_case.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';

import '../repository/mock_current_game_repository.dart';

void main() {
  group('GetCurrentGameUseCase', () {
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

    test('should return current game entity from repository', () {
      // Arrange
      const expectedEntity = CurrentGameEntity(
        elements: ['X', 'O', '', '', '', '', '', '', ''],
        state: CurrentGameState.inProgress,
        oTurn: false,
        playerOneId: 5,
        playerTwoId: 3,
      );

      when(mockRepository.get()).thenReturn(expectedEntity);

      // Act
      final result = container.read(getCurrentGameUseCaseProvider);

      // Assert
      expect(result, expectedEntity);
      verify(mockRepository.get()).called(1);
    });

    test('should return default game entity when repository returns default', () {
      // Arrange
      const defaultEntity = CurrentGameEntity();

      when(mockRepository.get()).thenReturn(defaultEntity);

      // Act
      final result = container.read(getCurrentGameUseCaseProvider);

      // Assert
      expect(result, defaultEntity);
      expect(result.elements, ['', '', '', '', '', '', '', '', '']);
      expect(result.state, CurrentGameState.initial);
      expect(result.oTurn, true);
      verify(mockRepository.get()).called(1);
    });

    test('should call repository each time provider is read', () {
      // Arrange
      const entity = CurrentGameEntity();

      when(mockRepository.get()).thenReturn(entity);

      // Act
      container.read(getCurrentGameUseCaseProvider);

      // Create a new container to read again
      final container2 = ProviderContainer(
        overrides: [
          getCurrentGameRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );
      container2.read(getCurrentGameUseCaseProvider);

      // Assert
      verify(mockRepository.get()).called(2);

      // Cleanup
      container2.dispose();
    });
  });
}
