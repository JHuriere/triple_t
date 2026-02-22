import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:user_presentation/src/pages/create/create_user_page.dart';
import 'package:user_presentation/src/pages/statistics/user_statistics_page.dart';
import 'package:user_presentation/src/pages/update/update_user_page.dart';
import 'package:user_presentation/src/pages/user_list_page.dart';

part 'user_routes.g.dart';

class UserRoutes {
  static const String kUserListPath = '/user-list';
  static const String kUserListName = 'user-list';

  static const String kAddUserPath = 'add-user';
  static const String kAddUserName = 'add-user';

  static const String kEditUserPath = ':id';
  static const String kEditUserName = 'edit-user';

  static const String kUserStatisticsPath = ':id/statistics';
  static const String kUserStatisticsName = 'user-statistics';
}

@riverpod
GoRoute userPage(Ref ref) {
  return GoRoute(
    path: UserRoutes.kUserListPath,
    name: UserRoutes.kUserListName,
    builder: (context, state) => const UserListPage(),
    routes: [
      GoRoute(
        path: UserRoutes.kAddUserPath,
        name: UserRoutes.kAddUserName,
        builder: (context, state) => const CreateUserPage(),
      ),
      GoRoute(
        path: UserRoutes.kEditUserPath,
        name: UserRoutes.kEditUserName,
        builder: (context, state) {
          final userId = int.parse(state.pathParameters['id'] ?? '0');
          if (userId == 0) {
            return Offstage();
            // return const ErrorPage(error: 'User ID is missing'); // TODO: Show error page instead of Offstage when user ID is missing
          }
          return UpdateUserPage(userId: userId);
        },
      ),
      GoRoute(
        path: UserRoutes.kUserStatisticsPath,
        name: UserRoutes.kUserStatisticsName,
        builder: (context, state) {
          final userId = int.parse(state.pathParameters['id'] ?? '0');
          if (userId == 0) {
            return Offstage();
            // return const ErrorPage(error: 'User ID is missing'); // TODO: Show error page instead of Offstage when user ID is missing
          }
          return UserStatisticsPage(userId: userId);
        },
      ),
    ],
  );
}
