import 'package:game_data/src/entity/current_game_entity.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tt_database/tt_database.dart';

final currentGameRepositoryProvider = Provider.autoDispose<_CurrentGameRepository>((ref) => _CurrentGameRepository(ref: ref));

class _CurrentGameRepository {
  static const String _storeName = 'currentGame';
  static const String _settingsKey = 'currentGame';

  final Ref ref;
  late final StoreRef<String, Map<String, Object?>> _store = stringMapStoreFactory.store(_storeName);

  _CurrentGameRepository({required this.ref});

  CurrentGameEntity get() {
    final record = _store.record(_settingsKey);
    final data = record.getSync(TripleTDatabase.instance.db);

    if (data != null) {
      return CurrentGameEntity.fromJson(data.cast<String, dynamic>());
    }
    return CurrentGameEntity();
  }

  Future<void> save(CurrentGameEntity settings) async {
    final record = _store.record(_settingsKey);
    await record.put(TripleTDatabase.instance.db, settings.toJson());
  }

  Future<void> clearAll() async {
    await _store.drop(TripleTDatabase.instance.db);
  }
}
