import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vital_track/domain/health_metrics/delete_metric_use_case.dart';
import 'package:vital_track/domain/health_metrics/health_repository.dart';

class MockHealthRepository extends Mock implements HealthRepository {}

void main() {
  late MockHealthRepository repository;
  late DeleteMetricUseCase useCase;

  setUp(() {
    repository = MockHealthRepository();
    useCase = DeleteMetricUseCase(repository);
  });

  group('DeleteMetricUseCase', () {
    test('calls repository deleteHealthMetric with correct id', () async {
      const metricId = 42;
      when(() => repository.deleteHealthMetric(metricId)).thenAnswer((_) async => {});

      await useCase.execute(metricId);

      verify(() => repository.deleteHealthMetric(metricId)).called(1);
    });
  });
}
