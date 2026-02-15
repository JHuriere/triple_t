import 'package:flutter/material.dart';
import 'package:triple_t/domain/model/statistics/statistics_model.dart';

class OverallStatistics extends StatelessWidget {
  final Map<int, StatisticsModel> statistics;

  const OverallStatistics({
    super.key,
    required this.statistics,
  });

  @override
  Widget build(BuildContext context) {
    int totalWins = 0;
    int totalLosses = 0;
    int totalDraws = 0;

    for (var stats in statistics.values) {
      totalWins += stats.wins;
      totalLosses += stats.losses;
      totalDraws += stats.draws;
    }

    final totalGames = totalWins + totalLosses + totalDraws;
    final winRate = totalGames > 0 ? (totalWins / totalGames * 100).toStringAsFixed(1) : '0.0';

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Overall Statistics',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatCard(
                  label: 'Total Games',
                  value: totalGames.toString(),
                  icon: Icons.sports_esports,
                  color: Colors.blue,
                ),
                _StatCard(
                  label: 'Win Rate',
                  value: '$winRate%',
                  icon: Icons.emoji_events,
                  color: Colors.amber,
                ),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatCard(
                  label: 'Wins',
                  value: totalWins.toString(),
                  icon: Icons.check_circle,
                  color: Colors.green,
                ),
                _StatCard(
                  label: 'Losses',
                  value: totalLosses.toString(),
                  icon: Icons.cancel,
                  color: Colors.red,
                ),
                _StatCard(
                  label: 'Draws',
                  value: totalDraws.toString(),
                  icon: Icons.remove_circle,
                  color: Colors.orange,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),

        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: .bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
