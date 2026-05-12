import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vital_track/domain/health_metrics/export_health_data_use_case.dart';
import 'package:vital_track/domain/health_metrics/health_metric_entity.dart';
import 'package:vital_track/domain/health_metrics/health_repository.dart';

class MockHealthRepository extends Mock implements HealthRepository {}

void main() {
  late MockHealthRepository repository;
  late ExportHealthDataUseCase useCase;

  setUp(() {
    repository = MockHealthRepository();
    useCase = ExportHealthDataUseCase(repository);
  });

  group('ExportHealthDataUseCase', () {
    test('exports data since a specific date as JSON', () async {
      const userId = 'user1';
      final sinceDate = DateTime(2026, 5, 1);
      final metrics = [
        HealthMetricEntity(
          id: 1,
          user: userId,
          timestamp: DateTime(2026, 5, 12, 10, 0),
          heartRate: 75,
          steps: 5000,
        ),
      ];

      when(() => repository.getHealthMetricsSince(userId, sinceDate))
          .thenAnswer((_) async => metrics);

      final result = await useCase.execute(userId: userId, sinceDate: sinceDate);

      // Verify JSON structure
      final List decoded = jsonDecode(result);
      expect(decoded.length, 1);
      expect(decoded[0]['heart_rate'], 75);
      expect(decoded[0]['steps'], 5000);
      expect(decoded[0]['user'], userId);
      
      verify(() => repository.getHealthMetricsSince(userId, sinceDate)).called(1);
    });

    test('returns empty list JSON if no data is found', () async {
      const userId = 'user1';
      final sinceDate = DateTime.now();

      when(() => repository.getHealthMetricsSince(userId, sinceDate))
          .thenAnswer((_) async => []);

      final result = await useCase.execute(userId: userId, sinceDate: sinceDate);

      expect(result, '[]');
    });
  });
}
