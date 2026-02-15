// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'current_game_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CurrentGameModel {

 List<String> get elements; bool get oTurn; CurrentGameState get state; UserModel get playerOne; UserModel get playerTwo; int get playerOneWins; int get playerTwoWins; int get draws;
/// Create a copy of CurrentGameModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentGameModelCopyWith<CurrentGameModel> get copyWith => _$CurrentGameModelCopyWithImpl<CurrentGameModel>(this as CurrentGameModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentGameModel&&const DeepCollectionEquality().equals(other.elements, elements)&&(identical(other.oTurn, oTurn) || other.oTurn == oTurn)&&(identical(other.state, state) || other.state == state)&&(identical(other.playerOne, playerOne) || other.playerOne == playerOne)&&(identical(other.playerTwo, playerTwo) || other.playerTwo == playerTwo)&&(identical(other.playerOneWins, playerOneWins) || other.playerOneWins == playerOneWins)&&(identical(other.playerTwoWins, playerTwoWins) || other.playerTwoWins == playerTwoWins)&&(identical(other.draws, draws) || other.draws == draws));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(elements),oTurn,state,playerOne,playerTwo,playerOneWins,playerTwoWins,draws);

@override
String toString() {
  return 'CurrentGameModel(elements: $elements, oTurn: $oTurn, state: $state, playerOne: $playerOne, playerTwo: $playerTwo, playerOneWins: $playerOneWins, playerTwoWins: $playerTwoWins, draws: $draws)';
}


}

/// @nodoc
abstract mixin class $CurrentGameModelCopyWith<$Res>  {
  factory $CurrentGameModelCopyWith(CurrentGameModel value, $Res Function(CurrentGameModel) _then) = _$CurrentGameModelCopyWithImpl;
@useResult
$Res call({
 List<String> elements, bool oTurn, CurrentGameState state, UserModel playerOne, UserModel playerTwo, int playerOneWins, int playerTwoWins, int draws
});


$UserModelCopyWith<$Res> get playerOne;$UserModelCopyWith<$Res> get playerTwo;

}
/// @nodoc
class _$CurrentGameModelCopyWithImpl<$Res>
    implements $CurrentGameModelCopyWith<$Res> {
  _$CurrentGameModelCopyWithImpl(this._self, this._then);

  final CurrentGameModel _self;
  final $Res Function(CurrentGameModel) _then;

/// Create a copy of CurrentGameModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? elements = null,Object? oTurn = null,Object? state = null,Object? playerOne = null,Object? playerTwo = null,Object? playerOneWins = null,Object? playerTwoWins = null,Object? draws = null,}) {
  return _then(_self.copyWith(
elements: null == elements ? _self.elements : elements // ignore: cast_nullable_to_non_nullable
as List<String>,oTurn: null == oTurn ? _self.oTurn : oTurn // ignore: cast_nullable_to_non_nullable
as bool,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as CurrentGameState,playerOne: null == playerOne ? _self.playerOne : playerOne // ignore: cast_nullable_to_non_nullable
as UserModel,playerTwo: null == playerTwo ? _self.playerTwo : playerTwo // ignore: cast_nullable_to_non_nullable
as UserModel,playerOneWins: null == playerOneWins ? _self.playerOneWins : playerOneWins // ignore: cast_nullable_to_non_nullable
as int,playerTwoWins: null == playerTwoWins ? _self.playerTwoWins : playerTwoWins // ignore: cast_nullable_to_non_nullable
as int,draws: null == draws ? _self.draws : draws // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of CurrentGameModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res> get playerOne {
  
  return $UserModelCopyWith<$Res>(_self.playerOne, (value) {
    return _then(_self.copyWith(playerOne: value));
  });
}/// Create a copy of CurrentGameModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res> get playerTwo {
  
  return $UserModelCopyWith<$Res>(_self.playerTwo, (value) {
    return _then(_self.copyWith(playerTwo: value));
  });
}
}


/// Adds pattern-matching-related methods to [CurrentGameModel].
extension CurrentGameModelPatterns on CurrentGameModel {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> elements,  bool oTurn,  CurrentGameState state,  UserModel playerOne,  UserModel playerTwo,  int playerOneWins,  int playerTwoWins,  int draws)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Data() when $default != null:
return $default(_that.elements,_that.oTurn,_that.state,_that.playerOne,_that.playerTwo,_that.playerOneWins,_that.playerTwoWins,_that.draws);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> elements,  bool oTurn,  CurrentGameState state,  UserModel playerOne,  UserModel playerTwo,  int playerOneWins,  int playerTwoWins,  int draws)  $default,) {final _that = this;
switch (_that) {
case _Data():
return $default(_that.elements,_that.oTurn,_that.state,_that.playerOne,_that.playerTwo,_that.playerOneWins,_that.playerTwoWins,_that.draws);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> elements,  bool oTurn,  CurrentGameState state,  UserModel playerOne,  UserModel playerTwo,  int playerOneWins,  int playerTwoWins,  int draws)?  $default,) {final _that = this;
switch (_that) {
case _Data() when $default != null:
return $default(_that.elements,_that.oTurn,_that.state,_that.playerOne,_that.playerTwo,_that.playerOneWins,_that.playerTwoWins,_that.draws);case _:
  return null;

}
}

}

/// @nodoc


class _Data extends CurrentGameModel {
  const _Data({this.elements = const ['', '', '', '', '', '', '', '', ''], this.oTurn = true, this.state = CurrentGameState.initial, required this.playerOne, required this.playerTwo, this.playerOneWins = 0, this.playerTwoWins = 0, this.draws = 0}): super._();
  

@override@JsonKey() final  List<String> elements;
@override@JsonKey() final  bool oTurn;
@override@JsonKey() final  CurrentGameState state;
@override final  UserModel playerOne;
@override final  UserModel playerTwo;
@override@JsonKey() final  int playerOneWins;
@override@JsonKey() final  int playerTwoWins;
@override@JsonKey() final  int draws;

/// Create a copy of CurrentGameModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DataCopyWith<_Data> get copyWith => __$DataCopyWithImpl<_Data>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Data&&const DeepCollectionEquality().equals(other.elements, elements)&&(identical(other.oTurn, oTurn) || other.oTurn == oTurn)&&(identical(other.state, state) || other.state == state)&&(identical(other.playerOne, playerOne) || other.playerOne == playerOne)&&(identical(other.playerTwo, playerTwo) || other.playerTwo == playerTwo)&&(identical(other.playerOneWins, playerOneWins) || other.playerOneWins == playerOneWins)&&(identical(other.playerTwoWins, playerTwoWins) || other.playerTwoWins == playerTwoWins)&&(identical(other.draws, draws) || other.draws == draws));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(elements),oTurn,state,playerOne,playerTwo,playerOneWins,playerTwoWins,draws);

@override
String toString() {
  return 'CurrentGameModel(elements: $elements, oTurn: $oTurn, state: $state, playerOne: $playerOne, playerTwo: $playerTwo, playerOneWins: $playerOneWins, playerTwoWins: $playerTwoWins, draws: $draws)';
}


}

/// @nodoc
abstract mixin class _$DataCopyWith<$Res> implements $CurrentGameModelCopyWith<$Res> {
  factory _$DataCopyWith(_Data value, $Res Function(_Data) _then) = __$DataCopyWithImpl;
@override @useResult
$Res call({
 List<String> elements, bool oTurn, CurrentGameState state, UserModel playerOne, UserModel playerTwo, int playerOneWins, int playerTwoWins, int draws
});


@override $UserModelCopyWith<$Res> get playerOne;@override $UserModelCopyWith<$Res> get playerTwo;

}
/// @nodoc
class __$DataCopyWithImpl<$Res>
    implements _$DataCopyWith<$Res> {
  __$DataCopyWithImpl(this._self, this._then);

  final _Data _self;
  final $Res Function(_Data) _then;

/// Create a copy of CurrentGameModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? elements = null,Object? oTurn = null,Object? state = null,Object? playerOne = null,Object? playerTwo = null,Object? playerOneWins = null,Object? playerTwoWins = null,Object? draws = null,}) {
  return _then(_Data(
elements: null == elements ? _self.elements : elements // ignore: cast_nullable_to_non_nullable
as List<String>,oTurn: null == oTurn ? _self.oTurn : oTurn // ignore: cast_nullable_to_non_nullable
as bool,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as CurrentGameState,playerOne: null == playerOne ? _self.playerOne : playerOne // ignore: cast_nullable_to_non_nullable
as UserModel,playerTwo: null == playerTwo ? _self.playerTwo : playerTwo // ignore: cast_nullable_to_non_nullable
as UserModel,playerOneWins: null == playerOneWins ? _self.playerOneWins : playerOneWins // ignore: cast_nullable_to_non_nullable
as int,playerTwoWins: null == playerTwoWins ? _self.playerTwoWins : playerTwoWins // ignore: cast_nullable_to_non_nullable
as int,draws: null == draws ? _self.draws : draws // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of CurrentGameModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res> get playerOne {
  
  return $UserModelCopyWith<$Res>(_self.playerOne, (value) {
    return _then(_self.copyWith(playerOne: value));
  });
}/// Create a copy of CurrentGameModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res> get playerTwo {
  
  return $UserModelCopyWith<$Res>(_self.playerTwo, (value) {
    return _then(_self.copyWith(playerTwo: value));
  });
}
}

// dart format on
