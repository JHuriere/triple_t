import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/src/pages/painter/winning_line_painter.dart';
import 'package:game_presentation/src/pages/view_model/result_view_model.dart';
import 'package:game_presentation/src/pages/view_model/state/result_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const _gridGap = 8.0;

class GameGrid extends HookConsumerWidget {
  // final AnimationController lineAnimation;
  final CurrentGameEntity currentGame;
  final String playerOneEmoticon;
  final ValueChanged<int> onTap;

  const GameGrid({
    super.key,
    required this.currentGame,
    required this.playerOneEmoticon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultState = ref.watch(resultViewModelProvider);

    final lineAnimation = useAnimationController(duration: const Duration(milliseconds: 450));

    useEffect(() {
      if (resultState case WinnerResultState()) lineAnimation.forward(from: 0);
      if (resultState case InitialResultState()) lineAnimation.reset();
      return null;
    }, [resultState]);

    useEffect(() {
      void listener(AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          if (resultState case WinnerResultState()) {
             Future.delayed(const Duration(milliseconds: 500), () => ref.read(resultViewModelProvider.notifier).setShowOverlay(true));
          }
        }
      }

      lineAnimation.addStatusListener(listener);
      return () => lineAnimation.removeStatusListener(listener);
    }, [resultState]);

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
                final isFirst = value == playerOneEmoticon;
                final textColor = isFirst ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.primary;

                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: value.isEmpty ? () => onTap(index) : null,
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
            if (resultState case WinnerResultState())
              Positioned.fill(
                child: IgnorePointer(
                  child: AnimatedBuilder(
                    animation: lineAnimation,
                    builder: (context, child) => CustomPaint(
                      painter: WinningLinePainter(
                        combination: resultState.winningLine,
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
