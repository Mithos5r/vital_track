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
        $AsyncNotifierProvider<DashboardNotifier, List<HealthMetricEntity>> {
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

String _$dashboardNotifierHash() => r'438367cec622010fe4f4be5ce0a604cc36132d07';

abstract class _$DashboardNotifier
    extends $AsyncNotifier<List<HealthMetricEntity>> {
  FutureOr<List<HealthMetricEntity>> build();
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
