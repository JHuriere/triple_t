import 'package:flutter/material.dart';
import 'package:tt_i18n/i18n.dart';
import 'package:user_domain/user_domain.dart';

class OverallStatistics extends StatelessWidget {
  final Map<int, StatisticsEntity> statistics;

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
              context.l10n.overallStatistics,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatCard(
                  label: context.l10n.totalGames,
                  value: totalGames.toString(),
                  icon: Icons.sports_esports,
                  color: Colors.blue,
                ),
                _StatCard(
                  label: context.l10n.winRate,
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
                  label: context.l10n.wins,
                  value: totalWins.toString(),
                  icon: Icons.check_circle,
                  color: Colors.green,
                ),
                _StatCard(
                  label: context.l10n.losses,
                  value: totalLosses.toString(),
                  icon: Icons.cancel,
                  color: Colors.red,
                ),
                _StatCard(
                  label: context.l10n.draws,
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
    final theme = Theme.of(context);

    return Column(
      children: [
        Icon(icon, size: 32, color: color),
        const SizedBox(height: 8),
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
