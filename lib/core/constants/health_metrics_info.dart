import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

sealed class HealthMetricInfo {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String id;

  const HealthMetricInfo({
    required this.id,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  });

  String getTitle(AppLocalizations l10n);
  String getUnit(AppLocalizations l10n);

  static List<HealthMetricInfo> get all => [
        const HeartRateInfo(),
        const StepsInfo(),
        const CaloriesInfo(),
        const BloodOxygenInfo(),
        const ExerciseInfo(),
      ];

  static HealthMetricInfo fromId(String id) {
    return all.firstWhere(
      (info) => info.id == id,
      orElse: () => const HeartRateInfo(),
    );
  }
}

class HeartRateInfo extends HealthMetricInfo {
  const HeartRateInfo()
      : super(
          id: 'heartRate',
          icon: Icons.favorite,
          iconColor: Colors.red,
          backgroundColor: const Color(0xFFFFEBEE), // Colors.red.shade50
        );

  @override
  String getTitle(AppLocalizations l10n) => l10n.heartRate;

  @override
  String getUnit(AppLocalizations l10n) => 'bpm';
}

class StepsInfo extends HealthMetricInfo {
  const StepsInfo()
      : super(
          id: 'steps',
          icon: Icons.directions_walk,
          iconColor: Colors.blue,
          backgroundColor: const Color(0xFFE3F2FD), // Colors.blue.shade50
        );

  @override
  String getTitle(AppLocalizations l10n) => l10n.steps;

  @override
  String getUnit(AppLocalizations l10n) => '';
}

class CaloriesInfo extends HealthMetricInfo {
  const CaloriesInfo()
      : super(
          id: 'calories',
          icon: Icons.local_fire_department,
          iconColor: Colors.orange,
          backgroundColor: const Color(0xFFFFF3E0), // Colors.orange.shade50
        );

  @override
  String getTitle(AppLocalizations l10n) => l10n.calories;

  @override
  String getUnit(AppLocalizations l10n) => 'kcal';
}

class BloodOxygenInfo extends HealthMetricInfo {
  const BloodOxygenInfo()
      : super(
          id: 'bloodOxygen',
          icon: Icons.opacity,
          iconColor: Colors.teal,
          backgroundColor: const Color(0xFFE0F2F1), // Colors.teal.shade50
        );

  @override
  String getTitle(AppLocalizations l10n) => l10n.bloodOxygen;

  @override
  String getUnit(AppLocalizations l10n) => '%';
}

class ExerciseInfo extends HealthMetricInfo {
  const ExerciseInfo()
      : super(
          id: 'exercise',
          icon: Icons.fitness_center,
          iconColor: Colors.purple,
          backgroundColor: const Color(0xFFF3E5F5), // Colors.purple.shade50
        );

  @override
  String getTitle(AppLocalizations l10n) => l10n.exercise;

  @override
  String getUnit(AppLocalizations l10n) => 'min';
}
