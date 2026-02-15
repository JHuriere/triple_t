// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_locale_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getLocaleUseCase)
final getLocaleUseCaseProvider = GetLocaleUseCaseProvider._();

final class GetLocaleUseCaseProvider
    extends $FunctionalProvider<Locale, Locale, Locale>
    with $Provider<Locale> {
  GetLocaleUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getLocaleUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getLocaleUseCaseHash();

  @$internal
  @override
  $ProviderElement<Locale> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Locale create(Ref ref) {
    return getLocaleUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Locale value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Locale>(value),
    );
  }
}

String _$getLocaleUseCaseHash() => r'0e75cb5d87531245d014bd6f31e2a3d4e4da0999';
