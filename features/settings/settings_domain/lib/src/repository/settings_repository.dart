import 'package:settings_domain/src/entity/settings/settings_entity.dart';

abstract class SettingsRepository {
  SettingsEntity get();

  Future<void> saveSettings(SettingsEntity settings);

  Future<void> clearAll();
}
