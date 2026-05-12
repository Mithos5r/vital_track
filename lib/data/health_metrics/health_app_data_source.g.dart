// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_app_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(healthAppDataSource)
final healthAppDataSourceProvider = HealthAppDataSourceProvider._();

final class HealthAppDataSourceProvider
    extends
        $FunctionalProvider<
          HealthAppDataSource,
          HealthAppDataSource,
          HealthAppDataSource
        >
    with $Provider<HealthAppDataSource> {
  HealthAppDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'healthAppDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$healthAppDataSourceHash();

  @$internal
  @override
  $ProviderElement<HealthAppDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HealthAppDataSource create(Ref ref) {
    return healthAppDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HealthAppDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HealthAppDataSource>(value),
    );
  }
}

String _$healthAppDataSourceHash() =>
    r'63ddcbce8d2c533fec1c82b3d16dcdfa2fae7daa';
