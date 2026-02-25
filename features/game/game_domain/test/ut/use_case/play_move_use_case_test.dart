import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_domain/src/service/game_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';

import '../repository/mock_current_game_repository.dart';

// Helper to mock the notifyGameResultUseCase
abstract class GameResultHandler {
  Future<void> notify({required int playerOneId, required int playerTwoId, required CurrentGameState state});
}

class MockGameResultHandler extends Mock implements GameResultHandler {
  @override
  Future<void> notify({required int? playerOneId, required int? playerTwoId, required CurrentGameState? state}) => 
    super.noSuchMethod(Invocation.method(#notify, [], {#playerOneId: playerOneId, #playerTwoId: playerTwoId, #state: state}), returnValue: Future<void>.value());
}

void main() {
  group('PlayMoveUseCase', () {
    late MockCurrentGameRepository mockRepository;
    late MockGameResultHandler mockNotifyHandler;
    late ProviderContainer container;
    late GameService gameService;

    setUp(() {
      mockRepository = MockCurrentGameRepository();
      mockNotifyHandler = MockGameResultHandler();
      gameService = GameService();
      
      container = ProviderContainer(
        overrides: [
          getCurrentGameRepositoryProvider.overrideWithValue(mockRepository),
          gameServiceProvider.overrideWithValue(gameService),
          notifyGameResultUseCaseProvider.overrideWith((ref, argument) {
             return mockNotifyHandler.notify(
               playerOneId: argument.playerOneId,
               playerTwoId: argument.playerTwoId,
               state: argument.state,
             );
          }),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('should play a standard move and flip oTurn', () async {
      // Arrange
      const initialGame = CurrentGameEntity(
        elements: ['', '', '', '', '', '', '', '', ''],
        state: CurrentGameState.initial,
        oTurn: true, 
      );

      when(mockRepository.get()).thenReturn(initialGame);
      when(mockRepository.save(any)).thenAnswer((inv) async => inv.positionalArguments[0] as CurrentGameEntity);

      // Act
      final result = await container.read(playMoveUseCaseProvider(index: 0, emoticon: '❌').future);

      // Assert
      expect(result.elements[0], '❌');
      expect(result.oTurn, false);
      expect(result.state, CurrentGameState.inProgress);
      verify(mockRepository.save(any)).called(1);
      verifyNever(mockNotifyHandler.notify(
        playerOneId: anyNamed('playerOneId'),
        playerTwoId: anyNamed('playerTwoId'),
        state: anyNamed('state'),
      ));
    });

    test('should win for Player One on the last move and notify', () async {
      // Arrange
      const initialGame = CurrentGameEntity(
        elements: ['X', 'X', '', 'O', 'O', '', '', '', ''],
        state: CurrentGameState.inProgress,
        oTurn: true,
        playerOneId: 1,
        playerTwoId: 2,
      );

      when(mockRepository.get()).thenReturn(initialGame);
      when(mockRepository.save(any)).thenAnswer((inv) async => inv.positionalArguments[0] as CurrentGameEntity);
      when(mockNotifyHandler.notify(
        playerOneId: anyNamed('playerOneId'),
        playerTwoId: anyNamed('playerTwoId'),
        state: anyNamed('state'),
      )).thenAnswer((_) async {});

      // Act
      final result = await container.read(playMoveUseCaseProvider(index: 2, emoticon: 'X').future);

      // Assert
      expect(result.elements[2], 'X');
      expect(result.state, CurrentGameState.playerOneWon);
      expect(result.playerOneWins, 1);
      
      verify(mockRepository.save(any)).called(1);
      
      // Verify notify call
      verify(mockNotifyHandler.notify(
        playerOneId: 1,
        playerTwoId: 2,
        state: CurrentGameState.playerOneWon,
      )).called(1);
    });

    test('should result in a draw and notify when board becomes full', () async {
      // Arrange
      const initialGame = CurrentGameEntity(
        elements: ['X', 'O', 'X', 'X', 'O', 'O', 'O', 'X', ''],
        state: CurrentGameState.inProgress,
        oTurn: true,
        playerOneId: 10,
        playerTwoId: 20,
      );

      when(mockRepository.get()).thenReturn(initialGame);
      when(mockRepository.save(any)).thenAnswer((inv) async => inv.positionalArguments[0] as CurrentGameEntity);
      when(mockNotifyHandler.notify(
        playerOneId: anyNamed('playerOneId'),
        playerTwoId: anyNamed('playerTwoId'),
        state: anyNamed('state'),
      )).thenAnswer((_) async {});

      // Act
      final result = await container.read(playMoveUseCaseProvider(index: 8, emoticon: 'X').future);

      // Assert
      expect(result.state, CurrentGameState.draw);
      expect(result.draws, 1);
      
      verify(mockNotifyHandler.notify(
        playerOneId: 10,
        playerTwoId: 20,
        state: CurrentGameState.draw,
      )).called(1);
    });

    test('should do nothing if square is already occupied', () async {
      // Arrange
      const initialGame = CurrentGameEntity(
        elements: ['X', '', '', '', '', '', '', '', ''],
        state: CurrentGameState.inProgress,
        oTurn: false,
      );

      when(mockRepository.get()).thenReturn(initialGame);

      // Act
      final result = await container.read(playMoveUseCaseProvider(index: 0, emoticon: 'O').future);

      // Assert
      expect(result, initialGame);
      verifyNever(mockRepository.save(any));
    });

    test('should do nothing if game is already finished', () async {
      // Arrange
      const initialGame = CurrentGameEntity(
        elements: ['X', 'X', 'X', 'O', 'O', '', '', '', ''],
        state: CurrentGameState.playerOneWon,
        oTurn: false,
      );

      when(mockRepository.get()).thenReturn(initialGame);

      // Act
      final result = await container.read(playMoveUseCaseProvider(index: 5, emoticon: 'O').future);

      // Assert
      expect(result, initialGame);
      verifyNever(mockRepository.save(any));
    });

    group('Regression tests', () {
      test('should preserve other properties', () async {
        // Arrange
        const initialGame = CurrentGameEntity(
          elements: ['', '', '', '', '', '', '', '', ''],
          state: CurrentGameState.initial,
          oTurn: true,
          playerOneWins: 5,
          playerTwoWins: 3,
          draws: 2,
        );

        when(mockRepository.get()).thenReturn(initialGame);
        when(mockRepository.save(any)).thenAnswer((inv) async => inv.positionalArguments[0] as CurrentGameEntity);

        // Act
        final result = await container.read(playMoveUseCaseProvider(index: 0, emoticon: 'X').future);

        // Assert
        expect(result.playerOneWins, 5);
        expect(result.playerTwoWins, 3);
        expect(result.draws, 2);
      });
    });
  });
}
