import 'package:game_presentation/src/pages/game_page.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_routes.g.dart';

class GameRoutes {
  static const String kGamePath = '/game';
  static const String kGameName = 'game';
}

@riverpod
GoRoute gamePage(Ref ref) {
  return GoRoute(
    path: GameRoutes.kGamePath,
    name: GameRoutes.kGameName,
    builder: (context, state) => const GamePage(),
  );
}
