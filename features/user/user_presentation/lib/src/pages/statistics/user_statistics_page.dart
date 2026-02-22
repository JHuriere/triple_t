import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tt_i18n/i18n.dart';
import 'package:user_domain/user_domain.dart';
import 'package:user_presentation/src/pages/statistics/widget/no_statistics.dart';
import 'package:user_presentation/src/pages/statistics/widget/opponent_statistics.dart';
import 'package:user_presentation/src/pages/statistics/widget/overall_statistics.dart';

class UserStatisticsPage extends HookConsumerWidget {
  final int userId;

  const UserStatisticsPage({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(getUserByIdUseCaseProvider(userId));
    final allUsers = ref.watch(getAllUsersUseCaseProvider);

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: Text(context.l10n.statistics)),
        body: Center(child: Text(context.l10n.userNotFound)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${user.emoticon} ${user.name} - ${context.l10n.statistics}'),
      ),
      body: user.statistics == null || user.statistics!.isEmpty
          ? const NoStatistics()
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                OverallStatistics(statistics: user.statistics!),
                const SizedBox(height: 24),

                const Divider(),
                const SizedBox(height: 16),

                Text(
                  context.l10n.statisticsByOpponent,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ...user.statistics!.entries.map((entry) {
                  final opponentId = entry.key;
                  final stats = entry.value;
                  final opponent = allUsers.firstWhere((u) => u.id == opponentId, orElse: () => allUsers.first);

                  return OpponentStatistics(
                    opponentName: opponent.name,
                    opponentEmoticon: opponent.emoticon,
                    stats: stats,
                  );
                }),
              ],
            ),
    );
  }
}
