import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    final canPlay = useState<bool>(true);
    final showOverlay = useState<bool>(false);

    void resetGame() async {
      canPlay.value = true;
      showOverlay.value = false;
      await ref.read(resetCurrentGameUseCaseProvider.future);
      ref.invalidate(resultViewModelProvider);
      ref.invalidate(getCurrentGameUseCaseProvider);
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
        fit: .expand,
        children: [
          GameView(
            showOverlay: showOverlay,
            onTap: (index) => canPlay.value ? _onTap(ref, index, canPlay, showOverlay) : null,
          ),
          OverlayView(
            showOverlay: showOverlay,
            onDismiss: resetGame,
          ),
        ],
      ),
    );
  }

  Future<void> _onTap(
    WidgetRef ref,
    int index,
    ValueNotifier<bool> canPlay,
    ValueNotifier<bool> showOverlay,
  ) async {
    canPlay.value = false;

    try {
      await ref.read(currentGameViewModelProvider.notifier).playNextMove(index);
      await ref.read(resultViewModelProvider.notifier).checkResult(showOverlay);

      final played = await ref.read(currentGameViewModelProvider.notifier).playNextAIMove();
      if (played) await ref.read(resultViewModelProvider.notifier).checkResult(showOverlay);
    } finally {
      canPlay.value = true;
    }
  }
}
