import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:user_domain/src/repository/get_user_repository.dart';
import 'package:user_domain/user_domain.dart';

part 'update_user_use_case.g.dart';

@riverpod
Future<bool> updateUserUseCase(Ref ref, {required UserEntity user}) async {
  final userRepository = ref.watch(getUserRepositoryProvider);

  final existingUser = userRepository.getByNameAndDifferentId(user.id, user.name);
  if (existingUser != null) {
    return false; // Name already exists, return false to indicate failure
  }

  await userRepository.upsert(user);
  return true; // User updated successfully
}
