import 'package:settings_domain/src/entity/settings/settings_entity.dart';

abstract class SettingsRepository {
  static const String storeName = 'settings';
  static const String settingsKey = 'settings';

  SettingsEntity get();

  Future<void> saveSettings(SettingsEntity settings);

  Future<void> clearAll();
}
