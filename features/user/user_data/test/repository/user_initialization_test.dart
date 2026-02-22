import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tt_database/tt_database.dart';
import 'package:user_data/user_data.dart';

void main() {
  setUpAll(() async {
    // Initialize test database in memory
    final db = await databaseFactoryMemory.openDatabase('test.db');
    TripleTDatabase.setTestDatabase(db);
  });

  group('User Initialization Tests', () {
    test('Database should initialize with John and Jane when empty', () async {
      // Initialize database
      await initializeDefaultUsers();

      // Create container to get repository
      final container = ProviderContainer();
      final userRepo = container.read(userRepositoryProvider);

      // Get all users
      final users = userRepo.getAll();

      // Verify we have at least 2 users
      expect(users.length, greaterThanOrEqualTo(2));

      // Verify John exists
      final john = users.firstWhere((u) => u.data.name == 'John', orElse: () => throw Exception('John not found'));
      expect(john.data.name, 'John');

      // Verify Jane exists
      final jane = users.firstWhere((u) => u.data.name == 'Jane', orElse: () => throw Exception('Jane not found'));
      expect(jane.data.name, 'Jane');

      container.dispose();
    });
  });
}
