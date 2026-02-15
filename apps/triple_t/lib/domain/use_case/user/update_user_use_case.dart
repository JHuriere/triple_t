// create user use case
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triple_t/data/repository/user_repository.dart';
import 'package:triple_t/domain/model/user/user_model.dart';

part 'update_user_use_case.g.dart';

@riverpod
Future<bool> updateUserUseCase(Ref ref, {required UserModel user}) async {
  final existingUser = ref.watch(userRepositoryProvider).getByNameAndDifferentId(user.id, user.name);
  if (existingUser != null) {
    return false; // Name already exists, return false to indicate failure
  }

  final userRepository = ref.watch(userRepositoryProvider);
  await userRepository.upsert(user.toEntity());
  return true; // User updated successfully
}
