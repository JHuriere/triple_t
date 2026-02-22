import 'package:error_presentation/error_presentation.dart';
import 'package:flutter/material.dart';
import 'package:game_presentation/game_presentation.dart';
import 'package:go_router/go_router.dart';
import 'package:home_presentation/home_presentation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:settings_presentation/settings_presentation.dart';
import 'package:statistics_presentation/statistics_presentation.dart';
import 'package:user_presentation/user_presentation.dart';

part 'router.g.dart';

@riverpod
GoRouter router(Ref ref) {
  final router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: GlobalKey<NavigatorState>(),
    initialLocation: HomeRoutes.kHomePath,
    errorBuilder: (context, state) => ErrorPage(error: state.error?.toString()),
    routes: [
      ref.watch(homePageProvider),
      ref.watch(gamePageProvider),
      ref.watch(userPageProvider),
      ref.watch(statisticsPageProvider),
      ref.watch(settingsPageProvider),
    ],
    redirect: (context, state) {
      // final isAuthenticated = ref.read(authProvider).isAuthenticated;
      // if (!isAuthenticated && state.matchedLocation != '/login') {
      //   return '/login';
      // }
      return null;
    },
  );
  ref.onDispose(router.dispose);

  return router;
}
