import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sembast/sembast_io.dart';
import 'package:triple_t/data/core/triple_t_database.dart';
import 'package:triple_t/data/entity/game/current_game_entity.dart';

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
