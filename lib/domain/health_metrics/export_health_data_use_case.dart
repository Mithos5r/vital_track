import 'dart:convert';
import '../../domain/health_metrics/health_repository.dart';

class ExportHealthDataUseCase {
  final HealthRepository _repository;

  ExportHealthDataUseCase(this._repository);

  /// Exports all health metrics for a user since [sinceDate] as a JSON string.
  /// The JSON structure is a flat list of health metric records.
  Future<String> execute({
    required String userId,
    required DateTime sinceDate,
  }) async {
    final metrics = await _repository.getHealthMetricsSince(userId, sinceDate);
    
    // Map entities to JSON-serializable maps
    final jsonData = metrics.map((e) => e.toJson()).toList();
    
    // Encode as a pretty-printed or flat JSON string. 
    // Usually flat is better for storage/API, pretty for debug.
    return jsonEncode(jsonData);
  }
}
