// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
User _$UserFromJson(
  Map<String, dynamic> json
) {
    return UserEntity.fromJson(
      json
    );
}

/// @nodoc
mixin _$User {

@JsonKey(name: 'name') String get name;@JsonKey(name: 'emoticon') String get emoticon;@JsonKey(name: 'statistics') Map<int, StatisticsEntity>? get statistics;
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCopyWith<User> get copyWith => _$UserCopyWithImpl<User>(this as User, _$identity);

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User&&(identical(other.name, name) || other.name == name)&&(identical(other.emoticon, emoticon) || other.emoticon == emoticon)&&const DeepCollectionEquality().equals(other.statistics, statistics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,emoticon,const DeepCollectionEquality().hash(statistics));

@override
String toString() {
  return 'User(name: $name, emoticon: $emoticon, statistics: $statistics)';
}


}

/// @nodoc
abstract mixin class $UserCopyWith<$Res>  {
  factory $UserCopyWith(User value, $Res Function(User) _then) = _$UserCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'name') String name,@JsonKey(name: 'emoticon') String emoticon,@JsonKey(name: 'statistics') Map<int, StatisticsEntity>? statistics
});




}
/// @nodoc
class _$UserCopyWithImpl<$Res>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? emoticon = null,Object? statistics = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,emoticon: null == emoticon ? _self.emoticon : emoticon // ignore: cast_nullable_to_non_nullable
as String,statistics: freezed == statistics ? _self.statistics : statistics // ignore: cast_nullable_to_non_nullable
as Map<int, StatisticsEntity>?,
  ));
}

}


/// Adds pattern-matching-related methods to [User].
extension UserPatterns on User {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( UserEntity value)?  entity,required TResult orElse(),}){
final _that = this;
switch (_that) {
case UserEntity() when entity != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( UserEntity value)  entity,}){
final _that = this;
switch (_that) {
case UserEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( UserEntity value)?  entity,}){
final _that = this;
switch (_that) {
case UserEntity() when entity != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function(@JsonKey(name: 'name')  String name, @JsonKey(name: 'emoticon')  String emoticon, @JsonKey(name: 'statistics')  Map<int, StatisticsEntity>? statistics)?  entity,required TResult orElse(),}) {final _that = this;
switch (_that) {
case UserEntity() when entity != null:
return entity(_that.name,_that.emoticon,_that.statistics);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function(@JsonKey(name: 'name')  String name, @JsonKey(name: 'emoticon')  String emoticon, @JsonKey(name: 'statistics')  Map<int, StatisticsEntity>? statistics)  entity,}) {final _that = this;
switch (_that) {
case UserEntity():
return entity(_that.name,_that.emoticon,_that.statistics);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function(@JsonKey(name: 'name')  String name, @JsonKey(name: 'emoticon')  String emoticon, @JsonKey(name: 'statistics')  Map<int, StatisticsEntity>? statistics)?  entity,}) {final _that = this;
switch (_that) {
case UserEntity() when entity != null:
return entity(_that.name,_that.emoticon,_that.statistics);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class UserEntity implements User {
  const UserEntity({@JsonKey(name: 'name') this.name = '', @JsonKey(name: 'emoticon') this.emoticon = '', @JsonKey(name: 'statistics') final  Map<int, StatisticsEntity>? statistics = const {}}): _statistics = statistics;
  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);

@override@JsonKey(name: 'name') final  String name;
@override@JsonKey(name: 'emoticon') final  String emoticon;
 final  Map<int, StatisticsEntity>? _statistics;
@override@JsonKey(name: 'statistics') Map<int, StatisticsEntity>? get statistics {
  final value = _statistics;
  if (value == null) return null;
  if (_statistics is EqualUnmodifiableMapView) return _statistics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserEntityCopyWith<UserEntity> get copyWith => _$UserEntityCopyWithImpl<UserEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.emoticon, emoticon) || other.emoticon == emoticon)&&const DeepCollectionEquality().equals(other._statistics, _statistics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,emoticon,const DeepCollectionEquality().hash(_statistics));

@override
String toString() {
  return 'User.entity(name: $name, emoticon: $emoticon, statistics: $statistics)';
}


}

/// @nodoc
abstract mixin class $UserEntityCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory $UserEntityCopyWith(UserEntity value, $Res Function(UserEntity) _then) = _$UserEntityCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'name') String name,@JsonKey(name: 'emoticon') String emoticon,@JsonKey(name: 'statistics') Map<int, StatisticsEntity>? statistics
});




}
/// @nodoc
class _$UserEntityCopyWithImpl<$Res>
    implements $UserEntityCopyWith<$Res> {
  _$UserEntityCopyWithImpl(this._self, this._then);

  final UserEntity _self;
  final $Res Function(UserEntity) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? emoticon = null,Object? statistics = freezed,}) {
  return _then(UserEntity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,emoticon: null == emoticon ? _self.emoticon : emoticon // ignore: cast_nullable_to_non_nullable
as String,statistics: freezed == statistics ? _self._statistics : statistics // ignore: cast_nullable_to_non_nullable
as Map<int, StatisticsEntity>?,
  ));
}


}

// dart format on
