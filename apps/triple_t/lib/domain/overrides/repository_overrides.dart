import 'package:game_data/game_data.dart';
import 'package:game_domain/game_domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:settings_data/settings_data.dart';
import 'package:settings_domain/settings_domain.dart';
import 'package:triple_t/data/provider/database_provider.dart';
import 'package:user_data/user_data.dart';
import 'package:user_domain/user_domain.dart';

sealed class RepositoryOverrides {
  static List<Override> get() => [
    getUserRepositoryProvider.overrideWith((ref) {
      final db = ref.watch(databaseProvider);
      return UserRepositoryImpl(dataSource: UserDataSourceImpl(db: db));
    }),
    getCurrentGameRepositoryProvider.overrideWith((ref) {
      final db = ref.watch(databaseProvider);
      return CurrentGameRepositoryImpl(dataSource: CurrentGameDataSourceImpl(db: db));
    }),
    getSettingsRepositoryProvider.overrideWith((ref) {
      final db = ref.watch(databaseProvider);
      return SettingsRepositoryImpl(dataSource: SettingsDataSourceImpl(db: db));
    }),
  ];
}
