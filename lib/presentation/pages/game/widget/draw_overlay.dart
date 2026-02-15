import 'package:flutter/material.dart';

class DrawOverlay extends StatelessWidget {
  final VoidCallback onDismiss;

  const DrawOverlay({
    super.key,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.6),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: .min,
            children: [
              const Text(
                '🤝 Draw! 🤝',
                style: TextStyle(fontSize: 36, fontWeight: .bold, color: Colors.blue),
              ),
              const SizedBox(height: 16),

              const Text(
                'The game ended in a draw.',
                style: TextStyle(fontSize: 20, fontWeight: .w600, color: Colors.black87),
                textAlign: .center,
              ),
              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: onDismiss,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: const Text(
                  'Play Again',
                  style: TextStyle(fontSize: 16, fontWeight: .bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
