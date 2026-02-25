import 'package:game_data/src/data_source/current_game_data_source.dart';
import 'package:game_data/src/model/current_game_model.dart';
import 'package:game_domain/game_domain.dart';

class CurrentGameRepositoryImpl implements CurrentGameRepository {
  final CurrentGameDataSource dataSource;

  CurrentGameRepositoryImpl({required this.dataSource});

  @override
  CurrentGameEntity get() {
    return dataSource.get().toEntity();
  }

  @override
  Future<CurrentGameEntity> save(CurrentGameEntity settings) async {
    final model = CurrentGameModel.fromEntity(settings);
    final updated = await dataSource.save(model);
    return updated.toEntity();
  }

  @override
  Future<void> clearAll() async {
    await dataSource.clearAll();
  }
}
