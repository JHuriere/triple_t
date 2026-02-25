import 'package:game_domain/game_domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notify_game_result_use_case.g.dart';

@riverpod
Future<void> notifyGameResultUseCase(
  Ref ref, {
  required int playerOneId,
  required int playerTwoId,
  required CurrentGameState state,
}) {
  throw UnimplementedError('notifyGameResultUseCase must be overridden in the app layer');
}
