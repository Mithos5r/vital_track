import '../../domain/health_metrics/health_repository.dart';

class ClearMetricPropertyUseCase {
  final HealthRepository _repository;

  ClearMetricPropertyUseCase(this._repository);

  Future<void> execute(int id, String property) async {
    await _repository.clearMetricProperty(id, property);
  }
}
