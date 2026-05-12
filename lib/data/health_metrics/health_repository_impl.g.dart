// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(healthLocalDataSource)
final healthLocalDataSourceProvider = HealthLocalDataSourceProvider._();

final class HealthLocalDataSourceProvider
    extends
        $FunctionalProvider<
          HealthLocalDataSource,
          HealthLocalDataSource,
          HealthLocalDataSource
        >
    with $Provider<HealthLocalDataSource> {
  HealthLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'healthLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$healthLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<HealthLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HealthLocalDataSource create(Ref ref) {
    return healthLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HealthLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HealthLocalDataSource>(value),
    );
  }
}

String _$healthLocalDataSourceHash() =>
    r'0934dd4ecea4f51425ea4d41d85bd82989a27817';

@ProviderFor(healthRepository)
final healthRepositoryProvider = HealthRepositoryProvider._();

final class HealthRepositoryProvider
    extends
        $FunctionalProvider<
          HealthRepository,
          HealthRepository,
          HealthRepository
        >
    with $Provider<HealthRepository> {
  HealthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'healthRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$healthRepositoryHash();

  @$internal
  @override
  $ProviderElement<HealthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HealthRepository create(Ref ref) {
    return healthRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HealthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HealthRepository>(value),
    );
  }
}

String _$healthRepositoryHash() => r'e971e6c13df903fdb1d125b381226bc264eca43b';

@ProviderFor(deleteMetricUseCase)
final deleteMetricUseCaseProvider = DeleteMetricUseCaseProvider._();

final class DeleteMetricUseCaseProvider
    extends
        $FunctionalProvider<
          DeleteMetricUseCase,
          DeleteMetricUseCase,
          DeleteMetricUseCase
        >
    with $Provider<DeleteMetricUseCase> {
  DeleteMetricUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteMetricUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteMetricUseCaseHash();

  @$internal
  @override
  $ProviderElement<DeleteMetricUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeleteMetricUseCase create(Ref ref) {
    return deleteMetricUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteMetricUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteMetricUseCase>(value),
    );
  }
}

String _$deleteMetricUseCaseHash() =>
    r'3f9a2978555bfa676be91a48b0c838f89d29b512';
