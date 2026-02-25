import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:statistics_presentation/src/pages/widget/leaderboard_header.dart';
import 'package:statistics_presentation/src/pages/widget/user_stat_card.dart';
import 'package:user_domain/user_domain.dart';

class GlobalStatisticsView extends HookConsumerWidget {
  final List<GlobalUserStatisticsEntity> userStats;

  const GlobalStatisticsView({
    super.key,
    required this.userStats,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
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
    );
  }
}
