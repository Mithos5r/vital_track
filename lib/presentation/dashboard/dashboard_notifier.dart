import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/firebase_auth/auth_repository_impl.dart';
import '../../data/health_metrics/health_repository_impl.dart';
import '../../domain/health_metrics/health_metric_entity.dart';

part 'dashboard_notifier.g.dart';

@riverpod
class DashboardNotifier extends _$DashboardNotifier {
  @override
  Stream<List<HealthMetricEntity>> build() {
    final user = ref.watch(authRepositoryProvider).currentUser;
    if (user == null) return Stream.value([]);
    
    return ref.watch(healthRepositoryProvider).watchHealthMetrics(user.uid);
  }

  Future<void> addMetric(HealthMetricEntity metric) async {
    // With streams, we don't need to manually update state, 
    // Drift will emit a new event which will trigger a rebuild.
    await ref.read(healthRepositoryProvider).saveHealthMetric(metric);
  }
}
