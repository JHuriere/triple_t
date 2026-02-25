import 'package:flutter/material.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/src/pages/view/game_view.dart';
import 'package:game_presentation/src/pages/view/overlay_view.dart';
import 'package:game_presentation/src/pages/view_model/current_game_view_model.dart';
import 'package:game_presentation/src/pages/view_model/result_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tt_i18n/i18n.dart';

class GamePage extends HookConsumerWidget {
  const GamePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultState = ref.watch(resultViewModelProvider);

    void resetGame() async {
      try {
        await ref.read(resetCurrentGameUseCaseProvider.future);
        ref.invalidate(resultViewModelProvider);
        ref.invalidate(getCurrentGameUseCaseProvider);
      } catch (e) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${context.l10n.error} : $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.ticTacToe),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: resetGame,
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          GameView(
            onTap: (index) => _onTap(context, ref, index),
          ),
          OverlayView(
            showOverlay: resultState.showOverlay,
            onDismiss: resetGame,
          ),
        ],
      ),
    );
  }

  Future<void> _onTap(BuildContext context, WidgetRef ref, int index) async {
    try {
      await ref.read(currentGameViewModelProvider.notifier).playTurn(index);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${context.l10n.error} : $e'),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
