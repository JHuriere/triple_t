import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:user_domain/src/entity/user_entity.dart';
import 'package:user_domain/src/repository/get_user_repository.dart';

part 'create_user_use_case.g.dart';

@riverpod
Future<bool> createUserUseCase(Ref ref, UserEntity user) async {
  final userRepository = ref.watch(getUserRepositoryProvider);

  final existingUser = userRepository.getByName(user.name);
  if (existingUser != null) {
    return false; // Name already exists, return false to indicate failure
  }

  await userRepository.upsert(user);
  return true; // User created successfully
}
