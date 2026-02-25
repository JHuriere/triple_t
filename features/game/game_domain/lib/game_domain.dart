library;

// Entities
export 'package:game_domain/src/entity/current_game_entity.dart';
// Repositories
export 'package:game_domain/src/repository/current_game_repository.dart';
export 'package:game_domain/src/repository/get_current_game_repository.dart' show getCurrentGameRepositoryProvider;
// Use cases
export 'package:game_domain/src/use_case/get_current_game_use_case.dart';
export 'package:game_domain/src/use_case/reset_current_game_use_case.dart';
export 'package:game_domain/src/use_case/play_move_use_case.dart';
export 'package:game_domain/src/use_case/notify_game_result_use_case.dart';
export 'package:game_domain/src/use_case/update_current_game_player_use_case.dart';
// Services
export 'package:game_domain/src/service/game_service.dart' show gameServiceProvider;
