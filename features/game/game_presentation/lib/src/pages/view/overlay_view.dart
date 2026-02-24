import 'package:flutter/material.dart';
import 'package:game_presentation/src/pages/view_model/result_view_model.dart';
import 'package:game_presentation/src/pages/view_model/state/result_state.dart';
import 'package:game_presentation/src/pages/widget/overlay/draw_overlay.dart';
import 'package:game_presentation/src/pages/widget/overlay/winner_overlay.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OverlayView extends HookConsumerWidget {
  final ValueNotifier<bool> showOverlay;
  final VoidCallback onDismiss;

  const OverlayView({
    super.key,
    required this.showOverlay,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultState = ref.watch(resultViewModelProvider);

    if (showOverlay.value) {
      if (resultState case WinnerResultState()) {
        return WinnerOverlay(winner: resultState.winner, onDismiss: onDismiss);
      } else if (resultState case DrawResultState()) {
        return DrawOverlay(onDismiss: onDismiss);
      }
    }
    return const SizedBox.shrink();
  }
}
