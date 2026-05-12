import '../../domain/health_metrics/health_metric_entity.dart';

abstract class HealthRepository {
  Future<List<HealthMetricEntity>> getHealthMetrics(String userId);
  Future<void> saveHealthMetric(HealthMetricEntity entity);
}
