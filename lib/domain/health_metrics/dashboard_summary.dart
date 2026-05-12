import 'health_metric_entity.dart';

class DashboardSummary {
  final int? heartRate;
  final double? bloodOxygen;
  final int? steps;
  final int? caloriesBurned;
  final String? exerciseType;
  final int? exerciseDuration;

  const DashboardSummary({
    this.heartRate,
    this.bloodOxygen,
    this.steps,
    this.caloriesBurned,
    this.exerciseType,
    this.exerciseDuration,
  });

  factory DashboardSummary.fromHistory(List<HealthMetricEntity> history) {
    if (history.isEmpty) return const DashboardSummary();

    int? hr;
    double? bo;
    int? st;
    int? cal;
    String? exType;
    int? exDur;

    // History is assumed to be sorted by timestamp DESC
    for (final record in history) {
      hr ??= record.heartRate;
      bo ??= record.bloodOxygen;
      st ??= record.steps;
      cal ??= record.caloriesBurned;
      
      // Exercise is treated as a pair (or at least duration)
      if (exDur == null && record.exerciseDuration != null) {
        exDur = record.exerciseDuration;
        exType = record.exerciseType;
      }
      
      // Break early if we have all metrics
      if (hr != null && bo != null && st != null && cal != null && exDur != null) {
        break;
      }
    }

    return DashboardSummary(
      heartRate: hr,
      bloodOxygen: bo,
      steps: st,
      caloriesBurned: cal,
      exerciseType: exType,
      exerciseDuration: exDur,
    );
  }
}
