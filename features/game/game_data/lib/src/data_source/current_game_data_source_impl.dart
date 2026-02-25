import 'package:game_data/src/data_source/current_game_data_source.dart';
import 'package:game_data/src/model/current_game_model.dart';
import 'package:tt_database/tt_database.dart';

class CurrentGameDataSourceImpl implements CurrentGameDataSource {
  static const String storeName = 'currentGame';
  static const String settingsKey = 'currentGame';

  late final StoreRef<String, Map<String, Object?>> _store = stringMapStoreFactory.store(storeName);
  final Database db;

  CurrentGameDataSourceImpl({required this.db});

  @override
  CurrentGameModel get() {
    final record = _store.record(settingsKey);
    final data = record.getSync(db);

    if (data != null) {
      return CurrentGameModel.fromJson(data.cast<String, dynamic>());
    }
    return const CurrentGameModel();
  }

  @override
  Future<CurrentGameModel> save(CurrentGameModel model) async {
    final record = _store.record(settingsKey);
    final updated = await record.put(db, model.toJson());
    return CurrentGameModel.fromJson(updated.cast<String, dynamic>());
  }

  @override
  Future<void> clearAll() async {
    await _store.drop(db);
  }
}
