import 'package:settings_data/src/data_source/settings_data_source.dart';
import 'package:settings_data/src/model/settings_model.dart';
import 'package:tt_database/tt_database.dart';

class SettingsDataSourceImpl implements SettingsDataSource {
  static const String storeName = 'settings';
  static const String settingsKey = 'settings';

  late final StoreRef<String, Map<String, Object?>> _store = stringMapStoreFactory.store(storeName);
  final Database db;

  SettingsDataSourceImpl({required this.db});

  @override
  SettingsModel get() {
    final record = _store.record(settingsKey);
    final data = record.getSync(db);

    if (data != null) {
      return SettingsModel.fromJson(data.cast<String, dynamic>());
    }
    return const SettingsModel(id: settingsKey);
  }

  @override
  Future<void> saveSettings(SettingsModel model) async {
    final record = _store.record(settingsKey);
    await record.put(db, model.toJson());
  }

  @override
  Future<void> clearAll() async {
    await _store.drop(db);
  }
}
