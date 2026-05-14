// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_metric_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HealthMetricEntity _$HealthMetricEntityFromJson(Map<String, dynamic> json) =>
    HealthMetricEntity(
      id: (json['id'] as num?)?.toInt(),
      user: json['user'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      heartRate: (json['heart_rate'] as num?)?.toInt(),
      bloodOxygen: (json['blood_oxygen'] as num?)?.toDouble(),
      steps: (json['steps'] as num?)?.toInt(),
      caloriesBurned: (json['calories_burned'] as num?)?.toInt(),
      exerciseType: json['exercise_type'] as String?,
      exerciseDuration: (json['exercise_duration'] as num?)?.toInt(),
      sleep: (json['sleep'] as num?)?.toInt(),
    );

Map<String, dynamic> _$HealthMetricEntityToJson(HealthMetricEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'timestamp': instance.timestamp.toIso8601String(),
      'heart_rate': instance.heartRate,
      'blood_oxygen': instance.bloodOxygen,
      'steps': instance.steps,
      'calories_burned': instance.caloriesBurned,
      'exercise_type': instance.exerciseType,
      'exercise_duration': instance.exerciseDuration,
      'sleep': instance.sleep,
    };
