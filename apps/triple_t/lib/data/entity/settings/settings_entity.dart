import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_entity.freezed.dart';
part 'settings_entity.g.dart';

@Freezed()
abstract class Settings with _$Settings {
  @JsonSerializable(explicitToJson: true)
  const factory Settings.entity({
    @JsonKey(name: 'id') @Default('') String id,
    @JsonKey(name: 'themeMode') @Default('system') String themeMode,
  }) = SettingsEntity;

  factory Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);
}
