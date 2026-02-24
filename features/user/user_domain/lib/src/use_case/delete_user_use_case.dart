import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:user_domain/src/repository/get_user_repository.dart';

part 'delete_user_use_case.g.dart';

@riverpod
Future<void> deleteUserUseCase(Ref ref, int id) async {
  final userRepository = ref.watch(getUserRepositoryProvider);
  await userRepository.delete(id);
}
