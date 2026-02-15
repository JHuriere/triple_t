// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_current_game_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(resetCurrentGameUseCase)
final resetCurrentGameUseCaseProvider = ResetCurrentGameUseCaseProvider._();

final class ResetCurrentGameUseCaseProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  ResetCurrentGameUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resetCurrentGameUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resetCurrentGameUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return resetCurrentGameUseCase(ref);
  }
}

String _$resetCurrentGameUseCaseHash() =>
    r'4e73025978657520395f8070416e9d96f4cc4d38';
