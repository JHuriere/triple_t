// create user use case
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triple_t/data/repository/user_repository.dart';

part 'delete_user_use_case.g.dart';

@riverpod
Future<void> deleteUserUseCase(Ref ref, int id) async {
  final userRepository = ref.watch(userRepositoryProvider);
  await userRepository.delete(id);
}
