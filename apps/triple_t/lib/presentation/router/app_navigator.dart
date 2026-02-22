import 'package:error_presentation/error_presentation.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:game_presentation/game_presentation.dart';
import 'package:go_router/go_router.dart';
import 'package:home_presentation/home_presentation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:settings_presentation/settings_presentation.dart';
import 'package:user_presentation/user_presentation.dart';

part 'app_navigator.g.dart';

@riverpod
AppNavigator appNavigator(Ref ref) {
  return AppNavigator();
}

class AppNavigator implements HomeNavigator, ErrorNavigator {
  @override
  void goHome(BuildContext context) {
    context.pushNamed(HomeRoutes.kHomeName);
  }

  @override
  void goGame(BuildContext context) {
    context.pushNamed(GameRoutes.kGameName);
  }

  @override
  void goGlobalStatistics(BuildContext context) {
    context.pushNamed('global-statistics');
  }

  @override
  void goSettings(BuildContext context) {
    context.pushNamed(SettingsRoutes.kSettingsName);
  }

  @override
  void goUserList(BuildContext context) {
    context.pushNamed(UserRoutes.kUserListName);
  }
}
