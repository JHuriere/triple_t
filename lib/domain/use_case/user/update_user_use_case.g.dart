// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(updateUserUseCase)
final updateUserUseCaseProvider = UpdateUserUseCaseFamily._();

final class UpdateUserUseCaseProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  UpdateUserUseCaseProvider._({
    required UpdateUserUseCaseFamily super.from,
    required UserModel super.argument,
  }) : super(
         retry: null,
         name: r'updateUserUseCaseProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$updateUserUseCaseHash();

  @override
  String toString() {
    return r'updateUserUseCaseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    final argument = this.argument as UserModel;
    return updateUserUseCase(ref, user: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateUserUseCaseProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$updateUserUseCaseHash() => r'91da97b0914541008b552950db8e2a043a3e4ed9';

final class UpdateUserUseCaseFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<bool>, UserModel> {
  UpdateUserUseCaseFamily._()
    : super(
        retry: null,
        name: r'updateUserUseCaseProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UpdateUserUseCaseProvider call({required UserModel user}) =>
      UpdateUserUseCaseProvider._(argument: user, from: this);

  @override
  String toString() => r'updateUserUseCaseProvider';
}
