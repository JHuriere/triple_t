import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:statistics_presentation/src/pages/model/user_stats_model.dart';
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
    final users = ref.watch(getAllUsersUseCaseProvider);

    final userStats = _getUserStats(users);
    userStats.sort((a, b) => b.totalWins.compareTo(a.totalWins));

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

  List<UserStatsModel> _getUserStats(List<UserEntity> users) {
    final userStats = users
        .map((user) {
          int totalWins = 0;
          int totalLosses = 0;
          int totalDraws = 0;

          if (user.statistics != null) {
            for (var stats in user.statistics!.values) {
              totalWins += stats.wins;
              totalLosses += stats.losses;
              totalDraws += stats.draws;
            }
          }

          final totalGames = totalWins + totalLosses + totalDraws;
          final winRate = totalGames > 0 ? (totalWins / totalGames * 100) : 0.0;

          return UserStatsModel(
            user: user,
            totalWins: totalWins,
            totalLosses: totalLosses,
            totalDraws: totalDraws,
            totalGames: totalGames,
            winRate: winRate,
          );
        })
        .toList(growable: false);
    return userStats;
  }
}
