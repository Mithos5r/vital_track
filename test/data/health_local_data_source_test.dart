import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vital_track/data/health_metrics/app_database.dart';
import 'package:vital_track/data/health_metrics/health_local_data_source.dart';

void main() {
  late AppDatabase database;
  late HealthLocalDataSource dataSource;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    dataSource = HealthLocalDataSource(database);
  });

  tearDown(() async {
    await database.close();
  });

  group('HealthLocalDataSource', () {
    const userId = 'user_123';

    test('insertMetric and getMetricsByUser returns correct data', () async {
      final now = DateTime.now();
      await dataSource.insertMetric(HealthMetricsCompanion.insert(
        user: userId,
        timestamp: now,
        heartRate: const Value(75),
      ));

      final results = await dataSource.getMetricsByUser(userId);

      expect(results.length, 1);
      expect(results.first.user, userId);
      expect(results.first.heartRate, 75);
    });

    test('getLatestMetricsByUser returns limited results ordered by date', () async {
      for (var i = 0; i < 15; i++) {
        await dataSource.insertMetric(HealthMetricsCompanion.insert(
          user: userId,
          timestamp: DateTime.now().add(Duration(minutes: i)),
        ));
      }

      final results = await dataSource.getLatestMetricsByUser(userId);

      expect(results.length, 10);
      expect(results[0].timestamp.isAfter(results[1].timestamp), isTrue);
    });
  });
}
