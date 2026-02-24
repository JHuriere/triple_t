import 'package:flutter_test/flutter_test.dart';
import 'package:tt_database/tt_database.dart';
import 'package:user_data/src/repository/user_repository_impl.dart';
import 'package:user_domain/src/entity/user_entity.dart';
import 'package:user_domain/src/repository/user_repository.dart';

void main() {
  setUpAll(() async {
    final db = await databaseFactoryMemory.openDatabase('test.db');
    TripleTDatabase.setTestDatabase(db);
  });

  group('UserRepositoryImpl', () {
    late UserRepositoryImpl userRepository;
    late Database testDatabase;

    setUp(() async {
      testDatabase = TripleTDatabase.instance.db;
      userRepository = UserRepositoryImpl();
    });

    tearDown(() async {
      await userRepository.clearAll();
    });

    group('exists', () {
      test('should return true when user exists', () async {
        // Arrange
        const userId = 1;
        final user = UserEntity(
          id: userId,
          name: 'Test User',
          emoticon: '😊',
          statistics: const {},
        );

        final store = intMapStoreFactory.store(UserRepository.storeName);
        await store.record(userId).put(testDatabase, user.toJson());

        // Act
        final result = await userRepository.exists(userId);

        // Assert
        expect(result, isTrue);
      });

      test('should return false when user does not exist', () async {
        // Arrange
        const userId = 999;

        // Act
        final result = await userRepository.exists(userId);

        // Assert
        expect(result, isFalse);
      });
    });

    group('get', () {
      test('should return UserEntity when user exists', () async {
        // Arrange
        const userId = 1;
        final testUser = UserEntity(
          id: userId,
          name: 'Test User',
          emoticon: '😊',
          statistics: const {},
        );

        final store = intMapStoreFactory.store(UserRepository.storeName);
        await store.record(userId).put(testDatabase, testUser.toJson());

        // Act
        final result = userRepository.get(userId);

        // Assert
        expect(result, isNotNull);
        expect(result?.name, equals('Test User'));
        expect(result?.emoticon, equals('😊'));
      });

      test('should return null when user does not exist', () async {
        // Arrange
        const userId = 999;

        // Act
        final result = userRepository.get(userId);

        // Assert
        expect(result, isNull);
      });
    });

    group('getByName', () {
      test('should return UserEntity when user with name exists', () async {
        // Arrange
        const userName = 'Test User';
        final testUser = UserEntity(
          id: 1,
          name: userName,
          emoticon: '😊',
          statistics: const {},
        );

        final store = intMapStoreFactory.store(UserRepository.storeName);
        await store.record(1).put(testDatabase, testUser.toJson());

        // Act
        final result = userRepository.getByName(userName);

        // Assert
        expect(result, isNotNull);
        expect(result?.name, equals(userName));
      });

      test('should return null when user with name does not exist', () async {
        // Arrange
        const userName = 'Non Existent User';

        // Act
        final result = userRepository.getByName(userName);

        // Assert
        expect(result, isNull);
      });
    });

    group('getByNameAndDifferentId', () {
      test('should return UserEntity when user with different id and same name exists', () async {
        // Arrange
        const userId = 1;
        const userName = 'Test User';
        final testUser = UserEntity(
          id: 2,
          name: userName,
          emoticon: '😊',
          statistics: const {},
        );

        final store = intMapStoreFactory.store(UserRepository.storeName);
        await store.record(2).put(testDatabase, testUser.toJson());

        // Act
        final result = userRepository.getByNameAndDifferentId(userId, userName);

        // Assert
        expect(result, isNotNull);
        expect(result?.name, equals(userName));
        expect(result?.id, equals(2));
      });

      test('should return null when no user with name and different id exists', () async {
        // Arrange
        const userId = 1;
        const userName = 'Non Existent User';

        // Act
        final result = userRepository.getByNameAndDifferentId(userId, userName);

        // Assert
        expect(result, isNull);
      });
    });

    group('getAll', () {
      test('should return empty list when no users exist', () async {
        // Act
        final result = userRepository.getAll();

        // Assert
        expect(result, isEmpty);
      });

      test('should return list of UserEntity when users exist', () async {
        // Arrange
        final testUsers = [
          const UserEntity(id: 1, name: 'User 1', emoticon: '😊', statistics: {}),
          const UserEntity(id: 2, name: 'User 2', emoticon: '🎮', statistics: {}),
        ];

        final store = intMapStoreFactory.store(UserRepository.storeName);
        for (final user in testUsers) {
          await store.record(user.id).put(testDatabase, user.toJson());
        }

        // Act
        final result = userRepository.getAll();

        // Assert
        expect(result, isA<List<UserEntity>>());
        expect(result.length, equals(2));
        expect(result[0].name, equals('User 1'));
        expect(result[1].name, equals('User 2'));
      });
    });

    group('upsert', () {
      test('should update existing user when user exists', () async {
        // Arrange
        final testUser = UserEntity(
          id: 1,
          name: 'Original User',
          emoticon: '😊',
          statistics: const {},
        );

        final store = intMapStoreFactory.store(UserRepository.storeName);
        await store.record(1).put(testDatabase, testUser.toJson());

        final updatedUser = UserEntity(
          id: 1,
          name: 'Updated User',
          emoticon: '🎮',
          statistics: const {},
        );

        // Act
        final result = await userRepository.upsert(updatedUser);

        // Assert
        expect(result, isNotNull);
        expect(result.name, equals('Updated User'));
        expect(result.emoticon, equals('🎮'));
      });

      test('should create new user when user does not exist', () async {
        // Arrange
        final testUser = const UserEntity(
          id: 0,
          name: 'New User',
          emoticon: '😊',
          statistics: {},
        );

        // Act
        final result = await userRepository.upsert(testUser);

        // Assert
        expect(result, isNotNull);
        expect(result.name, equals('New User'));
        expect(result.id, isNotNull);
      });
    });

    group('delete', () {
      test('should delete user successfully', () async {
        // Arrange
        const userId = 1;
        final user = const UserEntity(
          id: userId,
          name: 'Test User',
          emoticon: '😊',
          statistics: {},
        );

        final store = intMapStoreFactory.store(UserRepository.storeName);
        await store.record(userId).put(testDatabase, user.toJson());

        // Verify user was created
        expect(await userRepository.exists(userId), isTrue);

        // Act
        await userRepository.delete(userId);

        // Assert
        expect(await userRepository.exists(userId), isFalse);
      });
    });

    group('clearAll', () {
      test('should clear all users successfully', () async {
        // Arrange
        final user1 = const UserEntity(id: 1, name: 'User 1', emoticon: '😊', statistics: {});
        final user2 = const UserEntity(id: 2, name: 'User 2', emoticon: '🎮', statistics: {});

        final store = intMapStoreFactory.store(UserRepository.storeName);
        await store.record(1).put(testDatabase, user1.toJson());
        await store.record(2).put(testDatabase, user2.toJson());

        // Verify users were created
        expect(userRepository.getAll().length, equals(2));

        // Act
        await userRepository.clearAll();

        // Assert
        expect(userRepository.getAll(), isEmpty);
      });
    });
  });
}
