import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:settings_data/settings_data.dart';
import 'package:settings_domain/src/model/settings/settings_model.dart';

part 'get_settings_use_case.g.dart';

@riverpod
SettingsModel getSettingsUseCase(Ref ref) {
  final settingsEntity = ref.watch(settingsRepositoryProvider).get();
  return SettingsModel.fromEntity(entity: settingsEntity);
}
