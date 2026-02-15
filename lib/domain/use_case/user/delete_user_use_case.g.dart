// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_user_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deleteUserUseCase)
final deleteUserUseCaseProvider = DeleteUserUseCaseFamily._();

final class DeleteUserUseCaseProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  DeleteUserUseCaseProvider._({
    required DeleteUserUseCaseFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'deleteUserUseCaseProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$deleteUserUseCaseHash();

  @override
  String toString() {
    return r'deleteUserUseCaseProvider'
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
    return deleteUserUseCase(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteUserUseCaseProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$deleteUserUseCaseHash() => r'5751ea421ab0932b8304d18310bca66fa526089a';

final class DeleteUserUseCaseFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<void>, int> {
  DeleteUserUseCaseFamily._()
    : super(
        retry: null,
        name: r'deleteUserUseCaseProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DeleteUserUseCaseProvider call(int id) =>
      DeleteUserUseCaseProvider._(argument: id, from: this);

  @override
  String toString() => r'deleteUserUseCaseProvider';
}
