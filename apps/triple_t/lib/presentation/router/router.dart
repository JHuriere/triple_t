import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_presentation/home_presentation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triple_t/presentation/pages/error/error_page.dart';
import 'package:triple_t/presentation/pages/game/game_page.dart';
import 'package:triple_t/presentation/pages/settings/settings_page.dart';
import 'package:triple_t/presentation/pages/statistics/global_statistics_page.dart';
import 'package:triple_t/presentation/pages/user_list/create/create_user_page.dart';
import 'package:triple_t/presentation/pages/user_list/statistics/user_statistics_page.dart';
import 'package:triple_t/presentation/pages/user_list/update/update_user_page.dart';
import 'package:triple_t/presentation/pages/user_list/user_list_page.dart';

part 'router.g.dart';

@riverpod
GoRouter router(Ref ref) {
  final router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: GlobalKey<NavigatorState>(),
    initialLocation: '/',
    errorBuilder: (context, state) => ErrorPage(error: state.error?.toString()),
    routes: [
      ref.watch(homePageProvider),
      GoRoute(path: '/game', name: 'game', builder: (context, state) => const GamePage()),
      GoRoute(
        path: '/user-list',
        name: 'user-list',
        builder: (context, state) => const UserListPage(),
        routes: [
          GoRoute(path: 'add-user', name: 'add-user', builder: (context, state) => const CreateUserPage()),
          GoRoute(
            path: ':id',
            name: 'edit-user',
            builder: (context, state) {
              final userId = int.parse(state.pathParameters['id'] ?? '0');
              if (userId == 0) {
                return const ErrorPage(error: 'User ID is missing');
              }
              return UpdateUserPage(userId: userId);
            },
          ),
          GoRoute(
            path: ':id/statistics',
            name: 'user-statistics',
            builder: (context, state) {
              final userId = int.parse(state.pathParameters['id'] ?? '0');
              if (userId == 0) {
                return const ErrorPage(error: 'User ID is missing');
              }
              return UserStatisticsPage(userId: userId);
            },
          ),
        ],
      ),
      GoRoute(path: '/statistics', name: 'global-statistics', builder: (context, state) => const GlobalStatisticsPage()),
      GoRoute(path: '/settings', name: 'settings', builder: (context, state) => const SettingsPage()),
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
