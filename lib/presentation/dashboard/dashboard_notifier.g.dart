// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DashboardNotifier)
final dashboardProvider = DashboardNotifierProvider._();

final class DashboardNotifierProvider
    extends
        $StreamNotifierProvider<DashboardNotifier, List<HealthMetricEntity>> {
  DashboardNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardNotifierHash();

  @$internal
  @override
  DashboardNotifier create() => DashboardNotifier();
}

String _$dashboardNotifierHash() => r'adeb5ad014ccee0d8a38929c9cf73c5fe5319fc3';

abstract class _$DashboardNotifier
    extends $StreamNotifier<List<HealthMetricEntity>> {
  Stream<List<HealthMetricEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<HealthMetricEntity>>,
              List<HealthMetricEntity>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<HealthMetricEntity>>,
                List<HealthMetricEntity>
              >,
              AsyncValue<List<HealthMetricEntity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
