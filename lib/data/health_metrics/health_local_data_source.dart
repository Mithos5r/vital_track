import 'package:drift/drift.dart';
import 'app_database.dart';
import '../../domain/health_metrics/health_metric_entity.dart';

class HealthLocalDataSource {
  final AppDatabase _db;

  HealthLocalDataSource(this._db);

  Future<int> insertMetric(HealthMetricsCompanion companion) {
    return _db.into(_db.healthMetrics).insert(companion);
  }

  Future<List<HealthMetric>> getMetricsByUser(String userId) {
    return (_db.select(_db.healthMetrics)..where((t) => t.user.equals(userId))).get();
  }

  Future<List<HealthMetric>> getLatestMetricsByUser(String userId) {
    return (_db.select(_db.healthMetrics)
          ..where((t) => t.user.equals(userId))
          ..orderBy([(t) => OrderingTerm(expression: t.timestamp, mode: OrderingMode.desc)])
          ..limit(10))
        .get();
  }

  Future<void> deleteMetric(int id) {
    return (_db.delete(_db.healthMetrics)..where((t) => t.id.equals(id))).go();
  }
}
