import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:user_domain/src/entity/statistics/statistics_entity.dart';
import 'package:user_domain/src/entity/user_entity.dart';
import 'package:user_domain/src/use_case/get_all_users_use_case.dart';
import 'package:user_domain/src/use_case/get_global_statistics_use_case.dart';

void main() {
  group('getGlobalStatisticsUseCaseProvider', () {
    test('should calculate statistics and sort by total wins descending', () {
      // Arrange
      final user1 = UserEntity(
        id: 1,
        name: 'User 1',
        emoticon: '😊',
        statistics: {
          1: const StatisticsEntity(wins: 5, losses: 2, draws: 1),
          2: const StatisticsEntity(wins: 3, losses: 1, draws: 0),
        },
      ); // 8 wins, 3 losses, 1 draw, 12 total, (8/12)*100 = 66.6%

      final user2 = UserEntity(
        id: 2,
        name: 'User 2',
        emoticon: '🎮',
        statistics: {
          1: const StatisticsEntity(wins: 10, losses: 5, draws: 2),
        },
      ); // 10 wins, 5 losses, 2 draws, 17 total, (10/17)*100 = 58.8%

      final user3 = UserEntity(
        id: 3,
        name: 'User 3',
        emoticon: '🎲',
        statistics: null,
      ); // 0 wins

      final container = ProviderContainer(
        overrides: [
          getAllUsersUseCaseProvider.overrideWithValue([user1, user2, user3]),
        ],
      );

      // Act
      final result = container.read(getGlobalStatisticsUseCaseProvider);

      // Assert
      expect(result.length, equals(3));

      // User 2 has 10 wins, should be first
      expect(result[0].user, equals(user2));
      expect(result[0].totalWins, equals(10));
      expect(result[0].totalLosses, equals(5));
      expect(result[0].totalDraws, equals(2));
      expect(result[0].totalGames, equals(17));
      expect(result[0].winRate, closeTo(58.82, 0.01));

      // User 1 has 8 wins, should be second
      expect(result[1].user, equals(user1));
      expect(result[1].totalWins, equals(8));
      expect(result[1].totalLosses, equals(3));
      expect(result[1].totalDraws, equals(1));
      expect(result[1].totalGames, equals(12));
      expect(result[1].winRate, closeTo(66.66, 0.01));

      // User 3 has 0 wins, should be third
      expect(result[2].user, equals(user3));
      expect(result[2].totalWins, equals(0));
      expect(result[2].totalGames, equals(0));
      expect(result[2].winRate, equals(0.0));
    });
  });
}
