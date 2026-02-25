import 'package:tt_database/tt_database.dart';
import 'package:user_data/src/data_source/user_data_source_impl.dart';
import 'package:user_data/src/model/user_model.dart';
import 'package:user_domain/user_domain.dart';

Future<void> initializeDefaultUsers() async {
  final store = intMapStoreFactory.store(UserDataSourceImpl.storeName);
  final db = TripleTDatabase.instance.db;

  final count = await store.count(db);
  if (count == 0) {
    const aiEntity = UserEntity(id: 1, name: 'AI', emoticon: '🤖');
    const johnEntity = UserEntity(id: 2, name: 'John', emoticon: '🎮');
    const janeEntity = UserEntity(id: 3, name: 'Jane', emoticon: '🎲');

    await store.record(1).add(db, UserModel.fromEntity(aiEntity).toJson());
    await store.record(2).add(db, UserModel.fromEntity(johnEntity).toJson());
    await store.record(3).add(db, UserModel.fromEntity(janeEntity).toJson());
  }
}
