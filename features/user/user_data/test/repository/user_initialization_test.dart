import 'package:flutter_test/flutter_test.dart';
import 'package:tt_database/tt_database.dart';
import 'package:user_data/user_data.dart';

void main() {
  setUpAll(() async {
    // Initialize test database in memory
    final db = await databaseFactoryMemory.openDatabase('test.db');
    TripleTDatabase.setTestDatabase(db);
  });

  group('User Initialization Tests', () {
    test('initializes default users (AI, John, Jane) when database is empty', () async {
      // Act
      await initializeDefaultUsers();

      // Assert - Get all users from store directly
      final store = intMapStoreFactory.store('users');
      final db = TripleTDatabase.instance.db;
      final records = store.findSync(db);

      // Verify we have exactly 3 users
      expect(records.length, equals(3));

      // Verify by specific IDs
      final aiRecord = store.record(1).getSnapshotSync(db);
      expect(aiRecord, isNotNull);
      final ai = aiRecord!.value;
      expect(ai['name'], 'AI');
      expect(ai['emoticon'], '🤖');

      final johnRecord = store.record(2).getSnapshotSync(db);
      expect(johnRecord, isNotNull);
      final john = johnRecord!.value;
      expect(john['name'], 'John');
      expect(john['emoticon'], '🎮');

      final janeRecord = store.record(3).getSnapshotSync(db);
      expect(janeRecord, isNotNull);
      final jane = janeRecord!.value;
      expect(jane['name'], 'Jane');
      expect(jane['emoticon'], '🎲');
    });

    test('does not reinitialize users when database is not empty', () async {
      // Arrange
      await initializeDefaultUsers();

      // Act - call initialization again
      await initializeDefaultUsers();

      // Assert - should still have only 3 users
      final store = intMapStoreFactory.store('users');
      final db = TripleTDatabase.instance.db;
      final records = store.findSync(db);

      expect(records.length, equals(3));
    });
  });
}
