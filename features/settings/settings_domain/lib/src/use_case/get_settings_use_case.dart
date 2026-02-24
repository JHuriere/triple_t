import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:settings_domain/src/entity/settings/settings_entity.dart';
import 'package:settings_domain/src/repository/get_settings_repository.dart';

part 'get_settings_use_case.g.dart';

@riverpod
SettingsEntity getSettingsUseCase(Ref ref) {
  final repository = ref.watch(getSettingsRepositoryProvider);
  return repository.get();
}
