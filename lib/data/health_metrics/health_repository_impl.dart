import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'app_database.dart';
import 'health_local_data_source.dart';
import '../../domain/health_metrics/health_metric_entity.dart';
import '../../domain/health_metrics/health_repository.dart';
import '../../domain/health_metrics/delete_metric_use_case.dart';
import '../../domain/health_metrics/clear_metric_property_use_case.dart';

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
  Stream<List<HealthMetricEntity>> watchHealthMetrics(String userId) {
    return _dataSource.watchMetricsByUser(userId).map(
      (list) => list.map((m) => HealthMetricEntity(
        id: m.id,
        user: m.user,
        timestamp: m.timestamp,
        heartRate: m.heartRate,
        bloodOxygen: m.bloodOxygen,
        steps: m.steps,
        caloriesBurned: m.caloriesBurned,
        exerciseType: m.exerciseType,
        exerciseDuration: m.exerciseDuration,
      )).toList(),
    );
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

  @override
  Future<void> deleteHealthMetric(int id) async {
    await _dataSource.deleteMetric(id);
  }

  @override
  Future<void> clearMetricProperty(int id, String property) async {
    final companion = switch (property) {
      'heartRate' => HealthMetricsCompanion(id: Value(id), heartRate: const Value(null)),
      'bloodOxygen' => HealthMetricsCompanion(id: Value(id), bloodOxygen: const Value(null)),
      'steps' => HealthMetricsCompanion(id: Value(id), steps: const Value(null)),
      'calories' => HealthMetricsCompanion(id: Value(id), caloriesBurned: const Value(null)),
      'exercise' => HealthMetricsCompanion(
          id: Value(id),
          exerciseType: const Value(null),
          exerciseDuration: const Value(null),
        ),
      _ => null,
    };

    if (companion != null) {
      await _dataSource.updateMetric(companion);
    }
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

@riverpod
ClearMetricPropertyUseCase clearMetricPropertyUseCase(Ref ref) {
  return ClearMetricPropertyUseCase(ref.watch(healthRepositoryProvider));
}

@riverpod
DeleteMetricUseCase deleteMetricUseCase(Ref ref) {
  return DeleteMetricUseCase(ref.watch(healthRepositoryProvider));
}
