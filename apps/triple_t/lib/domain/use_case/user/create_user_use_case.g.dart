// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_user_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(createUserUseCase)
final createUserUseCaseProvider = CreateUserUseCaseFamily._();

final class CreateUserUseCaseProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  CreateUserUseCaseProvider._({
    required CreateUserUseCaseFamily super.from,
    required UserModel super.argument,
  }) : super(
         retry: null,
         name: r'createUserUseCaseProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$createUserUseCaseHash();

  @override
  String toString() {
    return r'createUserUseCaseProvider'
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
    return createUserUseCase(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateUserUseCaseProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$createUserUseCaseHash() => r'806203eb95819880ce22c34f6e2ac30f6a89e3cc';

final class CreateUserUseCaseFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<bool>, UserModel> {
  CreateUserUseCaseFamily._()
    : super(
        retry: null,
        name: r'createUserUseCaseProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CreateUserUseCaseProvider call(UserModel user) =>
      CreateUserUseCaseProvider._(argument: user, from: this);

  @override
  String toString() => r'createUserUseCaseProvider';
}
