import 'package:settings_domain/settings_domain.dart';
import 'package:tt_database/tt_database.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  late final StoreRef<String, Map<String, Object?>> _store = stringMapStoreFactory.store(SettingsRepository.storeName);

  @override
  SettingsEntity get() {
    final record = _store.record(SettingsRepository.settingsKey);
    final data = record.getSync(TripleTDatabase.instance.db);

    if (data != null) {
      return SettingsEntity.fromJson(data.cast<String, dynamic>());
    }
    return SettingsEntity(id: SettingsRepository.settingsKey);
  }

  @override
  Future<void> saveSettings(SettingsEntity settings) async {
    final record = _store.record(SettingsRepository.settingsKey);
    await record.put(TripleTDatabase.instance.db, settings.toJson());
  }

  @override
  Future<void> clearAll() async {
    await _store.drop(TripleTDatabase.instance.db);
  }
}
