// global statistics page

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:triple_t/domain/model/user/user_model.dart';
import 'package:triple_t/domain/use_case/user/get_all_users_use_case.dart';
import 'package:tt_i18n/i18n.dart';

class GlobalStatisticsPage extends HookConsumerWidget {
  const GlobalStatisticsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(getAllUsersUseCaseProvider);

    // Calculate overall statistics for each user
    final userStats = users.map((user) {
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

      return {
        'user': user,
        'totalWins': totalWins,
        'totalLosses': totalLosses,
        'totalDraws': totalDraws,
        'totalGames': totalGames,
        'winRate': winRate,
      };
    }).toList();

    // Sort by total wins (descending)
    userStats.sort((a, b) => (b['totalWins'] as int).compareTo(a['totalWins'] as int));

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.globalStatistics),
      ),
      body: userStats.isEmpty || userStats.every((stat) => stat['totalGames'] == 0)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.leaderboard, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    context.l10n.noStatisticsAvailable,
                    textAlign: .center,
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.l10n.playSomeGamesSeeLeaderboard,
                    textAlign: .center,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildLeaderboardHeader(context),
                const SizedBox(height: 16),
                ...userStats.asMap().entries.map((entry) {
                  final index = entry.key;
                  final stat = entry.value;
                  return _buildUserStatCard(
                    context,
                    index + 1,
                    stat['user'] as UserModel,
                    stat['totalWins'] as int,
                    stat['totalLosses'] as int,
                    stat['totalDraws'] as int,
                    stat['totalGames'] as int,
                    stat['winRate'] as double,
                  );
                }),
              ],
            ),
    );
  }

  Widget _buildLeaderboardHeader(BuildContext context) {
    return Card(
      elevation: 4,
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.emoji_events, size: 32),
            const SizedBox(width: 16),
            Text(
              context.l10n.leaderboard,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserStatCard(
    BuildContext context,
    int rank,
    UserModel user,
    int totalWins,
    int totalLosses,
    int totalDraws,
    int totalGames,
    double winRate,
  ) {
    Color rankColor;
    IconData rankIcon;

    switch (rank) {
      case 1:
        rankColor = Colors.amber;
        rankIcon = Icons.emoji_events;
        break;
      case 2:
        rankColor = Colors.grey;
        rankIcon = Icons.emoji_events;
        break;
      case 3:
        rankColor = Colors.brown;
        rankIcon = Icons.emoji_events;
        break;
      default:
        rankColor = Colors.blueGrey;
        rankIcon = Icons.person;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => context.pushNamed('user-statistics', pathParameters: {'id': user.id.toString()}),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Rank
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: rankColor.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: rank <= 3
                      ? Icon(rankIcon, color: rankColor, size: 24)
                      : Text(
                          '$rank',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: rankColor,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 16),
              // User info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          user.emoticon,
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          user.name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      context.l10n.gamesWinRate(
                        totalGames,
                        double.parse(winRate.toStringAsFixed(1)),
                      ),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              // Stats summary
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.check_circle, size: 16, color: Colors.green),
                      const SizedBox(width: 4),
                      Text(
                        '$totalWins',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.cancel, size: 16, color: Colors.red),
                      const SizedBox(width: 4),
                      Text(
                        '$totalLosses',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.remove_circle, size: 16, color: Colors.orange),
                      const SizedBox(width: 4),
                      Text(
                        '$totalDraws',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
