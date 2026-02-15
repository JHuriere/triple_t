// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_current_game_elements_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(updateCurrentGameElementsUseCase)
final updateCurrentGameElementsUseCaseProvider =
    UpdateCurrentGameElementsUseCaseFamily._();

final class UpdateCurrentGameElementsUseCaseProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  UpdateCurrentGameElementsUseCaseProvider._({
    required UpdateCurrentGameElementsUseCaseFamily super.from,
    required List<String> super.argument,
  }) : super(
         retry: null,
         name: r'updateCurrentGameElementsUseCaseProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$updateCurrentGameElementsUseCaseHash();

  @override
  String toString() {
    return r'updateCurrentGameElementsUseCaseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    final argument = this.argument as List<String>;
    return updateCurrentGameElementsUseCase(ref, elements: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateCurrentGameElementsUseCaseProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$updateCurrentGameElementsUseCaseHash() =>
    r'68fd677b27502b3a6d131c0caa30b5eede141f2c';

final class UpdateCurrentGameElementsUseCaseFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<void>, List<String>> {
  UpdateCurrentGameElementsUseCaseFamily._()
    : super(
        retry: null,
        name: r'updateCurrentGameElementsUseCaseProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UpdateCurrentGameElementsUseCaseProvider call({
    required List<String> elements,
  }) => UpdateCurrentGameElementsUseCaseProvider._(
    argument: elements,
    from: this,
  );

  @override
  String toString() => r'updateCurrentGameElementsUseCaseProvider';
}
