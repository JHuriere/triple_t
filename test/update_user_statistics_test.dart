import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:triple_t/data/data.dart';
import 'package:triple_t/data/entity/game/current_game_entity.dart';
import 'package:triple_t/data/repository/current_game_repository.dart';
import 'package:triple_t/data/repository/user_repository.dart';
import 'package:triple_t/domain/model/user/user_model.dart';
import 'package:triple_t/domain/use_case/user/update_user_statistics_use_case.dart';

void main() {
  group('Update User Statistics Tests', () {
    setUpAll(() async {
      // Initialize Flutter binding
      TestWidgetsFlutterBinding.ensureInitialized();

      // Initialize database
      await Data.init();
    });

    test('Should update statistics for player one after wins', () async {
      final container = ProviderContainer();
      final userRepo = container.read(userRepositoryProvider);
      final currentGameRepo = container.read(currentGameRepositoryProvider);

      // Get initial users
      final users = userRepo.getAll();
      expect(users.length, greaterThanOrEqualTo(2));

      final playerOneId = users[0].id;
      final playerTwoId = users[1].id;

      // Setup a game with player one winning
      await currentGameRepo.save(
        CurrentGameEntity(
          playerOneId: playerOneId,
          playerTwoId: playerTwoId,
          playerOneWins: 3,
          playerTwoWins: 1,
          draws: 2,
        ),
      );

      // Update statistics for player one
      await container.read(updateUserStatisticsUseCaseProvider(id: playerOneId).future);

      // Verify player one statistics
      final playerOneEntity = userRepo.get(playerOneId);
      expect(playerOneEntity, isNotNull);

      final playerOne = UserModel.fromEntity(entity: playerOneEntity!);
      expect(playerOne.statistics, isNotNull);
      expect(playerOne.statistics![playerTwoId], isNotNull);
      expect(playerOne.statistics![playerTwoId]!.wins, 3);
      expect(playerOne.statistics![playerTwoId]!.losses, 1);
      expect(playerOne.statistics![playerTwoId]!.draws, 2);

      container.dispose();
    });

    test('Should update statistics for player two after wins', () async {
      final container = ProviderContainer();
      final userRepo = container.read(userRepositoryProvider);
      final currentGameRepo = container.read(currentGameRepositoryProvider);

      // Get initial users
      final users = userRepo.getAll();
      expect(users.length, greaterThanOrEqualTo(2));

      final playerOneId = users[0].id;
      final playerTwoId = users[1].id;

      // Setup a game with player two winning
      await currentGameRepo.save(
        CurrentGameEntity(
          playerOneId: playerOneId,
          playerTwoId: playerTwoId,
          playerOneWins: 2,
          playerTwoWins: 5,
          draws: 1,
        ),
      );

      // Update statistics for player two
      await container.read(updateUserStatisticsUseCaseProvider(id: playerTwoId).future);

      // Verify player two statistics
      final playerTwoEntity = userRepo.get(playerTwoId);
      expect(playerTwoEntity, isNotNull);

      final playerTwo = UserModel.fromEntity(entity: playerTwoEntity!);
      expect(playerTwo.statistics, isNotNull);
      expect(playerTwo.statistics![playerOneId], isNotNull);
      expect(playerTwo.statistics![playerOneId]!.wins, 5);
      expect(playerTwo.statistics![playerOneId]!.losses, 2);
      expect(playerTwo.statistics![playerOneId]!.draws, 1);

      container.dispose();
    });

    test('Should update statistics for both players', () async {
      final container = ProviderContainer();
      final userRepo = container.read(userRepositoryProvider);
      final currentGameRepo = container.read(currentGameRepositoryProvider);

      // Get initial users
      final users = userRepo.getAll();
      expect(users.length, greaterThanOrEqualTo(2));

      final playerOneId = users[0].id;
      final playerTwoId = users[1].id;

      // Setup a game with some draws
      await currentGameRepo.save(
        CurrentGameEntity(
          playerOneId: playerOneId,
          playerTwoId: playerTwoId,
          playerOneWins: 4,
          playerTwoWins: 3,
          draws: 5,
        ),
      );

      // Update statistics for both players
      await container.read(updateUserStatisticsUseCaseProvider(id: playerOneId).future);
      await container.read(updateUserStatisticsUseCaseProvider(id: playerTwoId).future);

      // Verify player one statistics
      final playerOneEntity = userRepo.get(playerOneId);
      final playerOne = UserModel.fromEntity(entity: playerOneEntity!);
      expect(playerOne.statistics![playerTwoId]!.wins, 4);
      expect(playerOne.statistics![playerTwoId]!.losses, 3);
      expect(playerOne.statistics![playerTwoId]!.draws, 5);

      // Verify player two statistics (mirror of player one)
      final playerTwoEntity = userRepo.get(playerTwoId);
      final playerTwo = UserModel.fromEntity(entity: playerTwoEntity!);
      expect(playerTwo.statistics![playerOneId]!.wins, 3);
      expect(playerTwo.statistics![playerOneId]!.losses, 4);
      expect(playerTwo.statistics![playerOneId]!.draws, 5);

      container.dispose();
    });
  });
}
