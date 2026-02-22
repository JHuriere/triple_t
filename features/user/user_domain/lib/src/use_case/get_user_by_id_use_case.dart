import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:user_data/user_data.dart';
import 'package:user_domain/src/model/user_model.dart';

part 'get_user_by_id_use_case.g.dart';

@riverpod
UserModel? getUserByIdUseCase(Ref ref, int id) {
  final entity = ref.watch(userRepositoryProvider).get(id);
  if (entity == null) {
    return null;
  }
  return UserModel.fromEntity(entity: entity);
}
