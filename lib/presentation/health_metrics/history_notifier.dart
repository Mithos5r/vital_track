import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/firebase_auth/auth_repository_impl.dart';
import '../../data/health_metrics/health_repository_impl.dart';
import '../../domain/health_metrics/health_metric_entity.dart';

part 'history_notifier.g.dart';

@riverpod
class HistoryNotifier extends _$HistoryNotifier {
  @override
  Stream<List<HealthMetricEntity>> build(String param) {
    final user = ref.watch(authRepositoryProvider).currentUser;
    if (user == null) return Stream.value([]);

    return ref.watch(healthRepositoryProvider).watchHealthMetrics(user.uid).map((allMetrics) {
      // Filter metrics that have data for the specific parameter
      return allMetrics.where((m) {
        return switch (param) {
          'heartRate' => m.heartRate != null,
          'bloodOxygen' => m.bloodOxygen != null,
          'steps' => m.steps != null,
          'calories' => m.caloriesBurned != null,
          'exercise' => m.exerciseDuration != null || m.exerciseType != null,
          _ => false,
        };
      }).toList();
    });
  }

  Future<void> deleteMetric(int id) async {
    await ref.read(clearMetricPropertyUseCaseProvider).execute(id, param);
  }
}
