// user statistics page

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:triple_t/domain/use_case/user/get_all_users_use_case.dart';
import 'package:triple_t/domain/use_case/user/get_user_by_id_use_case.dart';
import 'package:triple_t/presentation/pages/user_list/statistics/widget/no_statistics.dart';
import 'package:triple_t/presentation/pages/user_list/statistics/widget/opponent_statistics.dart';
import 'package:triple_t/presentation/pages/user_list/statistics/widget/overall_statistics.dart';

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
        appBar: AppBar(title: const Text('Statistics')),
        body: const Center(child: Text('User not found')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${user.emoticon} ${user.name} - Statistics'),
      ),
      body: user.statistics == null || user.statistics!.isEmpty
          ? NoStatistics()
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                OverallStatistics(statistics: user.statistics!),
                const SizedBox(height: 24),

                const Divider(),
                const SizedBox(height: 16),

                Text(
                  'Statistics by opponent',
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
