import 'package:settings_data/src/data_source/settings_data_source.dart';
import 'package:settings_data/src/model/settings_model.dart';
import 'package:settings_domain/settings_domain.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsDataSource dataSource;

  SettingsRepositoryImpl({required this.dataSource});

  @override
  SettingsEntity get() {
    return dataSource.get().toEntity();
  }

  @override
  Future<void> saveSettings(SettingsEntity settings) async {
    final model = SettingsModel.fromEntity(settings);
    await dataSource.saveSettings(model);
  }

  @override
  Future<void> clearAll() async {
    await dataSource.clearAll();
  }
}
