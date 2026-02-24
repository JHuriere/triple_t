import 'package:user_domain/user_domain.dart';

class UserStatsModel {
  final int totalDraws;
  final int totalGames;
  final int totalLosses;
  final int totalWins;
  final UserEntity user;
  final double winRate;

  UserStatsModel({
    required this.totalDraws,
    required this.totalGames,
    required this.totalLosses,
    required this.totalWins,
    required this.user,
    required this.winRate,
  });
}
