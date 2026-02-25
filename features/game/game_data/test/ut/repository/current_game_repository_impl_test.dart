import 'package:flutter_test/flutter_test.dart';
import 'package:game_data/game_data.dart';
import 'package:game_data/src/model/current_game_model.dart';
import 'package:game_domain/game_domain.dart';
import 'package:tt_database/tt_database.dart';

void main() {
  setUpAll(() async {
    final db = await databaseFactoryMemory.openDatabase('test.db');
    TripleTDatabase.setTestDatabase(db);
  });

  group('CurrentGameRepositoryImpl & CurrentGameDataSourceImpl', () {
    late CurrentGameDataSourceImpl dataSource;
    late CurrentGameRepositoryImpl currentGameRepository;
    late Database testDatabase;

    setUp(() async {
      testDatabase = TripleTDatabase.instance.db;
      dataSource = CurrentGameDataSourceImpl(db: testDatabase);
      currentGameRepository = CurrentGameRepositoryImpl(dataSource: dataSource);
    });

    tearDown(() async {
      await currentGameRepository.clearAll();
    });

    group('get', () {
      test('should return default settings when none exist', () {
        // Act
        final result = currentGameRepository.get();

        // Assert
        expect(result, isA<CurrentGameEntity>());
        expect(result, equals(const CurrentGameEntity()));
      });

      test('should return CurrentGameEntity when settings exist', () async {
        // Arrange
        const settings = CurrentGameEntity(
          elements: ['X', 'O', 'X', '', '', '', '', '', ''],
          state: CurrentGameState.inProgress,
          oTurn: false,
          playerOneId: 10,
          playerTwoId: 20,
          playerOneWins: 2,
          playerTwoWins: 1,
          draws: 3,
        );

        final store = stringMapStoreFactory.store(CurrentGameDataSourceImpl.storeName);
        await store.record(CurrentGameDataSourceImpl.settingsKey).put(testDatabase, CurrentGameModel.fromEntity(settings).toJson());

        // Act
        final result = currentGameRepository.get();

        // Assert
        expect(result, equals(settings));
      });
    });

    group('save', () {
      test('should persist and return updated settings', () async {
        // Arrange
        const settings = CurrentGameEntity(
          elements: ['O', 'O', 'X', '', '', '', '', '', ''],
          state: CurrentGameState.inProgress,
          oTurn: true,
          playerOneId: 7,
          playerTwoId: 8,
          playerOneWins: 1,
          playerTwoWins: 0,
          draws: 2,
        );

        // Act
        final result = await currentGameRepository.save(settings);

        // Assert
        expect(result, equals(settings));

        final store = stringMapStoreFactory.store(CurrentGameDataSourceImpl.storeName);
        final stored = await store.record(CurrentGameDataSourceImpl.settingsKey).get(testDatabase);
        expect(stored, isNotNull);
        expect(CurrentGameModel.fromJson(stored!.cast<String, dynamic>()).toEntity(), equals(settings));
      });
    });

    group('clearAll', () {
      test('should clear all settings', () async {
        // Arrange
        const settings = CurrentGameEntity(
          elements: ['X', 'O', '', '', '', '', '', '', ''],
          state: CurrentGameState.inProgress,
        );

        final store = stringMapStoreFactory.store(CurrentGameDataSourceImpl.storeName);
        await store.record(CurrentGameDataSourceImpl.settingsKey).put(testDatabase, CurrentGameModel.fromEntity(settings).toJson());

        // Verify data exists
        expect(currentGameRepository.get(), equals(settings));

        // Act
        await currentGameRepository.clearAll();

        // Assert
        expect(currentGameRepository.get(), equals(const CurrentGameEntity()));
      });
    });
  });
}
