import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triple_t/data/repository/user_repository.dart';
import 'package:triple_t/domain/model/user/user_model.dart';

part 'get_user_by_id_use_case.g.dart';

@riverpod
UserModel? getUserByIdUseCase(Ref ref, int id) {
  final entity = ref.watch(userRepositoryProvider).get(id);
  if (entity == null) {
    return null;
  }
  return UserModel.fromEntity(entity: entity);
}
