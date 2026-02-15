import 'package:flutter/material.dart' show BuildContext;
import 'package:go_router/go_router.dart';
import 'package:home_presentation/home_presentation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_navigator.g.dart';

@riverpod
AppNavigator appNavigator(Ref ref) {
  return AppNavigator();
}

class AppNavigator implements HomeNavigator {
  AppNavigator();

  @override
  void goGame(BuildContext context) {
    context.pushNamed('game');
  }

  @override
  void goGlobalStatistics(BuildContext context) {
    context.pushNamed('global-statistics');
  }

  @override
  void goSettings(BuildContext context) {
    context.pushNamed('settings');
  }

  @override
  void goUserList(BuildContext context) {
    context.pushNamed('user-list');
  }
}
