import 'package:flutter/material.dart';
import 'package:tt_i18n/i18n.dart';

class NoStatistics extends StatelessWidget {
  const NoStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.leaderboard, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            context.l10n.noStatisticsAvailable,
            textAlign: .center,
            style: const TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.playSomeGamesSeeLeaderboard,
            textAlign: .center,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
