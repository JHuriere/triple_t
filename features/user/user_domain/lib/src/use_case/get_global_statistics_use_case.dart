import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:user_domain/src/entity/statistics/global_user_statistics_entity.dart';
import 'package:user_domain/src/use_case/get_all_users_use_case.dart';

part 'get_global_statistics_use_case.g.dart';

@riverpod
List<GlobalUserStatisticsEntity> getGlobalStatisticsUseCase(Ref ref) {
  final users = ref.watch(getAllUsersUseCaseProvider);

  final userStats = users
      .map((user) {
        int totalWins = 0;
        int totalLosses = 0;
        int totalDraws = 0;

        if (user.statistics != null) {
          for (final stats in user.statistics!.values) {
            totalWins += stats.wins;
            totalLosses += stats.losses;
            totalDraws += stats.draws;
          }
        }

        final totalGames = totalWins + totalLosses + totalDraws;
        final winRate = totalGames > 0 ? (totalWins / totalGames * 100) : 0.0;

        return GlobalUserStatisticsEntity(
          user: user,
          totalWins: totalWins,
          totalLosses: totalLosses,
          totalDraws: totalDraws,
          totalGames: totalGames,
          winRate: winRate,
        );
      })
      .toList(growable: false);

  userStats.sort((a, b) => b.totalWins.compareTo(a.totalWins));
  return userStats;
}
