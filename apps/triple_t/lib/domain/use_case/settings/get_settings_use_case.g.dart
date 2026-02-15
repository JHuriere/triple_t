// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_settings_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getSettingsUseCase)
final getSettingsUseCaseProvider = GetSettingsUseCaseProvider._();

final class GetSettingsUseCaseProvider
    extends $FunctionalProvider<SettingsModel, SettingsModel, SettingsModel>
    with $Provider<SettingsModel> {
  GetSettingsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getSettingsUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getSettingsUseCaseHash();

  @$internal
  @override
  $ProviderElement<SettingsModel> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SettingsModel create(Ref ref) {
    return getSettingsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingsModel>(value),
    );
  }
}

String _$getSettingsUseCaseHash() =>
    r'd5179fa4d12dab8e139e4187e597d1fb9d1e7eb4';
