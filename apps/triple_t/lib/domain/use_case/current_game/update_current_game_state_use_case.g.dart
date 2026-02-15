// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_current_game_state_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(updateCurrentGameStateUseCase)
final updateCurrentGameStateUseCaseProvider =
    UpdateCurrentGameStateUseCaseFamily._();

final class UpdateCurrentGameStateUseCaseProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  UpdateCurrentGameStateUseCaseProvider._({
    required UpdateCurrentGameStateUseCaseFamily super.from,
    required CurrentGameState super.argument,
  }) : super(
         retry: null,
         name: r'updateCurrentGameStateUseCaseProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$updateCurrentGameStateUseCaseHash();

  @override
  String toString() {
    return r'updateCurrentGameStateUseCaseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    final argument = this.argument as CurrentGameState;
    return updateCurrentGameStateUseCase(ref, state: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateCurrentGameStateUseCaseProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$updateCurrentGameStateUseCaseHash() =>
    r'ca0277754bd1593773db82a09dd4f2eba09be92d';

final class UpdateCurrentGameStateUseCaseFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<void>, CurrentGameState> {
  UpdateCurrentGameStateUseCaseFamily._()
    : super(
        retry: null,
        name: r'updateCurrentGameStateUseCaseProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UpdateCurrentGameStateUseCaseProvider call({
    required CurrentGameState state,
  }) => UpdateCurrentGameStateUseCaseProvider._(argument: state, from: this);

  @override
  String toString() => r'updateCurrentGameStateUseCaseProvider';
}
