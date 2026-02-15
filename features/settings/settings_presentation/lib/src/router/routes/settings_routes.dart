import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:settings_presentation/src/pages/settings_page.dart';

part 'settings_routes.g.dart';

class SettingsRoutes {
  static const String kSettingsPath = '/settings';
  static const String kSettingsName = 'settings';
}

@riverpod
GoRoute settingsPage(Ref ref) {
  return GoRoute(
    path: SettingsRoutes.kSettingsPath,
    name: SettingsRoutes.kSettingsName,
    builder: (context, state) => const SettingsPage(),
  );
}
