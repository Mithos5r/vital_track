import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_database.g.dart';

class HealthMetrics extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get user => text()(); // Firebase UID
  DateTimeColumn get timestamp => dateTime()();
  IntColumn get heartRate => integer().nullable()();
  RealColumn get bloodOxygen => real().nullable()();
  IntColumn get steps => integer().nullable()();
  IntColumn get caloriesBurned => integer().nullable()();
  TextColumn get exerciseType => text().nullable()();
  IntColumn get exerciseDuration => integer().nullable()();
}

@DriftDatabase(tables: [HealthMetrics])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'vital_track'));
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;
}

@riverpod
AppDatabase appDatabase(Ref ref) {
  return AppDatabase();
}
