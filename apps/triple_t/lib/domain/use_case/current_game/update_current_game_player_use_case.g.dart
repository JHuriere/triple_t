// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_current_game_player_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(updateCurrentGamePlayerUseCase)
final updateCurrentGamePlayerUseCaseProvider =
    UpdateCurrentGamePlayerUseCaseFamily._();

final class UpdateCurrentGamePlayerUseCaseProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  UpdateCurrentGamePlayerUseCaseProvider._({
    required UpdateCurrentGamePlayerUseCaseFamily super.from,
    required ({UserModel? playerOne, UserModel? playerTwo}) super.argument,
  }) : super(
         retry: null,
         name: r'updateCurrentGamePlayerUseCaseProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$updateCurrentGamePlayerUseCaseHash();

  @override
  String toString() {
    return r'updateCurrentGamePlayerUseCaseProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    final argument =
        this.argument as ({UserModel? playerOne, UserModel? playerTwo});
    return updateCurrentGamePlayerUseCase(
      ref,
      playerOne: argument.playerOne,
      playerTwo: argument.playerTwo,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateCurrentGamePlayerUseCaseProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$updateCurrentGamePlayerUseCaseHash() =>
    r'bc2199968302e020647fed4387b8d80735ac3262';

final class UpdateCurrentGamePlayerUseCaseFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<void>,
          ({UserModel? playerOne, UserModel? playerTwo})
        > {
  UpdateCurrentGamePlayerUseCaseFamily._()
    : super(
        retry: null,
        name: r'updateCurrentGamePlayerUseCaseProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UpdateCurrentGamePlayerUseCaseProvider call({
    UserModel? playerOne,
    UserModel? playerTwo,
  }) => UpdateCurrentGamePlayerUseCaseProvider._(
    argument: (playerOne: playerOne, playerTwo: playerTwo),
    from: this,
  );

  @override
  String toString() => r'updateCurrentGamePlayerUseCaseProvider';
}
