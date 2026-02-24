import 'package:game_domain/game_domain.dart';
import 'package:tt_database/tt_database.dart';

class CurrentGameRepositoryImpl implements CurrentGameRepository {
  late final StoreRef<String, Map<String, Object?>> _store = stringMapStoreFactory.store(CurrentGameRepository.storeName);

  @override
  CurrentGameEntity get() {
    final record = _store.record(CurrentGameRepository.settingsKey);
    final data = record.getSync(TripleTDatabase.instance.db);

    if (data != null) {
      return CurrentGameEntity.fromJson(data.cast<String, dynamic>());
    }
    return CurrentGameEntity();
  }

  @override
  Future<CurrentGameEntity> save(CurrentGameEntity settings) async {
    final record = _store.record(CurrentGameRepository.settingsKey);
    final updated = await record.put(TripleTDatabase.instance.db, settings.toJson());
    return CurrentGameEntity.fromJson(updated.cast<String, dynamic>());
  }

  @override
  Future<void> clearAll() async {
    await _store.drop(TripleTDatabase.instance.db);
  }
}
