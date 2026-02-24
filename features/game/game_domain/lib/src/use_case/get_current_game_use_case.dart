import 'package:game_domain/game_domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_current_game_use_case.g.dart';

@riverpod
CurrentGameEntity getCurrentGameUseCase(Ref ref) {
  final repository = ref.watch(getCurrentGameRepositoryProvider);

  return repository.get();
}
