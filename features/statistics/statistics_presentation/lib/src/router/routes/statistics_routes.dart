import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:statistics_presentation/src/pages/global_statistics_page.dart';

part 'statistics_routes.g.dart';

class StatisticsRoutes {
  static const String kStatisticsPath = '/statistics';
  static const String kStatisticsName = 'global-statistics';
}

@riverpod
GoRoute statisticsPage(Ref ref) {
  return GoRoute(
    path: StatisticsRoutes.kStatisticsPath,
    name: StatisticsRoutes.kStatisticsName,
    builder: (context, state) => const GlobalStatisticsPage(),
  );
}
