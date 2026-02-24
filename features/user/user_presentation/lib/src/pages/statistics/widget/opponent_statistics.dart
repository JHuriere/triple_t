import 'package:flutter/material.dart';
import 'package:tt_i18n/i18n.dart';
import 'package:user_domain/user_domain.dart';

class OpponentStatistics extends StatelessWidget {
  final String opponentName;
  final String opponentEmoticon;
  final StatisticsEntity stats;

  const OpponentStatistics({
    super.key,
    required this.opponentName,
    required this.opponentEmoticon,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    final totalGames = stats.wins + stats.losses + stats.draws;
    final winRate = totalGames > 0 ? (stats.wins / totalGames * 100).toStringAsFixed(1) : '0.0';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: Text(
            opponentEmoticon,
            style: const TextStyle(fontSize: 32),
          ),
          title: Text(
            opponentName,
            style: const TextStyle(fontWeight: .bold),
          ),
          subtitle: Text('$totalGames ${context.l10n.games} • $winRate${context.l10n.winRatePercent}'),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: .spaceAround,
                children: [
                  _SmallStatCard(
                    label: context.l10n.wins,
                    value: stats.wins.toString(),
                    color: Colors.green,
                  ),
                  _SmallStatCard(
                    label: context.l10n.losses,
                    value: stats.losses.toString(),
                    color: Colors.red,
                  ),
                  _SmallStatCard(
                    label: context.l10n.draws,
                    value: stats.draws.toString(),
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SmallStatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _SmallStatCard({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
