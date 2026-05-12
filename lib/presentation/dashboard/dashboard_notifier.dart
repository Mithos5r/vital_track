import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/firebase_auth/auth_repository_impl.dart';
import '../../data/health_metrics/health_repository_impl.dart';
import '../../domain/health_metrics/health_metric_entity.dart';

part 'dashboard_notifier.g.dart';

@riverpod
class DashboardNotifier extends _$DashboardNotifier {
  @override
  FutureOr<List<HealthMetricEntity>> build() async {
    final user = ref.watch(authRepositoryProvider).currentUser;
    if (user == null) return [];
    
    return ref.watch(healthRepositoryProvider).getHealthMetrics(user.uid);
  }

  Future<void> addMetric(HealthMetricEntity metric) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(healthRepositoryProvider).saveHealthMetric(metric);
      return ref.read(healthRepositoryProvider).getHealthMetrics(metric.user);
    });
  }
}
