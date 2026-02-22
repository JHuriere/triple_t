import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:user_data/user_data.dart';
import 'package:user_domain/src/model/user_model.dart';

part 'get_all_users_use_case.g.dart';

@riverpod
List<UserModel> getAllUsersUseCase(Ref ref) {
  final entities = ref.watch(userRepositoryProvider).getAll();
  return entities.map((entity) => UserModel.fromEntity(entity: entity)).toList();
}
