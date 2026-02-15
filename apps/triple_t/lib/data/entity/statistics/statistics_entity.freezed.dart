// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'statistics_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
Statistics _$StatisticsFromJson(
  Map<String, dynamic> json
) {
    return StatisticsEntity.fromJson(
      json
    );
}

/// @nodoc
mixin _$Statistics {

@JsonKey(name: 'wins') int get wins;@JsonKey(name: 'losses') int get losses;@JsonKey(name: 'draws') int get draws;
/// Create a copy of Statistics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatisticsCopyWith<Statistics> get copyWith => _$StatisticsCopyWithImpl<Statistics>(this as Statistics, _$identity);

  /// Serializes this Statistics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Statistics&&(identical(other.wins, wins) || other.wins == wins)&&(identical(other.losses, losses) || other.losses == losses)&&(identical(other.draws, draws) || other.draws == draws));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,wins,losses,draws);

@override
String toString() {
  return 'Statistics(wins: $wins, losses: $losses, draws: $draws)';
}


}

/// @nodoc
abstract mixin class $StatisticsCopyWith<$Res>  {
  factory $StatisticsCopyWith(Statistics value, $Res Function(Statistics) _then) = _$StatisticsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'wins') int wins,@JsonKey(name: 'losses') int losses,@JsonKey(name: 'draws') int draws
});




}
/// @nodoc
class _$StatisticsCopyWithImpl<$Res>
    implements $StatisticsCopyWith<$Res> {
  _$StatisticsCopyWithImpl(this._self, this._then);

  final Statistics _self;
  final $Res Function(Statistics) _then;

/// Create a copy of Statistics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? wins = null,Object? losses = null,Object? draws = null,}) {
  return _then(_self.copyWith(
wins: null == wins ? _self.wins : wins // ignore: cast_nullable_to_non_nullable
as int,losses: null == losses ? _self.losses : losses // ignore: cast_nullable_to_non_nullable
as int,draws: null == draws ? _self.draws : draws // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Statistics].
extension StatisticsPatterns on Statistics {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( StatisticsEntity value)?  entity,required TResult orElse(),}){
final _that = this;
switch (_that) {
case StatisticsEntity() when entity != null:
return entity(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( StatisticsEntity value)  entity,}){
final _that = this;
switch (_that) {
case StatisticsEntity():
return entity(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( StatisticsEntity value)?  entity,}){
final _that = this;
switch (_that) {
case StatisticsEntity() when entity != null:
return entity(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function(@JsonKey(name: 'wins')  int wins, @JsonKey(name: 'losses')  int losses, @JsonKey(name: 'draws')  int draws)?  entity,required TResult orElse(),}) {final _that = this;
switch (_that) {
case StatisticsEntity() when entity != null:
return entity(_that.wins,_that.losses,_that.draws);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function(@JsonKey(name: 'wins')  int wins, @JsonKey(name: 'losses')  int losses, @JsonKey(name: 'draws')  int draws)  entity,}) {final _that = this;
switch (_that) {
case StatisticsEntity():
return entity(_that.wins,_that.losses,_that.draws);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function(@JsonKey(name: 'wins')  int wins, @JsonKey(name: 'losses')  int losses, @JsonKey(name: 'draws')  int draws)?  entity,}) {final _that = this;
switch (_that) {
case StatisticsEntity() when entity != null:
return entity(_that.wins,_that.losses,_that.draws);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class StatisticsEntity implements Statistics {
  const StatisticsEntity({@JsonKey(name: 'wins') this.wins = 0, @JsonKey(name: 'losses') this.losses = 0, @JsonKey(name: 'draws') this.draws = 0});
  factory StatisticsEntity.fromJson(Map<String, dynamic> json) => _$StatisticsEntityFromJson(json);

@override@JsonKey(name: 'wins') final  int wins;
@override@JsonKey(name: 'losses') final  int losses;
@override@JsonKey(name: 'draws') final  int draws;

/// Create a copy of Statistics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatisticsEntityCopyWith<StatisticsEntity> get copyWith => _$StatisticsEntityCopyWithImpl<StatisticsEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StatisticsEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatisticsEntity&&(identical(other.wins, wins) || other.wins == wins)&&(identical(other.losses, losses) || other.losses == losses)&&(identical(other.draws, draws) || other.draws == draws));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,wins,losses,draws);

@override
String toString() {
  return 'Statistics.entity(wins: $wins, losses: $losses, draws: $draws)';
}


}

/// @nodoc
abstract mixin class $StatisticsEntityCopyWith<$Res> implements $StatisticsCopyWith<$Res> {
  factory $StatisticsEntityCopyWith(StatisticsEntity value, $Res Function(StatisticsEntity) _then) = _$StatisticsEntityCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'wins') int wins,@JsonKey(name: 'losses') int losses,@JsonKey(name: 'draws') int draws
});




}
/// @nodoc
class _$StatisticsEntityCopyWithImpl<$Res>
    implements $StatisticsEntityCopyWith<$Res> {
  _$StatisticsEntityCopyWithImpl(this._self, this._then);

  final StatisticsEntity _self;
  final $Res Function(StatisticsEntity) _then;

/// Create a copy of Statistics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? wins = null,Object? losses = null,Object? draws = null,}) {
  return _then(StatisticsEntity(
wins: null == wins ? _self.wins : wins // ignore: cast_nullable_to_non_nullable
as int,losses: null == losses ? _self.losses : losses // ignore: cast_nullable_to_non_nullable
as int,draws: null == draws ? _self.draws : draws // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
