import 'package:tt_database/tt_database.dart';
import 'package:user_data/user_data.dart';

Future<void> initializeDefaultUsers() async {
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
