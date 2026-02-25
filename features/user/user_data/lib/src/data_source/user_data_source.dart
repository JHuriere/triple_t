import 'package:user_data/src/model/user_model.dart';

abstract class UserDataSource {
  Future<bool> exists(int id);
  UserModel? get(int id);
  UserModel? getByName(String name);
  UserModel? getByNameAndDifferentId(int id, String name);
  List<UserModel> getAll();
  Future<UserModel> upsert(UserModel model);
  Future<void> delete(int id);
  Future<void> clearAll();
}
