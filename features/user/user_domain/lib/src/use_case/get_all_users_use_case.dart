import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:user_domain/src/entity/user_entity.dart';
import 'package:user_domain/src/repository/get_user_repository.dart';

part 'get_all_users_use_case.g.dart';

@riverpod
List<UserEntity> getAllUsersUseCase(Ref ref) {
  return ref.watch(getUserRepositoryProvider).getAll();
}
