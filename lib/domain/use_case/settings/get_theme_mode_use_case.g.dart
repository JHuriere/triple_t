// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_theme_mode_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getThemeModeUseCase)
final getThemeModeUseCaseProvider = GetThemeModeUseCaseProvider._();

final class GetThemeModeUseCaseProvider
    extends $FunctionalProvider<ThemeMode, ThemeMode, ThemeMode>
    with $Provider<ThemeMode> {
  GetThemeModeUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getThemeModeUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getThemeModeUseCaseHash();

  @$internal
  @override
  $ProviderElement<ThemeMode> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ThemeMode create(Ref ref) {
    return getThemeModeUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$getThemeModeUseCaseHash() =>
    r'df2ccf21a2e9f8a0edbbec097407c9448a8cc0aa';
