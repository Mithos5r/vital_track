import 'package:flutter_test/flutter_test.dart';
import 'package:health/health.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vital_track/data/health_metrics/health_app_data_source.dart';
import 'package:vital_track/data/health_metrics/shared_prefs_data_source.dart';
import 'package:vital_track/data/health_metrics/sync_health_use_case.dart';
import 'package:vital_track/domain/health_metrics/health_metric_entity.dart';
import 'package:vital_track/domain/health_metrics/health_repository.dart';

class MockHealthRepository extends Mock implements HealthRepository {}
class MockHealthAppDataSource extends Mock implements HealthAppDataSource {}
class MockSharedPreferencesDataSource extends Mock implements SharedPreferencesDataSource {}

void main() {
  late MockHealthRepository repository;
  late MockHealthAppDataSource healthDataSource;
  late MockSharedPreferencesDataSource prefsDataSource;
  late SyncHealthUseCase useCase;

  const userId = 'test_user';

  setUpAll(() {
    registerFallbackValue(HealthMetricEntity(user: userId, timestamp: DateTime.now()));
  });

  setUp(() {
    repository = MockHealthRepository();
    healthDataSource = MockHealthAppDataSource();
    prefsDataSource = MockSharedPreferencesDataSource();
    useCase = SyncHealthUseCase(
      repository: repository,
      healthDataSource: healthDataSource,
      prefsDataSource: prefsDataSource,
      userId: userId,
    );
  });

  group('SyncHealthUseCase', () {
    test('execute stops if sync is disabled in prefs', () async {
      when(() => prefsDataSource.isSyncStopped()).thenReturn(true);

      await useCase.execute();

      verifyNever(() => healthDataSource.requestPermissions());
    });

    test('execute sets stop flag if permission is denied', () async {
      when(() => prefsDataSource.isSyncStopped()).thenReturn(false);
      when(() => healthDataSource.requestPermissions()).thenAnswer((_) async => false);
      when(() => prefsDataSource.setSyncStopped(true)).thenAnswer((_) async => {});

      await useCase.execute();

      verify(() => prefsDataSource.setSyncStopped(true)).called(1);
    });

    test('execute segments time and aggregates data correctly', () async {
      final now = DateTime(2026, 5, 12, 12, 0); 
      final lastSync = now.subtract(const Duration(hours: 2));

      when(() => prefsDataSource.isSyncStopped()).thenReturn(false);
      when(() => healthDataSource.requestPermissions()).thenAnswer((_) async => true);
      when(() => prefsDataSource.getLastSyncTimestamp()).thenReturn(lastSync.millisecondsSinceEpoch);
      when(() => prefsDataSource.setLastSyncTimestamp(any())).thenAnswer((_) async => {});
      when(() => repository.saveHealthMetric(any())).thenAnswer((_) async => {});

      final dp1 = HealthDataPoint(
        uuid: '1',
        value: NumericHealthValue(numericValue: 80),
        type: HealthDataType.HEART_RATE,
        unit: HealthDataUnit.BEATS_PER_MINUTE,
        dateFrom: lastSync,
        dateTo: lastSync.add(const Duration(minutes: 5)),
        sourcePlatform: HealthPlatformType.appleHealth,
        sourceDeviceId: 'device1',
        sourceId: 'source1',
        sourceName: 'source1',
      );
      
      final dp2 = HealthDataPoint(
        uuid: '2',
        value: NumericHealthValue(numericValue: 100),
        type: HealthDataType.STEPS,
        unit: HealthDataUnit.COUNT,
        dateFrom: lastSync,
        dateTo: lastSync.add(const Duration(minutes: 5)),
        sourcePlatform: HealthPlatformType.appleHealth,
        sourceDeviceId: 'device1',
        sourceId: 'source1',
        sourceName: 'source1',
      );

      when(() => healthDataSource.fetchData(any(), any()))
          .thenAnswer((invocation) async {
            final start = invocation.positionalArguments[0] as DateTime;
            if (start.hour == 10) return [dp1, dp2];
            return [];
          });

      await useCase.execute();

      verify(() => repository.saveHealthMetric(any(that: predicate((HealthMetricEntity m) {
        return m.heartRate == 80 && m.steps == 100;
      })))).called(1);
    });
  });
}
