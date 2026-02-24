import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:user_domain/user_domain.dart';

part 'get_user_by_id_use_case.g.dart';

@riverpod
UserEntity? getUserByIdUseCase(Ref ref, int id) {
  return ref.watch(getUserRepositoryProvider).get(id);
}
