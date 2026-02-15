// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_game_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentGameEntity _$CurrentGameEntityFromJson(Map<String, dynamic> json) =>
    CurrentGameEntity(
      elements:
          (json['elements'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const ['', '', '', '', '', '', '', '', ''],
      state:
          $enumDecodeNullable(_$CurrentGameStateEnumMap, json['state']) ??
          CurrentGameState.initial,
      oTurn: json['oTurn'] as bool? ?? true,
      playerOneId: (json['playerOneId'] as num?)?.toInt() ?? 2,
      playerTwoId: (json['playerTwoId'] as num?)?.toInt() ?? 1,
      playerOneWins: (json['playerOneWins'] as num?)?.toInt() ?? 0,
      playerTwoWins: (json['playerTwoWins'] as num?)?.toInt() ?? 0,
      draws: (json['draws'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CurrentGameEntityToJson(CurrentGameEntity instance) =>
    <String, dynamic>{
      'elements': instance.elements,
      'state': _$CurrentGameStateEnumMap[instance.state]!,
      'oTurn': instance.oTurn,
      'playerOneId': instance.playerOneId,
      'playerTwoId': instance.playerTwoId,
      'playerOneWins': instance.playerOneWins,
      'playerTwoWins': instance.playerTwoWins,
      'draws': instance.draws,
    };

const _$CurrentGameStateEnumMap = {
  CurrentGameState.initial: 'initial',
  CurrentGameState.inProgress: 'inProgress',
  CurrentGameState.playerOneWon: 'playerOneWon',
  CurrentGameState.playerTwoWon: 'playerTwoWon',
  CurrentGameState.draw: 'draw',
};
