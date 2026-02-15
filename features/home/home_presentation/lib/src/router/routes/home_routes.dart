import 'package:go_router/go_router.dart';
import 'package:home_presentation/src/pages/home_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_routes.g.dart';

class HomeRoutes {
  static const String kHomePath = '/';
  static const String kHomeName = 'home';
}

@riverpod
GoRoute homePage(Ref ref) {
  return GoRoute(path: HomeRoutes.kHomePath, name: HomeRoutes.kHomeName, builder: (context, state) => const HomePage());
}
