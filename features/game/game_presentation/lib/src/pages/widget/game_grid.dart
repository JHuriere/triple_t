import 'package:flutter/material.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/src/pages/painter/winning_line_painter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const _gridGap = 8.0;

class GameGrid extends HookConsumerWidget {
  final CurrentGameModel currentGame;
  final List<int>? winningLineValue;
  final AnimationController lineAnimation;
  final ValueChanged<int> onTap;

  const GameGrid({
    super.key,
    required this.currentGame,
    required this.winningLineValue,
    required this.lineAnimation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        padding: const EdgeInsets.all(_gridGap),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant, width: 1.2),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
            ],
          ),
        ),
        child: Stack(
          children: [
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: _gridGap,
                crossAxisSpacing: _gridGap,
              ),
              itemCount: currentGame.elements.length,
              itemBuilder: (context, index) {
                final value = currentGame.elements[index];
                final isFilled = value.isNotEmpty;
                final isFirst = value == currentGame.playerOne.emoticon;
                final textColor = isFirst ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.primary;

                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: (winningLineValue == null && value.isEmpty) ? () => onTap(index) : null,
                    child: Center(
                      child: AnimatedScale(
                        duration: const Duration(milliseconds: 150),
                        scale: isFilled ? 1 : 0.9,
                        child: Text(
                          value,
                          style: TextStyle(color: textColor, fontSize: 42, fontWeight: .w700),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            // Winning line animation
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedBuilder(
                  animation: lineAnimation,
                  builder: (context, child) => CustomPaint(
                    painter: WinningLinePainter(
                      combination: winningLineValue,
                      progress: lineAnimation.value,
                      gap: _gridGap,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
