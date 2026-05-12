import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
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
  AppDatabase() : super(_openConnection());
  AppDatabase.forTesting(QueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'vital_track.sqlite'));
      return NativeDatabase(file);
    });
  }
}

@riverpod
AppDatabase appDatabase(Ref ref) {
  return AppDatabase();
}
