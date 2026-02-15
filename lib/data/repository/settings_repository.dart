import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sembast/sembast_io.dart';
import 'package:triple_t/data/core/triple_t_database.dart';
import 'package:triple_t/data/entity/settings/settings_entity.dart';

final settingsRepositoryProvider = Provider.autoDispose<_SettingsRepository>((ref) => _SettingsRepository(ref: ref));

class _SettingsRepository {
  static const String _storeName = 'settings';
  static const String _settingsKey = 'settings';

  final Ref ref;
  late final StoreRef<String, Map<String, Object?>> _store = stringMapStoreFactory.store(_storeName);

  _SettingsRepository({required this.ref});

  SettingsEntity get() {
    final record = _store.record(_settingsKey);
    final data = record.getSync(TripleTDatabase.instance.db);

    if (data != null) {
      return SettingsEntity.fromJson(data.cast<String, dynamic>());
    }
    return SettingsEntity(id: _settingsKey);
  }

  Future<void> saveSettings(SettingsEntity settings) async {
    final record = _store.record(_settingsKey);
    await record.put(TripleTDatabase.instance.db, settings.toJson());
  }

  Future<void> clearAll() async {
    await _store.drop(TripleTDatabase.instance.db);
  }
}
