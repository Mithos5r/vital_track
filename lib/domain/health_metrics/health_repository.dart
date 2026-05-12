import '../../domain/health_metrics/health_metric_entity.dart';

abstract class HealthRepository {
  Future<List<HealthMetricEntity>> getHealthMetrics(String userId);
  Stream<List<HealthMetricEntity>> watchHealthMetrics(String userId);
  Future<void> saveHealthMetric(HealthMetricEntity entity);
  Future<void> deleteHealthMetric(int id);
  Future<void> clearMetricProperty(int id, String property);
}
