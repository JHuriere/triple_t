// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_locale_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(updateLocaleUseCase)
final updateLocaleUseCaseProvider = UpdateLocaleUseCaseFamily._();

final class UpdateLocaleUseCaseProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  UpdateLocaleUseCaseProvider._({
    required UpdateLocaleUseCaseFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'updateLocaleUseCaseProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$updateLocaleUseCaseHash();

  @override
  String toString() {
    return r'updateLocaleUseCaseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    final argument = this.argument as String;
    return updateLocaleUseCase(ref, locale: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateLocaleUseCaseProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$updateLocaleUseCaseHash() =>
    r'efc17041a560807b596d84b72aaa7fa0d31cedd2';

final class UpdateLocaleUseCaseFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<void>, String> {
  UpdateLocaleUseCaseFamily._()
    : super(
        retry: null,
        name: r'updateLocaleUseCaseProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UpdateLocaleUseCaseProvider call({required String locale}) =>
      UpdateLocaleUseCaseProvider._(argument: locale, from: this);

  @override
  String toString() => r'updateLocaleUseCaseProvider';
}
