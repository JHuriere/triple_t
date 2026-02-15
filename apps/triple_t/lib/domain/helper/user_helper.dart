class UserHelper {
  static bool canRemoveUser(int userId) {
    return userId != 1 && userId != 2 && userId != 3;
  }
}
