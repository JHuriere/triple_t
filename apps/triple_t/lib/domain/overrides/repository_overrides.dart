import 'package:game_data/game_data.dart';
import 'package:game_domain/game_domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:settings_data/settings_data.dart';
import 'package:settings_domain/settings_domain.dart';
import 'package:user_data/user_data.dart';
import 'package:user_domain/user_domain.dart';

sealed class RepositoryOverrides {
  static List<Override> get() => [
    getUserRepositoryProvider.overrideWithValue(UserRepositoryImpl()),
    getCurrentGameRepositoryProvider.overrideWithValue(CurrentGameRepositoryImpl()),
    getSettingsRepositoryProvider.overrideWithValue(SettingsRepositoryImpl()),
  ];
}
