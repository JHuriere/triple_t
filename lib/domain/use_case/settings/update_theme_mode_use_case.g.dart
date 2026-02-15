// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_theme_mode_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(updateThemeModeUseCase)
final updateThemeModeUseCaseProvider = UpdateThemeModeUseCaseFamily._();

final class UpdateThemeModeUseCaseProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  UpdateThemeModeUseCaseProvider._({
    required UpdateThemeModeUseCaseFamily super.from,
    required ThemeMode super.argument,
  }) : super(
         retry: null,
         name: r'updateThemeModeUseCaseProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$updateThemeModeUseCaseHash();

  @override
  String toString() {
    return r'updateThemeModeUseCaseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    final argument = this.argument as ThemeMode;
    return updateThemeModeUseCase(ref, themeMode: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateThemeModeUseCaseProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$updateThemeModeUseCaseHash() =>
    r'836d46ac3f6520b7119edff3c9b7f56809e3955c';

final class UpdateThemeModeUseCaseFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<void>, ThemeMode> {
  UpdateThemeModeUseCaseFamily._()
    : super(
        retry: null,
        name: r'updateThemeModeUseCaseProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UpdateThemeModeUseCaseProvider call({required ThemeMode themeMode}) =>
      UpdateThemeModeUseCaseProvider._(argument: themeMode, from: this);

  @override
  String toString() => r'updateThemeModeUseCaseProvider';
}
