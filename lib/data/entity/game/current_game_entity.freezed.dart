// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'current_game_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
CurrentGame _$CurrentGameFromJson(
  Map<String, dynamic> json
) {
    return CurrentGameEntity.fromJson(
      json
    );
}

/// @nodoc
mixin _$CurrentGame {

@JsonKey(name: 'elements') List<String> get elements;@JsonKey(name: 'state') CurrentGameState get state;@JsonKey(name: 'oTurn') bool get oTurn;@JsonKey(name: 'playerOneId') int get playerOneId;@JsonKey(name: 'playerTwoId') int get playerTwoId;@JsonKey(name: 'playerOneWins') int get playerOneWins;@JsonKey(name: 'playerTwoWins') int get playerTwoWins;@JsonKey(name: 'draws') int get draws;
/// Create a copy of CurrentGame
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentGameCopyWith<CurrentGame> get copyWith => _$CurrentGameCopyWithImpl<CurrentGame>(this as CurrentGame, _$identity);

  /// Serializes this CurrentGame to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentGame&&const DeepCollectionEquality().equals(other.elements, elements)&&(identical(other.state, state) || other.state == state)&&(identical(other.oTurn, oTurn) || other.oTurn == oTurn)&&(identical(other.playerOneId, playerOneId) || other.playerOneId == playerOneId)&&(identical(other.playerTwoId, playerTwoId) || other.playerTwoId == playerTwoId)&&(identical(other.playerOneWins, playerOneWins) || other.playerOneWins == playerOneWins)&&(identical(other.playerTwoWins, playerTwoWins) || other.playerTwoWins == playerTwoWins)&&(identical(other.draws, draws) || other.draws == draws));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(elements),state,oTurn,playerOneId,playerTwoId,playerOneWins,playerTwoWins,draws);

@override
String toString() {
  return 'CurrentGame(elements: $elements, state: $state, oTurn: $oTurn, playerOneId: $playerOneId, playerTwoId: $playerTwoId, playerOneWins: $playerOneWins, playerTwoWins: $playerTwoWins, draws: $draws)';
}


}

/// @nodoc
abstract mixin class $CurrentGameCopyWith<$Res>  {
  factory $CurrentGameCopyWith(CurrentGame value, $Res Function(CurrentGame) _then) = _$CurrentGameCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'elements') List<String> elements,@JsonKey(name: 'state') CurrentGameState state,@JsonKey(name: 'oTurn') bool oTurn,@JsonKey(name: 'playerOneId') int playerOneId,@JsonKey(name: 'playerTwoId') int playerTwoId,@JsonKey(name: 'playerOneWins') int playerOneWins,@JsonKey(name: 'playerTwoWins') int playerTwoWins,@JsonKey(name: 'draws') int draws
});




}
/// @nodoc
class _$CurrentGameCopyWithImpl<$Res>
    implements $CurrentGameCopyWith<$Res> {
  _$CurrentGameCopyWithImpl(this._self, this._then);

  final CurrentGame _self;
  final $Res Function(CurrentGame) _then;

/// Create a copy of CurrentGame
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? elements = null,Object? state = null,Object? oTurn = null,Object? playerOneId = null,Object? playerTwoId = null,Object? playerOneWins = null,Object? playerTwoWins = null,Object? draws = null,}) {
  return _then(_self.copyWith(
elements: null == elements ? _self.elements : elements // ignore: cast_nullable_to_non_nullable
as List<String>,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as CurrentGameState,oTurn: null == oTurn ? _self.oTurn : oTurn // ignore: cast_nullable_to_non_nullable
as bool,playerOneId: null == playerOneId ? _self.playerOneId : playerOneId // ignore: cast_nullable_to_non_nullable
as int,playerTwoId: null == playerTwoId ? _self.playerTwoId : playerTwoId // ignore: cast_nullable_to_non_nullable
as int,playerOneWins: null == playerOneWins ? _self.playerOneWins : playerOneWins // ignore: cast_nullable_to_non_nullable
as int,playerTwoWins: null == playerTwoWins ? _self.playerTwoWins : playerTwoWins // ignore: cast_nullable_to_non_nullable
as int,draws: null == draws ? _self.draws : draws // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CurrentGame].
extension CurrentGamePatterns on CurrentGame {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CurrentGameEntity value)?  entity,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CurrentGameEntity() when entity != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CurrentGameEntity value)  entity,}){
final _that = this;
switch (_that) {
case CurrentGameEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CurrentGameEntity value)?  entity,}){
final _that = this;
switch (_that) {
case CurrentGameEntity() when entity != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function(@JsonKey(name: 'elements')  List<String> elements, @JsonKey(name: 'state')  CurrentGameState state, @JsonKey(name: 'oTurn')  bool oTurn, @JsonKey(name: 'playerOneId')  int playerOneId, @JsonKey(name: 'playerTwoId')  int playerTwoId, @JsonKey(name: 'playerOneWins')  int playerOneWins, @JsonKey(name: 'playerTwoWins')  int playerTwoWins, @JsonKey(name: 'draws')  int draws)?  entity,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CurrentGameEntity() when entity != null:
return entity(_that.elements,_that.state,_that.oTurn,_that.playerOneId,_that.playerTwoId,_that.playerOneWins,_that.playerTwoWins,_that.draws);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function(@JsonKey(name: 'elements')  List<String> elements, @JsonKey(name: 'state')  CurrentGameState state, @JsonKey(name: 'oTurn')  bool oTurn, @JsonKey(name: 'playerOneId')  int playerOneId, @JsonKey(name: 'playerTwoId')  int playerTwoId, @JsonKey(name: 'playerOneWins')  int playerOneWins, @JsonKey(name: 'playerTwoWins')  int playerTwoWins, @JsonKey(name: 'draws')  int draws)  entity,}) {final _that = this;
switch (_that) {
case CurrentGameEntity():
return entity(_that.elements,_that.state,_that.oTurn,_that.playerOneId,_that.playerTwoId,_that.playerOneWins,_that.playerTwoWins,_that.draws);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function(@JsonKey(name: 'elements')  List<String> elements, @JsonKey(name: 'state')  CurrentGameState state, @JsonKey(name: 'oTurn')  bool oTurn, @JsonKey(name: 'playerOneId')  int playerOneId, @JsonKey(name: 'playerTwoId')  int playerTwoId, @JsonKey(name: 'playerOneWins')  int playerOneWins, @JsonKey(name: 'playerTwoWins')  int playerTwoWins, @JsonKey(name: 'draws')  int draws)?  entity,}) {final _that = this;
switch (_that) {
case CurrentGameEntity() when entity != null:
return entity(_that.elements,_that.state,_that.oTurn,_that.playerOneId,_that.playerTwoId,_that.playerOneWins,_that.playerTwoWins,_that.draws);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class CurrentGameEntity implements CurrentGame {
  const CurrentGameEntity({@JsonKey(name: 'elements') final  List<String> elements = const ['', '', '', '', '', '', '', '', ''], @JsonKey(name: 'state') this.state = CurrentGameState.initial, @JsonKey(name: 'oTurn') this.oTurn = true, @JsonKey(name: 'playerOneId') this.playerOneId = 2, @JsonKey(name: 'playerTwoId') this.playerTwoId = 1, @JsonKey(name: 'playerOneWins') this.playerOneWins = 0, @JsonKey(name: 'playerTwoWins') this.playerTwoWins = 0, @JsonKey(name: 'draws') this.draws = 0}): _elements = elements;
  factory CurrentGameEntity.fromJson(Map<String, dynamic> json) => _$CurrentGameEntityFromJson(json);

 final  List<String> _elements;
@override@JsonKey(name: 'elements') List<String> get elements {
  if (_elements is EqualUnmodifiableListView) return _elements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_elements);
}

@override@JsonKey(name: 'state') final  CurrentGameState state;
@override@JsonKey(name: 'oTurn') final  bool oTurn;
@override@JsonKey(name: 'playerOneId') final  int playerOneId;
@override@JsonKey(name: 'playerTwoId') final  int playerTwoId;
@override@JsonKey(name: 'playerOneWins') final  int playerOneWins;
@override@JsonKey(name: 'playerTwoWins') final  int playerTwoWins;
@override@JsonKey(name: 'draws') final  int draws;

/// Create a copy of CurrentGame
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentGameEntityCopyWith<CurrentGameEntity> get copyWith => _$CurrentGameEntityCopyWithImpl<CurrentGameEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CurrentGameEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentGameEntity&&const DeepCollectionEquality().equals(other._elements, _elements)&&(identical(other.state, state) || other.state == state)&&(identical(other.oTurn, oTurn) || other.oTurn == oTurn)&&(identical(other.playerOneId, playerOneId) || other.playerOneId == playerOneId)&&(identical(other.playerTwoId, playerTwoId) || other.playerTwoId == playerTwoId)&&(identical(other.playerOneWins, playerOneWins) || other.playerOneWins == playerOneWins)&&(identical(other.playerTwoWins, playerTwoWins) || other.playerTwoWins == playerTwoWins)&&(identical(other.draws, draws) || other.draws == draws));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_elements),state,oTurn,playerOneId,playerTwoId,playerOneWins,playerTwoWins,draws);

@override
String toString() {
  return 'CurrentGame.entity(elements: $elements, state: $state, oTurn: $oTurn, playerOneId: $playerOneId, playerTwoId: $playerTwoId, playerOneWins: $playerOneWins, playerTwoWins: $playerTwoWins, draws: $draws)';
}


}

/// @nodoc
abstract mixin class $CurrentGameEntityCopyWith<$Res> implements $CurrentGameCopyWith<$Res> {
  factory $CurrentGameEntityCopyWith(CurrentGameEntity value, $Res Function(CurrentGameEntity) _then) = _$CurrentGameEntityCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'elements') List<String> elements,@JsonKey(name: 'state') CurrentGameState state,@JsonKey(name: 'oTurn') bool oTurn,@JsonKey(name: 'playerOneId') int playerOneId,@JsonKey(name: 'playerTwoId') int playerTwoId,@JsonKey(name: 'playerOneWins') int playerOneWins,@JsonKey(name: 'playerTwoWins') int playerTwoWins,@JsonKey(name: 'draws') int draws
});




}
/// @nodoc
class _$CurrentGameEntityCopyWithImpl<$Res>
    implements $CurrentGameEntityCopyWith<$Res> {
  _$CurrentGameEntityCopyWithImpl(this._self, this._then);

  final CurrentGameEntity _self;
  final $Res Function(CurrentGameEntity) _then;

/// Create a copy of CurrentGame
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? elements = null,Object? state = null,Object? oTurn = null,Object? playerOneId = null,Object? playerTwoId = null,Object? playerOneWins = null,Object? playerTwoWins = null,Object? draws = null,}) {
  return _then(CurrentGameEntity(
elements: null == elements ? _self._elements : elements // ignore: cast_nullable_to_non_nullable
as List<String>,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as CurrentGameState,oTurn: null == oTurn ? _self.oTurn : oTurn // ignore: cast_nullable_to_non_nullable
as bool,playerOneId: null == playerOneId ? _self.playerOneId : playerOneId // ignore: cast_nullable_to_non_nullable
as int,playerTwoId: null == playerTwoId ? _self.playerTwoId : playerTwoId // ignore: cast_nullable_to_non_nullable
as int,playerOneWins: null == playerOneWins ? _self.playerOneWins : playerOneWins // ignore: cast_nullable_to_non_nullable
as int,playerTwoWins: null == playerTwoWins ? _self.playerTwoWins : playerTwoWins // ignore: cast_nullable_to_non_nullable
as int,draws: null == draws ? _self.draws : draws // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
