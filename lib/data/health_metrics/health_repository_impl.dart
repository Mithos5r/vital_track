import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'app_database.dart';
import 'health_local_data_source.dart';
import '../../domain/health_metrics/health_metric_entity.dart';
import '../../domain/health_metrics/health_repository.dart';

part 'health_repository_impl.g.dart';

class HealthRepositoryImpl implements HealthRepository {
  final HealthLocalDataSource _dataSource;

  HealthRepositoryImpl(this._dataSource);

  @override
  Future<List<HealthMetricEntity>> getHealthMetrics(String userId) async {
    final metrics = await _dataSource.getMetricsByUser(userId);
    return metrics.map((m) => HealthMetricEntity(
      id: m.id,
      user: m.user,
      timestamp: m.timestamp,
      heartRate: m.heartRate,
      bloodOxygen: m.bloodOxygen,
      steps: m.steps,
      caloriesBurned: m.caloriesBurned,
      exerciseType: m.exerciseType,
      exerciseDuration: m.exerciseDuration,
    )).toList();
  }

  @override
  Future<void> saveHealthMetric(HealthMetricEntity entity) async {
    final companion = HealthMetricsCompanion.insert(
      user: entity.user,
      timestamp: entity.timestamp,
      heartRate: Value(entity.heartRate),
      bloodOxygen: Value(entity.bloodOxygen),
      steps: Value(entity.steps),
      caloriesBurned: Value(entity.caloriesBurned),
      exerciseType: Value(entity.exerciseType),
      exerciseDuration: Value(entity.exerciseDuration),
    );
    await _dataSource.insertMetric(companion);
  }
}

@riverpod
HealthLocalDataSource healthLocalDataSource(Ref ref) {
  return HealthLocalDataSource(ref.watch(appDatabaseProvider));
}

@riverpod
HealthRepository healthRepository(Ref ref) {
  return HealthRepositoryImpl(ref.watch(healthLocalDataSourceProvider));
}
