import 'package:settings_data/src/model/settings_model.dart';

abstract class SettingsDataSource {
  SettingsModel get();
  Future<void> saveSettings(SettingsModel model);
  Future<void> clearAll();
}
