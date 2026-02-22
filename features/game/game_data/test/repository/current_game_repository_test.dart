import 'package:flutter_test/flutter_test.dart';
import 'package:game_data/src/entity/current_game_entity.dart';
import 'package:game_data/src/repository/current_game_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tt_database/tt_database.dart';

void main() {
  setUpAll(() async {
    // Initialize test database
    final db = await databaseFactoryMemory.openDatabase('test.db');
    TripleTDatabase.setTestDatabase(db);
  });

  group('_CurrentGameRepository', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    group('get', () {
      test('returns default CurrentGameEntity when store is empty', () {
        // Arrange
        final repository = container.read(currentGameRepositoryProvider);

        // Act
        final result = repository.get();

        // Assert
        expect(result, isA<CurrentGameEntity>());
        expect(result.elements, isNotEmpty);
        expect(result.state, equals(CurrentGameState.initial));
        expect(result.oTurn, isTrue);
      });

      test('returns CurrentGameEntity with expected structure', () {
        // Arrange
        final repository = container.read(currentGameRepositoryProvider);

        // Act
        final result = repository.get();

        // Assert
        expect(result.elements.length, equals(9));
        expect(result.playerOneId, equals(2));
        expect(result.playerTwoId, equals(1));
      });
    });

    group('save', () {
      test('saves CurrentGameEntity without error', () async {
        // Arrange
        final repository = container.read(currentGameRepositoryProvider);
        final entity = CurrentGameEntity(
          elements: ['X', 'O', ''],
          state: CurrentGameState.inProgress,
          oTurn: false,
        );

        // Act & Assert - should not throw
        await expectLater(
          repository.save(entity),
          completes,
        );
      });

      test('saves entity with all fields', () async {
        // Arrange
        final repository = container.read(currentGameRepositoryProvider);
        final entity = CurrentGameEntity(
          elements: ['X', '', 'O'],
          state: CurrentGameState.playerOneWon,
          oTurn: true,
          playerOneId: 5,
          playerTwoId: 10,
          playerOneWins: 5,
          playerTwoWins: 3,
          draws: 2,
        );

        // Act & Assert - should not throw
        await expectLater(
          repository.save(entity),
          completes,
        );
      });
    });

    group('clearAll', () {
      test('clears all data from store without error', () async {
        // Arrange
        final repository = container.read(currentGameRepositoryProvider);

        // Act & Assert - should not throw
        await expectLater(
          repository.clearAll(),
          completes,
        );
      });
    });
  });
}
