import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:statistics_presentation/src/pages/view/global_statistics_view.dart';
import 'package:statistics_presentation/src/pages/widget/no_statistics.dart';
import 'package:tt_i18n/i18n.dart';
import 'package:user_domain/user_domain.dart';

class GlobalStatisticsPage extends HookConsumerWidget {
  const GlobalStatisticsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStats = ref.watch(getGlobalStatisticsUseCaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.globalStatistics),
      ),
      body: userStats.isEmpty || userStats.every((stat) => stat.totalGames == 0)
          ? NoStatistics()
          : GlobalStatisticsView(
              userStats: userStats,
            ),
    );
  }
}
