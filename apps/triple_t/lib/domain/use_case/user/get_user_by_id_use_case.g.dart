// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_by_id_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getUserByIdUseCase)
final getUserByIdUseCaseProvider = GetUserByIdUseCaseFamily._();

final class GetUserByIdUseCaseProvider
    extends $FunctionalProvider<UserModel?, UserModel?, UserModel?>
    with $Provider<UserModel?> {
  GetUserByIdUseCaseProvider._({
    required GetUserByIdUseCaseFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'getUserByIdUseCaseProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getUserByIdUseCaseHash();

  @override
  String toString() {
    return r'getUserByIdUseCaseProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<UserModel?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UserModel? create(Ref ref) {
    final argument = this.argument as int;
    return getUserByIdUseCase(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserModel? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserModel?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GetUserByIdUseCaseProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getUserByIdUseCaseHash() =>
    r'ac1f60942ee7e0a5df955a5f2eaf4a9793bc0a57';

final class GetUserByIdUseCaseFamily extends $Family
    with $FunctionalFamilyOverride<UserModel?, int> {
  GetUserByIdUseCaseFamily._()
    : super(
        retry: null,
        name: r'getUserByIdUseCaseProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetUserByIdUseCaseProvider call(int id) =>
      GetUserByIdUseCaseProvider._(argument: id, from: this);

  @override
  String toString() => r'getUserByIdUseCaseProvider';
}
