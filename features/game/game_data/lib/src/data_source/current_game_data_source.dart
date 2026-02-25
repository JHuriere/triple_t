import 'package:game_data/src/model/current_game_model.dart';

abstract class CurrentGameDataSource {
  CurrentGameModel get();
  Future<CurrentGameModel> save(CurrentGameModel model);
  Future<void> clearAll();
}
