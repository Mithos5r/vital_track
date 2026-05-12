import '../../domain/health_metrics/health_repository.dart';

class DeleteMetricUseCase {
  final HealthRepository _repository;

  DeleteMetricUseCase(this._repository);

  Future<void> execute(int id) async {
    await _repository.deleteHealthMetric(id);
  }
}
