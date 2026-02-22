import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:user_data/user_data.dart';
import 'package:user_domain/src/model/user_model.dart';

part 'create_user_use_case.g.dart';

@riverpod
Future<bool> createUserUseCase(Ref ref, UserModel user) async {
  final existingUser = ref.watch(userRepositoryProvider).getByName(user.name);
  if (existingUser != null) {
    return false; // Name already exists, return false to indicate failure
  }

  final userRepository = ref.watch(userRepositoryProvider);
  await userRepository.upsert(user.toEntity());
  return true; // User created successfully
}
