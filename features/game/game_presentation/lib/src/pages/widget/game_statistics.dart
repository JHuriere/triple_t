import 'package:flutter/material.dart';
import 'package:game_domain/game_domain.dart';
import 'package:tt_i18n/i18n.dart';

class GameStatistics extends StatelessWidget {
  final CurrentGameModel currentGame;

  const GameStatistics({
    super.key,
    required this.currentGame,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Expanded(
          child: _StatCard(
            label: currentGame.playerOne.name,
            value: currentGame.playerOneWins,
            color: colorScheme.primary,
            emoticon: currentGame.playerOne.emoticon,
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: _StatCard(
            label: context.l10n.draws,
            value: currentGame.draws,
            color: colorScheme.tertiary,
            emoticon: '🤝',
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: _StatCard(
            label: currentGame.playerTwo.name,
            value: currentGame.playerTwoWins,
            color: colorScheme.secondary,
            emoticon: currentGame.playerTwo.emoticon,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final int value;
  final Color color;
  final String emoticon;

  const _StatCard({
    required this.label,
    required this.value,
    required this.color,
    required this.emoticon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withValues(alpha: 0.1),
              color.withValues(alpha: 0.05),
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant, fontWeight: .w500),
              textAlign: .center,
              overflow: .ellipsis,
              maxLines: 1,
            ),

            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: color.withValues(alpha: 0.2), shape: BoxShape.circle),
                  child: Text(
                    emoticon,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                Text(
                  value.toString(),
                  style: theme.textTheme.headlineMedium?.copyWith(fontWeight: .bold, color: color),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
