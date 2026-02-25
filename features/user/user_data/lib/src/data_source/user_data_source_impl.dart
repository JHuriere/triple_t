import 'package:tt_database/tt_database.dart';
import 'package:user_data/src/data_source/user_data_source.dart';
import 'package:user_data/src/model/user_model.dart';

class UserDataSourceImpl implements UserDataSource {
  static const String storeName = 'users';

  late final StoreRef<int, Map<String, Object?>> _store = intMapStoreFactory.store(storeName);
  final Database db;

  UserDataSourceImpl({required this.db});

  @override
  Future<bool> exists(int id) {
    return _store.record(id).exists(db);
  }

  @override
  UserModel? get(int id) {
    final record = _store.record(id).getSnapshotSync(db);
    if (record != null) {
      return UserModel.fromJson(record.value);
    }
    return null;
  }

  @override
  UserModel? getByName(String name) {
    final finder = Finder(filter: Filter.equals('name', name));
    final record = _store.findFirstSync(db, finder: finder);

    if (record != null) {
      return UserModel.fromJson(record.value);
    }
    return null;
  }

  @override
  UserModel? getByNameAndDifferentId(int id, String name) {
    final finder = Finder(
      filter: Filter.and([Filter.equals('name', name), Filter.not(Filter.byKey(id))]),
    );
    final record = _store.findFirstSync(db, finder: finder);

    if (record != null) {
      return UserModel.fromJson(record.value);
    }
    return null;
  }

  @override
  List<UserModel> getAll() {
    final records = _store.findSync(db);
    return records.map((record) => UserModel.fromJson(record.value)).toList(growable: false);
  }

  @override
  Future<UserModel> upsert(UserModel model) async {
    final exists = await this.exists(model.id);
    if (exists) {
      final updated = await _store.record(model.id).put(db, model.toJson());
      return UserModel.fromJson(updated);
    } else {
      final id = await _store.generateIntKey(db);
      final modelWithId = model.copyWith(id: id);
      final key = await _store.add(db, modelWithId.toJson());
      return modelWithId.copyWith(id: key);
    }
  }

  @override
  Future<void> delete(int id) async {
    await _store.record(id).delete(db);
  }

  @override
  Future<void> clearAll() async {
    await _store.drop(db);
  }
}
