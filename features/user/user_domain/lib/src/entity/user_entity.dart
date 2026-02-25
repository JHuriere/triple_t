import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:user_domain/src/entity/statistics/statistics_entity.dart';

part 'user_entity.freezed.dart';

@Freezed()
abstract class UserEntity with _$UserEntity {
  const factory UserEntity({
    @Default(0) int id,
    @Default('') String name,
    @Default('') String emoticon,
    @Default({}) Map<int, StatisticsEntity>? statistics,
  }) = _UserEntity;

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
