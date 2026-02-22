import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:user_data/src/entity/statistics/statistics_entity.dart';

part 'user_entity.freezed.dart';
part 'user_entity.g.dart';

@Freezed()
abstract class User with _$User {
  @JsonSerializable(explicitToJson: true)
  const factory User.entity({
    @JsonKey(name: 'name') @Default('') String name,
    @JsonKey(name: 'emoticon') @Default('') String emoticon,
    @JsonKey(name: 'statistics') @Default({}) Map<int, StatisticsEntity>? statistics,
  }) = UserEntity;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
