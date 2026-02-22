import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tt_database/tt_database.dart';
import 'package:user_data/user_data.dart';
import 'package:user_domain/src/model/statistics/statistics_model.dart';

part 'user_model.freezed.dart';

@Freezed()
abstract class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    @Default(0) int id,
    @Default('') String name,
    @Default('') String emoticon,
    @Default({}) Map<int, StatisticsModel>? statistics,
  }) = _Data;

  factory UserModel.fromEntity({
    required Entity<UserEntity> entity,
  }) => UserModel(
    id: entity.id,
    name: entity.data.name,
    emoticon: entity.data.emoticon,
    statistics: entity.data.statistics?.map(
      (key, value) => MapEntry(
        key,
        StatisticsModel.fromEntity(entity: value),
      ),
    ),
  );

  Entity<UserEntity> toEntity() => Entity<UserEntity>(
    id: id,
    data: UserEntity(
      name: name,
      emoticon: emoticon,
      statistics: statistics?.map(
        (key, value) => MapEntry(key, value.toEntity()),
      ),
    ),
  );
}

const kUserEmoticons = [
  '🎮', '🎯', '🎲', '🎪', '🎨', '🎭', //
  '🎰', '🎸', '🎺', '🎹', '🚀', '🛸', //
  '🛹', '⚽', '🏀', '🏈', '⚾', '🎾', //
  '🏐', '🏉', '🎱', '🏓', '🏸', '🏒', //
  '🏑', '🥏', '🎿', '⛷️', '🏂', '🪂', //
  '🤿', '🎣', '🥊', '🤖', '⛳', '🎳', //
];
