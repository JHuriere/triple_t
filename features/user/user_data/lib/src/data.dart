import 'package:tt_database/tt_database.dart';
import 'package:user_domain/user_domain.dart';

Future<void> initializeDefaultUsers() async {
  final store = intMapStoreFactory.store('users');
  final db = TripleTDatabase.instance.db;

  final count = await store.count(db);
  if (count == 0) {
    final aiEntity = UserEntity(id: 1, name: 'AI', emoticon: '🤖');
    final johnEntity = UserEntity(id: 2, name: 'John', emoticon: '🎮');
    final janeEntity = UserEntity(id: 3, name: 'Jane', emoticon: '🎲');

    await store.record(1).add(db, aiEntity.toJson());
    await store.record(2).add(db, johnEntity.toJson());
    await store.record(3).add(db, janeEntity.toJson());
  }
}
