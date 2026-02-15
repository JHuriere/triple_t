// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_current_game_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getCurrentGameUseCase)
final getCurrentGameUseCaseProvider = GetCurrentGameUseCaseProvider._();

final class GetCurrentGameUseCaseProvider
    extends
        $FunctionalProvider<
          CurrentGameModel,
          CurrentGameModel,
          CurrentGameModel
        >
    with $Provider<CurrentGameModel> {
  GetCurrentGameUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getCurrentGameUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getCurrentGameUseCaseHash();

  @$internal
  @override
  $ProviderElement<CurrentGameModel> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CurrentGameModel create(Ref ref) {
    return getCurrentGameUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CurrentGameModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CurrentGameModel>(value),
    );
  }
}

String _$getCurrentGameUseCaseHash() =>
    r'344656d6d1af73f3c302996d055b66d62d204572';
