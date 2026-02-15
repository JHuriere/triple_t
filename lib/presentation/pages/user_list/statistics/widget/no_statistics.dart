import 'package:flutter/material.dart';

class NoStatistics extends StatelessWidget {
  const NoStatistics({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          Icon(Icons.bar_chart, size: 64, color: Colors.grey),
          SizedBox(height: 16),

          Text(
            'No statistics available yet',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          SizedBox(height: 8),

          Text(
            'Play some games to see statistics!',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
