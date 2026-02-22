import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tt_database/tt_database.dart';
import 'package:user_data/src/entity/user_entity.dart';

final userRepositoryProvider = Provider.autoDispose<_UserRepository>((ref) => _UserRepository(ref: ref));

class _UserRepository {
  static const String _storeName = 'users';

  final Ref ref;
  late final StoreRef<int, Map<String, Object?>> _store = intMapStoreFactory.store(_storeName);

  _UserRepository({required this.ref});

  Future<bool> exists(int id) {
    return _store.record(id).exists(TripleTDatabase.instance.db);
  }

  Entity<UserEntity>? get(int id) {
    final record = _store.record(id).getSnapshotSync(TripleTDatabase.instance.db);
    if (record != null) {
      return Entity<UserEntity>(id: record.key, data: UserEntity.fromJson(record.value));
    }
    return null;
  }

  Entity<UserEntity>? getByName(String name) {
    final finder = Finder(filter: Filter.equals('name', name));
    final record = _store.findFirstSync(TripleTDatabase.instance.db, finder: finder);

    if (record != null) {
      return Entity<UserEntity>(id: record.key, data: UserEntity.fromJson(record.value));
    }
    return null;
  }

  Entity<UserEntity>? getByNameAndDifferentId(int id, String name) {
    final finder = Finder(
      filter: Filter.and([Filter.equals('name', name), Filter.not(Filter.byKey(id))]),
    );
    final record = _store.findFirstSync(TripleTDatabase.instance.db, finder: finder);

    if (record != null) {
      return Entity<UserEntity>(id: record.key, data: UserEntity.fromJson(record.value));
    }
    return null;
  }

  List<Entity<UserEntity>> getAll() {
    final records = _store.findSync(TripleTDatabase.instance.db);
    return records.map((record) => Entity<UserEntity>(id: record.key, data: UserEntity.fromJson(record.value))).toList(growable: false);
  }

  Future<Entity<UserEntity>> upsert(Entity<UserEntity> entity) async {
    final exists = await this.exists(entity.id);
    if (exists) {
      final updated = await _store.record(entity.id).put(TripleTDatabase.instance.db, entity.data.toJson());
      return Entity<UserEntity>(id: entity.id, data: UserEntity.fromJson(updated));
    } else {
      final key = await _store.add(TripleTDatabase.instance.db, entity.data.toJson());
      return Entity<UserEntity>(id: key, data: entity.data);
    }
  }

  Future<void> delete(int id) async {
    await _store.record(id).delete(TripleTDatabase.instance.db);
  }

  Future<void> clearAll() async {
    await _store.drop(TripleTDatabase.instance.db);
  }
}
