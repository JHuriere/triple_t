import 'package:game_domain/src/entity/current_game_entity.dart';

abstract class CurrentGameRepository {
  static const String storeName = 'currentGame';
  static const String settingsKey = 'currentGame';

  /// Returns the current game settings. If no settings are found, returns default settings.
  CurrentGameEntity get();

  /// Saves the current game settings.
  Future<CurrentGameEntity> save(CurrentGameEntity settings);

  /// Clears all current game settings from the database.
  Future<void> clearAll();
}
