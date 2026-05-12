import 'package:health/health.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'health_app_data_source.g.dart';

class HealthAppDataSource {
  final Health _health = Health();

  static const List<HealthDataType> types = [
    HealthDataType.HEART_RATE,
    HealthDataType.STEPS,
    HealthDataType.BLOOD_OXYGEN,
    HealthDataType.ACTIVE_ENERGY_BURNED,
  ];

  Future<bool> requestPermissions() async {
    return await _health.requestAuthorization(types);
  }

  Future<List<HealthDataPoint>> fetchData(DateTime start, DateTime end) async {
    return await _health.getHealthDataFromTypes(
      startTime: start,
      endTime: end,
      types: types,
    );
  }
}

@riverpod
HealthAppDataSource healthAppDataSource(Ref ref) {
  return HealthAppDataSource();
}
