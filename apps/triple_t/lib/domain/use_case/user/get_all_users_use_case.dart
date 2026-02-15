import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triple_t/data/repository/user_repository.dart';
import 'package:triple_t/domain/model/user/user_model.dart';

part 'get_all_users_use_case.g.dart';

@riverpod
List<UserModel> getAllUsersUseCase(Ref ref) {
  final entities = ref.watch(userRepositoryProvider).getAll();
  return entities.map((entity) => UserModel.fromEntity(entity: entity)).toList();
}
