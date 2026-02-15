// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'statistics_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StatisticsModel {

 int get wins; int get losses; int get draws;
/// Create a copy of StatisticsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatisticsModelCopyWith<StatisticsModel> get copyWith => _$StatisticsModelCopyWithImpl<StatisticsModel>(this as StatisticsModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatisticsModel&&(identical(other.wins, wins) || other.wins == wins)&&(identical(other.losses, losses) || other.losses == losses)&&(identical(other.draws, draws) || other.draws == draws));
}


@override
int get hashCode => Object.hash(runtimeType,wins,losses,draws);

@override
String toString() {
  return 'StatisticsModel(wins: $wins, losses: $losses, draws: $draws)';
}


}

/// @nodoc
abstract mixin class $StatisticsModelCopyWith<$Res>  {
  factory $StatisticsModelCopyWith(StatisticsModel value, $Res Function(StatisticsModel) _then) = _$StatisticsModelCopyWithImpl;
@useResult
$Res call({
 int wins, int losses, int draws
});




}
/// @nodoc
class _$StatisticsModelCopyWithImpl<$Res>
    implements $StatisticsModelCopyWith<$Res> {
  _$StatisticsModelCopyWithImpl(this._self, this._then);

  final StatisticsModel _self;
  final $Res Function(StatisticsModel) _then;

/// Create a copy of StatisticsModel
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


/// Adds pattern-matching-related methods to [StatisticsModel].
extension StatisticsModelPatterns on StatisticsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Data value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Data() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Data value)  $default,){
final _that = this;
switch (_that) {
case _Data():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Data value)?  $default,){
final _that = this;
switch (_that) {
case _Data() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int wins,  int losses,  int draws)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Data() when $default != null:
return $default(_that.wins,_that.losses,_that.draws);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int wins,  int losses,  int draws)  $default,) {final _that = this;
switch (_that) {
case _Data():
return $default(_that.wins,_that.losses,_that.draws);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int wins,  int losses,  int draws)?  $default,) {final _that = this;
switch (_that) {
case _Data() when $default != null:
return $default(_that.wins,_that.losses,_that.draws);case _:
  return null;

}
}

}

/// @nodoc


class _Data extends StatisticsModel {
  const _Data({this.wins = 0, this.losses = 0, this.draws = 0}): super._();
  

@override@JsonKey() final  int wins;
@override@JsonKey() final  int losses;
@override@JsonKey() final  int draws;

/// Create a copy of StatisticsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DataCopyWith<_Data> get copyWith => __$DataCopyWithImpl<_Data>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Data&&(identical(other.wins, wins) || other.wins == wins)&&(identical(other.losses, losses) || other.losses == losses)&&(identical(other.draws, draws) || other.draws == draws));
}


@override
int get hashCode => Object.hash(runtimeType,wins,losses,draws);

@override
String toString() {
  return 'StatisticsModel(wins: $wins, losses: $losses, draws: $draws)';
}


}

/// @nodoc
abstract mixin class _$DataCopyWith<$Res> implements $StatisticsModelCopyWith<$Res> {
  factory _$DataCopyWith(_Data value, $Res Function(_Data) _then) = __$DataCopyWithImpl;
@override @useResult
$Res call({
 int wins, int losses, int draws
});




}
/// @nodoc
class __$DataCopyWithImpl<$Res>
    implements _$DataCopyWith<$Res> {
  __$DataCopyWithImpl(this._self, this._then);

  final _Data _self;
  final $Res Function(_Data) _then;

/// Create a copy of StatisticsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? wins = null,Object? losses = null,Object? draws = null,}) {
  return _then(_Data(
wins: null == wins ? _self.wins : wins // ignore: cast_nullable_to_non_nullable
as int,losses: null == losses ? _self.losses : losses // ignore: cast_nullable_to_non_nullable
as int,draws: null == draws ? _self.draws : draws // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
