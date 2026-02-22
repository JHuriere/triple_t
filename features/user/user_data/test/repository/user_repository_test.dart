import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tt_database/tt_database.dart';
import 'package:user_data/src/entity/statistics/statistics_entity.dart';
import 'package:user_data/src/entity/user_entity.dart';
import 'package:user_data/src/repository/user_repository.dart';

void main() {
  setUpAll(() async {
    // Initialize test database in memory
    final db = await databaseFactoryMemory.openDatabase('test.db');
    TripleTDatabase.setTestDatabase(db);
  });

  group('_UserRepository', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() async {
      // Clear all data after each test for isolation
      final repo = container.read(userRepositoryProvider);
      await repo.clearAll();
      container.dispose();
    });

    group('upsert', () {
      test('inserts new user with generated id', () async {
        // Arrange
        final repo = container.read(userRepositoryProvider);
        final entity = Entity<UserEntity>(
          id: 0,
          data: UserEntity(name: 'Alice', emoticon: '😀'),
        );

        // Act
        final inserted = await repo.upsert(entity);

        // Assert
        expect(inserted.id, greaterThan(0));
        expect(inserted.data.name, equals('Alice'));
        expect(inserted.data.emoticon, equals('😀'));
      });

      test('updates existing user', () async {
        // Arrange
        final repo = container.read(userRepositoryProvider);
        final entity = Entity<UserEntity>(
          id: 0,
          data: UserEntity(name: 'Alice', emoticon: '😀'),
        );
        final inserted = await repo.upsert(entity);

        // Act
        final updatedEntity = Entity<UserEntity>(
          id: inserted.id,
          data: UserEntity(name: 'Alice Updated', emoticon: '😎'),
        );
        final updated = await repo.upsert(updatedEntity);

        // Assert
        expect(updated.id, equals(inserted.id));
        expect(updated.data.name, equals('Alice Updated'));
        expect(updated.data.emoticon, equals('😎'));
      });

      test('persists user with all fields', () async {
        // Arrange
        final repo = container.read(userRepositoryProvider);
        const statistics = StatisticsEntity();
        final entity = Entity<UserEntity>(
          id: 0,
          data: UserEntity(
            name: 'Bob',
            emoticon: '🤖',
            statistics: {1: statistics},
          ),
        );

        // Act
        final inserted = await repo.upsert(entity);

        // Assert
        expect(inserted.id, greaterThan(0));
        expect(inserted.data.name, equals('Bob'));
        expect(inserted.data.statistics, isNotNull);
      });
    });

    group('get', () {
      test('returns null when user not found', () {
        // Arrange
        final repo = container.read(userRepositoryProvider);

        // Act
        final result = repo.get(999999);

        // Assert
        expect(result, isNull);
      });

      test('returns user when exists', () async {
        // Arrange
        final repo = container.read(userRepositoryProvider);
        final entity = Entity<UserEntity>(
          id: 0,
          data: UserEntity(name: 'Charlie', emoticon: '🤔'),
        );
        final inserted = await repo.upsert(entity);

        // Act
        final result = repo.get(inserted.id);

        // Assert
        expect(result, isNotNull);
        expect(result!.data.name, equals('Charlie'));
      });
    });

    group('getByName', () {
      test('returns null when no user with that name', () {
        // Arrange
        final repo = container.read(userRepositoryProvider);

        // Act
        final result = repo.getByName('NonExistent');

        // Assert
        expect(result, isNull);
      });

      test('returns user with matching name', () async {
        // Arrange
        final repo = container.read(userRepositoryProvider);
        final entity = Entity<UserEntity>(
          id: 0,
          data: UserEntity(name: 'Diana', emoticon: '🎉'),
        );
        await repo.upsert(entity);

        // Act
        final result = repo.getByName('Diana');

        // Assert
        expect(result, isNotNull);
        expect(result!.data.name, equals('Diana'));
      });
    });

    group('getByNameAndDifferentId', () {
      test('returns null when no matching user', () {
        // Arrange
        final repo = container.read(userRepositoryProvider);

        // Act
        final result = repo.getByNameAndDifferentId(1, 'NonExistent');

        // Assert
        expect(result, isNull);
      });

      test('returns user with different id', () async {
        // Arrange
        final repo = container.read(userRepositoryProvider);
        final e1 = await repo.upsert(
          Entity<UserEntity>(
            id: 0,
            data: UserEntity(name: 'Eve', emoticon: '👩'),
          ),
        );
        await repo.upsert(
          Entity<UserEntity>(
            id: 0,
            data: UserEntity(name: 'Eve', emoticon: '👩'),
          ),
        );

        // Act
        final result = repo.getByNameAndDifferentId(e1.id, 'Eve');

        // Assert
        expect(result, isNotNull);
        expect(result!.id, isNot(e1.id));
      });
    });

    group('getAll', () {
      test('returns empty list when no users', () {
        // Arrange
        final repo = container.read(userRepositoryProvider);

        // Act
        final result = repo.getAll();

        // Assert
        expect(result, isEmpty);
      });

      test('returns all users', () async {
        // Arrange
        final repo = container.read(userRepositoryProvider);
        await repo.upsert(
          Entity<UserEntity>(
            id: 0,
            data: UserEntity(name: 'U1', emoticon: '1'),
          ),
        );
        await repo.upsert(
          Entity<UserEntity>(
            id: 0,
            data: UserEntity(name: 'U2', emoticon: '2'),
          ),
        );
        await repo.upsert(
          Entity<UserEntity>(
            id: 0,
            data: UserEntity(name: 'U3', emoticon: '3'),
          ),
        );

        // Act
        final result = repo.getAll();

        // Assert
        expect(result.length, equals(3));
        final names = result.map((e) => e.data.name).toSet();
        expect(names, containsAll(['U1', 'U2', 'U3']));
      });
    });

    group('exists', () {
      test('returns false when user does not exist', () async {
        // Arrange
        final repo = container.read(userRepositoryProvider);

        // Act
        final result = await repo.exists(999999);

        // Assert
        expect(result, isFalse);
      });

      test('returns true when user exists', () async {
        // Arrange
        final repo = container.read(userRepositoryProvider);
        final entity = Entity<UserEntity>(
          id: 0,
          data: UserEntity(name: 'Frank', emoticon: '👨'),
        );
        final inserted = await repo.upsert(entity);

        // Act
        final result = await repo.exists(inserted.id);

        // Assert
        expect(result, isTrue);
      });
    });

    group('delete', () {
      test('removes user from store', () async {
        // Arrange
        final repo = container.read(userRepositoryProvider);
        final entity = Entity<UserEntity>(
          id: 0,
          data: UserEntity(name: 'Grace', emoticon: '👸'),
        );
        final inserted = await repo.upsert(entity);

        // Act
        await repo.delete(inserted.id);
        final result = repo.get(inserted.id);

        // Assert
        expect(result, isNull);
      });
    });

    group('clearAll', () {
      test('removes all users from store', () async {
        // Arrange
        final repo = container.read(userRepositoryProvider);
        await repo.upsert(
          Entity<UserEntity>(
            id: 0,
            data: UserEntity(name: 'H1', emoticon: 'h'),
          ),
        );
        await repo.upsert(
          Entity<UserEntity>(
            id: 0,
            data: UserEntity(name: 'H2', emoticon: 'h'),
          ),
        );

        // Act
        await repo.clearAll();
        final result = repo.getAll();

        // Assert
        expect(result, isEmpty);
      });
    });
  });
}
