import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:user_data/src/model/statistics_model.dart';
import 'package:user_domain/user_domain.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const UserModel._();

  @JsonSerializable(explicitToJson: true)
  const factory UserModel({
    @JsonKey(name: 'id') @Default(0) int id,
    @JsonKey(name: 'name') @Default('') String name,
    @JsonKey(name: 'emoticon') @Default('') String emoticon,
    @JsonKey(name: 'statistics') @Default({}) Map<int, StatisticsModel>? statistics,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  UserEntity toEntity() => UserEntity(
    id: id,
    name: name,
    emoticon: emoticon,
    statistics: statistics?.map((key, value) => MapEntry(key, value.toEntity())),
  );

  factory UserModel.fromEntity(UserEntity entity) => UserModel(
    id: entity.id,
    name: entity.name,
    emoticon: entity.emoticon,
    statistics: entity.statistics?.map((key, value) => MapEntry(key, StatisticsModel.fromEntity(value))),
  );
}
