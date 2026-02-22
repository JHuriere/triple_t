import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:statistics_presentation/src/pages/widget/leaderboard_header.dart';
import 'package:statistics_presentation/src/pages/widget/no_statistics.dart';
import 'package:statistics_presentation/src/pages/widget/user_stat_card.dart';
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
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                LeaderboardHeader(),
                const SizedBox(height: 16),

                ...userStats.asMap().entries.map((entry) {
                  final index = entry.key;
                  final stat = entry.value;

                  return UserStatCard(
                    user: stat.user,
                    rank: index + 1,
                    totalWins: stat.totalWins,
                    totalLosses: stat.totalLosses,
                    totalDraws: stat.totalDraws,
                    totalGames: stat.totalGames,
                    winRate: stat.winRate,
                  );
                }),
              ],
            ),
    );
  }

  List<({int totalDraws, int totalGames, int totalLosses, int totalWins, UserModel user, double winRate})> _getUserStats(List<UserModel> users) {
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

          return (
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
