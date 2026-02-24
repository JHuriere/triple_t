import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:user_domain/src/entity/statistics/statistics_entity.dart';

part 'user_entity.freezed.dart';
part 'user_entity.g.dart';

@Freezed()
abstract class UserEntity with _$UserEntity {
  @JsonSerializable(explicitToJson: true)
  const factory UserEntity({
    @JsonKey(name: 'id') @Default(0) int id,
    @JsonKey(name: 'name') @Default('') String name,
    @JsonKey(name: 'emoticon') @Default('') String emoticon,
    @JsonKey(name: 'statistics') @Default({}) Map<int, StatisticsEntity>? statistics,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);

  static UserEntity empty() => const UserEntity(name: 'No name', emoticon: '❓');
}

const kUserEmoticons = [
  '🎮', '🎯', '🎲', '🎪', '🎨', '🎭', //
  '🎰', '🎸', '🎺', '🎹', '🚀', '🛸', //
  '🛹', '⚽', '🏀', '🏈', '⚾', '🎾', //
  '🏐', '🏉', '🎱', '🏓', '🏸', '🏒', //
  '🏑', '🥏', '🎿', '⛷️', '🏂', '🪂', //
  '🤿', '🎣', '🥊', '🤖', '⛳', '🎳', //
];
