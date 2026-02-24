import 'package:game_domain/game_domain.dart';
import 'package:user_domain/user_domain.dart';

// Test game entities
final testCurrentGameEntity = CurrentGameEntity(
  elements: List.filled(9, ''),
  state: CurrentGameState.inProgress,
  oTurn: true,
  playerOneId: 2,
  playerTwoId: 1,
);

// Test user entities
final testPlayerOne = UserEntity(
  id: 2,
  name: 'Alice',
  emoticon: '😊',
);

final testPlayerTwo = UserEntity(
  id: 1,
  name: 'AI',
  emoticon: '🤖',
);

final testPlayerThree = UserEntity(
  id: 3,
  name: 'Bob',
  emoticon: '😎',
);

// Empty user for testing
final testEmptyUser = UserEntity(
  id: 0,
  name: '',
  emoticon: '',
);

// Game states
final testGameWithWinner = testCurrentGameEntity.copyWith(
  elements: ['😊', '😊', '😊', '', '', '', '', '', ''],
  state: CurrentGameState.playerOneWon,
);

final testGameDraw = testCurrentGameEntity.copyWith(
  elements: ['😊', '🤖', '😊', '🤖', '😊', '🤖', '🤖', '😊', '🤖'],
  state: CurrentGameState.draw,
);

final testGameInProgress = testCurrentGameEntity.copyWith(
  elements: ['😊', '', '', '', '', '', '', '', ''],
  state: CurrentGameState.inProgress,
);

final testGameInitial = testCurrentGameEntity.copyWith(
  elements: List.filled(9, ''),
  state: CurrentGameState.initial,
);
