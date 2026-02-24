import 'package:tt_database/tt_database.dart';
import 'package:user_domain/user_domain.dart';

class UserRepositoryImpl implements UserRepository {
  late final StoreRef<int, Map<String, Object?>> _store = intMapStoreFactory.store(UserRepository.storeName);

  @override
  Future<bool> exists(int id) {
    return _store.record(id).exists(TripleTDatabase.instance.db);
  }

  @override
  UserEntity? get(int id) {
    final record = _store.record(id).getSnapshotSync(TripleTDatabase.instance.db);
    if (record != null) {
      return UserEntity.fromJson(record.value);
    }
    return null;
  }

  @override
  UserEntity? getByName(String name) {
    final finder = Finder(filter: Filter.equals('name', name));
    final record = _store.findFirstSync(TripleTDatabase.instance.db, finder: finder);

    if (record != null) {
      return UserEntity.fromJson(record.value);
    }
    return null;
  }

  @override
  UserEntity? getByNameAndDifferentId(int id, String name) {
    final finder = Finder(
      filter: Filter.and([Filter.equals('name', name), Filter.not(Filter.byKey(id))]),
    );
    final record = _store.findFirstSync(TripleTDatabase.instance.db, finder: finder);

    if (record != null) {
      return UserEntity.fromJson(record.value);
    }
    return null;
  }

  @override
  List<UserEntity> getAll() {
    final records = _store.findSync(TripleTDatabase.instance.db);
    return records.map((record) => UserEntity.fromJson(record.value)).toList(growable: false);
  }

  @override
  Future<UserEntity> upsert(UserEntity entity) async {
    final exists = await this.exists(entity.id);
    if (exists) {
      final updated = await _store.record(entity.id).put(TripleTDatabase.instance.db, entity.toJson());
      return UserEntity.fromJson(updated);
    } else {
      final id = await _store.generateIntKey(TripleTDatabase.instance.db);
      final key = await _store.add(TripleTDatabase.instance.db, entity.copyWith(id: id).toJson());
      return entity.copyWith(id: key);
    }
  }

  @override
  Future<void> delete(int id) async {
    await _store.record(id).delete(TripleTDatabase.instance.db);
  }

  @override
  Future<void> clearAll() async {
    await _store.drop(TripleTDatabase.instance.db);
  }
}
