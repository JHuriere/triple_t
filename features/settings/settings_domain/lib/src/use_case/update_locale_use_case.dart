import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:settings_data/settings_data.dart';

part 'update_locale_use_case.g.dart';

@riverpod
Future<void> updateLocaleUseCase(Ref ref, {required String locale}) async {
  final repository = ref.watch(settingsRepositoryProvider);
  final entity = repository.get();
  await repository.saveSettings(entity.copyWith(locale: locale));
}
