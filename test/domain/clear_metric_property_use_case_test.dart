import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vital_track/domain/health_metrics/clear_metric_property_use_case.dart';
import 'package:vital_track/domain/health_metrics/health_repository.dart';

class MockHealthRepository extends Mock implements HealthRepository {}

void main() {
  late MockHealthRepository repository;
  late ClearMetricPropertyUseCase useCase;

  setUp(() {
    repository = MockHealthRepository();
    useCase = ClearMetricPropertyUseCase(repository);
  });

  group('ClearMetricPropertyUseCase', () {
    test('calls repository clearMetricProperty with correct id and property', () async {
      const metricId = 42;
      const property = 'heartRate';
      when(() => repository.clearMetricProperty(metricId, property))
          .thenAnswer((_) async => {});

      await useCase.execute(metricId, property);

      verify(() => repository.clearMetricProperty(metricId, property)).called(1);
    });
  });
}
