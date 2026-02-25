import 'package:user_data/src/data_source/user_data_source.dart';
import 'package:user_data/src/model/user_model.dart';
import 'package:user_domain/user_domain.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource dataSource;

  UserRepositoryImpl({required this.dataSource});

  @override
  Future<bool> exists(int id) {
    return dataSource.exists(id);
  }

  @override
  UserEntity? get(int id) {
    return dataSource.get(id)?.toEntity();
  }

  @override
  UserEntity? getByName(String name) {
    return dataSource.getByName(name)?.toEntity();
  }

  @override
  UserEntity? getByNameAndDifferentId(int id, String name) {
    return dataSource.getByNameAndDifferentId(id, name)?.toEntity();
  }

  @override
  List<UserEntity> getAll() {
    return dataSource.getAll().map((model) => model.toEntity()).toList(growable: false);
  }

  @override
  Future<UserEntity> upsert(UserEntity entity) async {
    final model = UserModel.fromEntity(entity);
    final updated = await dataSource.upsert(model);
    return updated.toEntity();
  }

  @override
  Future<void> delete(int id) async {
    await dataSource.delete(id);
  }

  @override
  Future<void> clearAll() async {
    await dataSource.clearAll();
  }
}
