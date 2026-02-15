// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_statistics_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(updateUserStatisticsUseCase)
final updateUserStatisticsUseCaseProvider =
    UpdateUserStatisticsUseCaseFamily._();

final class UpdateUserStatisticsUseCaseProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  UpdateUserStatisticsUseCaseProvider._({
    required UpdateUserStatisticsUseCaseFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'updateUserStatisticsUseCaseProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$updateUserStatisticsUseCaseHash();

  @override
  String toString() {
    return r'updateUserStatisticsUseCaseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    final argument = this.argument as int;
    return updateUserStatisticsUseCase(ref, id: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateUserStatisticsUseCaseProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$updateUserStatisticsUseCaseHash() =>
    r'8176856cb55b705dedc78d1057a82e406135ec6b';

final class UpdateUserStatisticsUseCaseFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<void>, int> {
  UpdateUserStatisticsUseCaseFamily._()
    : super(
        retry: null,
        name: r'updateUserStatisticsUseCaseProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UpdateUserStatisticsUseCaseProvider call({required int id}) =>
      UpdateUserStatisticsUseCaseProvider._(argument: id, from: this);

  @override
  String toString() => r'updateUserStatisticsUseCaseProvider';
}
