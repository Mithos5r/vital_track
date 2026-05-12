// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_auth_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(firebaseAuth)
final firebaseAuthProvider = FirebaseAuthProvider._();

final class FirebaseAuthProvider
    extends $FunctionalProvider<FirebaseAuth, FirebaseAuth, FirebaseAuth>
    with $Provider<FirebaseAuth> {
  FirebaseAuthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firebaseAuthProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firebaseAuthHash();

  @$internal
  @override
  $ProviderElement<FirebaseAuth> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FirebaseAuth create(Ref ref) {
    return firebaseAuth(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirebaseAuth value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirebaseAuth>(value),
    );
  }
}

String _$firebaseAuthHash() => r'912368c3df3f72e4295bf7a8cda93b9c5749d923';

@ProviderFor(firebaseAuthDataSource)
final firebaseAuthDataSourceProvider = FirebaseAuthDataSourceProvider._();

final class FirebaseAuthDataSourceProvider
    extends
        $FunctionalProvider<
          FirebaseAuthDataSource,
          FirebaseAuthDataSource,
          FirebaseAuthDataSource
        >
    with $Provider<FirebaseAuthDataSource> {
  FirebaseAuthDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firebaseAuthDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firebaseAuthDataSourceHash();

  @$internal
  @override
  $ProviderElement<FirebaseAuthDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FirebaseAuthDataSource create(Ref ref) {
    return firebaseAuthDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirebaseAuthDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirebaseAuthDataSource>(value),
    );
  }
}

String _$firebaseAuthDataSourceHash() =>
    r'889b9be1ec148b8ad5a262dd58a5dc159095cf53';
