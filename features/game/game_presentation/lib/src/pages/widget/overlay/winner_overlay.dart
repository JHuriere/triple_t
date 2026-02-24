import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tt_i18n/i18n.dart';

class WinnerOverlay extends HookWidget {
  final String winner;
  final VoidCallback onDismiss;

  const WinnerOverlay({
    super.key,
    required this.winner,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final confettiController = useState<ConfettiController?>(null);

    useEffect(() {
      final controller = ConfettiController(duration: const Duration(seconds: 3));
      confettiController.value = controller;
      controller.play();

      return () => controller.dispose();
    }, []);

    return Material(
      color: Colors.black.withValues(alpha: 0.6),
      child: Stack(
        children: [
          if (confettiController.value != null) ...[
            _TopCenterConfetti(confettiController: confettiController.value!),
            _TopLeftConfetti(confettiController: confettiController.value!),
            _TopRightConfetti(confettiController: confettiController.value!),
          ],

          // Victory card
          Center(
            child: Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: .min,
                children: [
                  Text(
                    context.l10n.victory,
                    style: const TextStyle(fontSize: 36, fontWeight: .bold, color: Colors.green),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    context.l10n.playerWon(winner),
                    style: const TextStyle(fontSize: 28, fontWeight: .w600, color: Colors.black87),
                    textAlign: .center,
                  ),
                  const SizedBox(height: 32),

                  ElevatedButton(
                    onPressed: onDismiss,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const .symmetric(horizontal: 40, vertical: 12),
                    ),
                    child: Text(
                      context.l10n.playAgain,
                      style: const TextStyle(fontSize: 16, fontWeight: .bold, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopRightConfetti extends StatelessWidget {
  const _TopRightConfetti({
    required ConfettiController confettiController,
  }) : _confettiController = confettiController;

  final ConfettiController _confettiController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: ConfettiWidget(
        confettiController: _confettiController,
        blastDirection: 2.356,
        particleDrag: 0.05,
        emissionFrequency: 0.05,
        numberOfParticles: 10,
        gravity: 0.3,
        shouldLoop: false,
        colors: const [
          Colors.red,
          Colors.blue,
          Colors.green,
          Colors.yellow,
          Colors.purple,
          Colors.orange,
        ],
      ),
    );
  }
}

class _TopLeftConfetti extends StatelessWidget {
  const _TopLeftConfetti({
    required ConfettiController confettiController,
  }) : _confettiController = confettiController;

  final ConfettiController _confettiController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: ConfettiWidget(
        confettiController: _confettiController,
        blastDirection: 0.785,
        particleDrag: 0.05,
        emissionFrequency: 0.05,
        numberOfParticles: 10,
        gravity: 0.3,
        shouldLoop: false,
        colors: const [
          Colors.red,
          Colors.blue,
          Colors.green,
          Colors.yellow,
          Colors.purple,
          Colors.orange,
        ],
      ),
    );
  }
}

class _TopCenterConfetti extends StatelessWidget {
  const _TopCenterConfetti({
    required ConfettiController confettiController,
  }) : _confettiController = confettiController;

  final ConfettiController _confettiController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        confettiController: _confettiController,
        blastDirection: 1.57,
        particleDrag: 0.05,
        emissionFrequency: 0.03,
        numberOfParticles: 20,
        gravity: 0.3,
        shouldLoop: false,
        colors: const [
          Colors.red,
          Colors.blue,
          Colors.green,
          Colors.yellow,
          Colors.purple,
          Colors.orange,
          Colors.pink,
          Colors.teal,
        ],
      ),
    );
  }
}
