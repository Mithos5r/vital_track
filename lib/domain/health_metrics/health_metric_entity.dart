import 'package:meta/meta.dart';

@immutable
class HealthMetricEntity {
  final int? id;
  final String user;
  final DateTime timestamp;
  final int? heartRate;
  final double? bloodOxygen;
  final int? steps;
  final int? caloriesBurned;
  final String? exerciseType;
  final int? exerciseDuration;

  const HealthMetricEntity({
    this.id,
    required this.user,
    required this.timestamp,
    this.heartRate,
    this.bloodOxygen,
    this.steps,
    this.caloriesBurned,
    this.exerciseType,
    this.exerciseDuration,
  });

  HealthMetricEntity copyWith({
    int? id,
    String? user,
    DateTime? timestamp,
    int? heartRate,
    double? bloodOxygen,
    int? steps,
    int? caloriesBurned,
    String? exerciseType,
    int? exerciseDuration,
  }) {
    return HealthMetricEntity(
      id: id ?? this.id,
      user: user ?? this.user,
      timestamp: timestamp ?? this.timestamp,
      heartRate: heartRate ?? this.heartRate,
      bloodOxygen: bloodOxygen ?? this.bloodOxygen,
      steps: steps ?? this.steps,
      caloriesBurned: caloriesBurned ?? this.caloriesBurned,
      exerciseType: exerciseType ?? this.exerciseType,
      exerciseDuration: exerciseDuration ?? this.exerciseDuration,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthMetricEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          user == other.user &&
          timestamp == other.timestamp;

  @override
  int get hashCode => id.hashCode ^ user.hashCode ^ timestamp.hashCode;
}
