import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:triple_t/data/data.dart';
import 'package:triple_t/data/repository/user_repository.dart';

void main() {
  group('User Initialization Tests', () {
    test('Database should initialize with John and Jane when empty', () async {
      // Initialize database
      await Data.init();

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
