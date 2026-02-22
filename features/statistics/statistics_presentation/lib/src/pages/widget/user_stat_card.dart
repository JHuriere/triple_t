import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tt_i18n/i18n.dart';
import 'package:user_domain/user_domain.dart';

class UserStatCard extends StatelessWidget {
  final int rank;
  final UserModel user;
  final int totalWins;
  final int totalLosses;
  final int totalDraws;
  final int totalGames;
  final double winRate;

  const UserStatCard({
    super.key,
    required this.rank,
    required this.user,
    required this.totalWins,
    required this.totalLosses,
    required this.totalDraws,
    required this.totalGames,
    required this.winRate,
  });

  @override
  Widget build(BuildContext context) {
    Color rankColor;
    IconData rankIcon;

    switch (rank) {
      case 1:
        rankColor = Colors.amber;
        rankIcon = Icons.emoji_events;
        break;
      case 2:
        rankColor = Colors.grey;
        rankIcon = Icons.emoji_events;
        break;
      case 3:
        rankColor = Colors.brown;
        rankIcon = Icons.emoji_events;
        break;
      default:
        rankColor = Colors.blueGrey;
        rankIcon = Icons.person;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => context.pushNamed('user-statistics', pathParameters: {'id': user.id.toString()}),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              _Rank(
                rankColor: rankColor,
                rank: rank,
                rankIcon: rankIcon,
              ),
              const SizedBox(width: 16),

              _UserInfo(
                user: user,
                totalGames: totalGames,
                winRate: winRate,
              ),

              _Stats(
                totalWins: totalWins,
                totalLosses: totalLosses,
                totalDraws: totalDraws,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Stats extends StatelessWidget {
  const _Stats({
    required this.totalWins,
    required this.totalLosses,
    required this.totalDraws,
  });

  final int totalWins;
  final int totalLosses;
  final int totalDraws;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            const Icon(
              Icons.check_circle,
              size: 16,
              color: Colors.green,
            ),
            const SizedBox(width: 4),
            Text(
              '$totalWins',
              style: const TextStyle(fontWeight: .bold, color: Colors.green),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(
              Icons.cancel,
              size: 16,
              color: Colors.red,
            ),
            const SizedBox(width: 4),
            Text(
              '$totalLosses',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(
              Icons.remove_circle,
              size: 16,
              color: Colors.orange,
            ),
            const SizedBox(width: 4),
            Text(
              '$totalDraws',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _UserInfo extends StatelessWidget {
  const _UserInfo({
    required this.user,
    required this.totalGames,
    required this.winRate,
  });

  final UserModel user;
  final int totalGames;
  final double winRate;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                user.emoticon,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 8),
              Text(
                user.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            context.l10n.gamesWinRate(
              totalGames,
              double.parse(winRate.toStringAsFixed(1)),
            ),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class _Rank extends StatelessWidget {
  const _Rank({
    required this.rankColor,
    required this.rank,
    required this.rankIcon,
  });

  final Color rankColor;
  final int rank;
  final IconData rankIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: rankColor.withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: rank <= 3
            ? Icon(rankIcon, color: rankColor, size: 24)
            : Text(
                '$rank',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: rankColor,
                  fontSize: 16,
                ),
              ),
      ),
    );
  }
}
