import '../../domain/health_metrics/health_metric_entity.dart';
import '../../domain/health_metrics/health_repository.dart';
import 'health_app_data_source.dart';
import 'shared_prefs_data_source.dart';
import 'package:health/health.dart';

class SyncHealthUseCase {
  final HealthRepository _repository;
  final HealthAppDataSource _healthDataSource;
  final SharedPreferencesDataSource _prefsDataSource;
  final String _userId;

  SyncHealthUseCase({
    required HealthRepository repository,
    required HealthAppDataSource healthDataSource,
    required SharedPreferencesDataSource prefsDataSource,
    required String userId,
  })  : _repository = repository,
        _healthDataSource = healthDataSource,
        _prefsDataSource = prefsDataSource,
        _userId = userId;

  Future<void> execute() async {
    if (_prefsDataSource.isSyncStopped()) return;

    final hasPermission = await _healthDataSource.requestPermissions();
    if (!hasPermission) {
      await _prefsDataSource.setSyncStopped(true);
      return;
    }

    final now = DateTime.now();
    final lastSyncMillis = _prefsDataSource.getLastSyncTimestamp();
    final startTime = lastSyncMillis != null 
        ? DateTime.fromMillisecondsSinceEpoch(lastSyncMillis)
        : now.subtract(const Duration(days: 1));

    // Segment in 1-hour chunks
    DateTime currentStart = startTime;
    while (currentStart.isBefore(now)) {
      DateTime currentEnd = currentStart.add(const Duration(hours: 1));
      if (currentEnd.isAfter(now)) currentEnd = now;

      await _syncWindow(currentStart, currentEnd);
      currentStart = currentEnd;
    }

    await _prefsDataSource.setLastSyncTimestamp(now.millisecondsSinceEpoch);
  }

  Future<void> _syncWindow(DateTime start, DateTime end) async {
    final dataPoints = await _healthDataSource.fetchData(start, end);
    if (dataPoints.isEmpty) return;

    // Aggregation logic
    double? hrSum;
    int hrCount = 0;
    
    double? boSum;
    int boCount = 0;
    
    int totalSteps = 0;
    int totalCalories = 0;

    for (final dp in dataPoints) {
      final value = dp.value;
      if (value is NumericHealthValue) {
        switch (dp.type) {
          case HealthDataType.HEART_RATE:
            hrSum = (hrSum ?? 0) + value.numericValue;
            hrCount++;
            break;
          case HealthDataType.BLOOD_OXYGEN:
            boSum = (boSum ?? 0) + value.numericValue;
            boCount++;
            break;
          case HealthDataType.STEPS:
            totalSteps += value.numericValue.toInt();
            break;
          case HealthDataType.ACTIVE_ENERGY_BURNED:
            totalCalories += value.numericValue.toInt();
            break;
          default:
            break;
        }
      }
    }

    if (hrCount > 0 || boCount > 0 || totalSteps > 0 || totalCalories > 0) {
      await _repository.saveHealthMetric(HealthMetricEntity(
        user: _userId,
        timestamp: end, // Use the end of the window as record time
        heartRate: hrCount > 0 ? (hrSum! / hrCount).round() : null,
        bloodOxygen: boCount > 0 ? (boSum! / boCount) : null,
        steps: totalSteps > 0 ? totalSteps : null,
        caloriesBurned: totalCalories > 0 ? totalCalories : null,
      ));
    }
  }
}
