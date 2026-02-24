import 'package:flutter/material.dart';
import 'package:game_presentation/src/pages/view_model/current_game_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tt_i18n/i18n.dart';

class GameStatistics extends ConsumerWidget {
  const GameStatistics({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (:currentGame, :playerOne, :playerTwo) = ref.watch(currentGameViewModelProvider);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Expanded(
          child: _StatCard(
            label: playerOne.name,
            value: currentGame.playerOneWins,
            color: colorScheme.primary,
            emoticon: playerOne.emoticon,
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
            label: playerTwo.name,
            value: currentGame.playerTwoWins,
            color: colorScheme.secondary,
            emoticon: playerTwo.emoticon,
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
