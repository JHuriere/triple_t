import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:settings_domain/src/repository/get_settings_repository.dart';

part 'update_locale_use_case.g.dart';

@riverpod
Future<void> updateLocaleUseCase(Ref ref, {required String locale}) async {
  final repository = ref.watch(getSettingsRepositoryProvider);

  final entity = repository.get();
  await repository.saveSettings(entity.copyWith(locale: locale));
}
