import 'package:flutter/material.dart';
import 'package:tt_i18n/i18n.dart';

class NoStatistics extends StatelessWidget {
  const NoStatistics({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const .symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Icon(Icons.bar_chart, size: 64, color: Colors.grey),
            const SizedBox(height: 16),

            Text(
              context.l10n.noStatisticsAvailable,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
              textAlign: .center,
            ),
            const SizedBox(height: 8),

            Text(
              context.l10n.playSomeGamesSeeStatistics,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: .center,
            ),
          ],
        ),
      ),
    );
  }
}
