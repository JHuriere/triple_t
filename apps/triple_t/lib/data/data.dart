import 'package:sembast/sembast_io.dart';

import 'core/triple_t_database.dart';
import 'entity/user/user_entity.dart';

class Data {
  static Future<void> init() async {
    await TripleTDatabase.instance.openDatabase();
    await _initializeDefaultUsers();
  }

  static Future<void> _initializeDefaultUsers() async {
    final store = intMapStoreFactory.store('users');
    final db = TripleTDatabase.instance.db;

    final count = await store.count(db);
    if (count == 0) {
      final aiEntity = UserEntity(name: 'AI', emoticon: '🤖');
      final johnEntity = UserEntity(name: 'John', emoticon: '🎮');
      final janeEntity = UserEntity(name: 'Jane', emoticon: '🎲');

      await store.record(1).put(db, aiEntity.toJson());
      await store.record(2).put(db, johnEntity.toJson());
      await store.record(3).put(db, janeEntity.toJson());
    }
  }
}
