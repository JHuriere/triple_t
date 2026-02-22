import 'package:tt_database/tt_database.dart';
import 'package:user_data/user_data.dart';

class Data {
  static Future<void> init() async {
    await TripleTDatabase.instance.openDatabase();
    await initializeDefaultUsers();
  }
}
