import 'package:user_domain/src/entity/user_entity.dart';

abstract class UserRepository {

  Future<bool> exists(int id);

  UserEntity? get(int id);

  UserEntity? getByName(String name);

  UserEntity? getByNameAndDifferentId(int id, String name);

  List<UserEntity> getAll();

  Future<UserEntity> upsert(UserEntity entity);

  Future<void> delete(int id);

  Future<void> clearAll();
}
