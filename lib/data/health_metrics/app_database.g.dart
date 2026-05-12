// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $HealthMetricsTable extends HealthMetrics
    with TableInfo<$HealthMetricsTable, HealthMetric> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HealthMetricsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userMeta = const VerificationMeta('user');
  @override
  late final GeneratedColumn<String> user = GeneratedColumn<String>(
    'user',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heartRateMeta = const VerificationMeta(
    'heartRate',
  );
  @override
  late final GeneratedColumn<int> heartRate = GeneratedColumn<int>(
    'heart_rate',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bloodOxygenMeta = const VerificationMeta(
    'bloodOxygen',
  );
  @override
  late final GeneratedColumn<double> bloodOxygen = GeneratedColumn<double>(
    'blood_oxygen',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stepsMeta = const VerificationMeta('steps');
  @override
  late final GeneratedColumn<int> steps = GeneratedColumn<int>(
    'steps',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _caloriesBurnedMeta = const VerificationMeta(
    'caloriesBurned',
  );
  @override
  late final GeneratedColumn<int> caloriesBurned = GeneratedColumn<int>(
    'calories_burned',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _exerciseTypeMeta = const VerificationMeta(
    'exerciseType',
  );
  @override
  late final GeneratedColumn<String> exerciseType = GeneratedColumn<String>(
    'exercise_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _exerciseDurationMeta = const VerificationMeta(
    'exerciseDuration',
  );
  @override
  late final GeneratedColumn<int> exerciseDuration = GeneratedColumn<int>(
    'exercise_duration',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    user,
    timestamp,
    heartRate,
    bloodOxygen,
    steps,
    caloriesBurned,
    exerciseType,
    exerciseDuration,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'health_metrics';
  @override
  VerificationContext validateIntegrity(
    Insertable<HealthMetric> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user')) {
      context.handle(
        _userMeta,
        user.isAcceptableOrUnknown(data['user']!, _userMeta),
      );
    } else if (isInserting) {
      context.missing(_userMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('heart_rate')) {
      context.handle(
        _heartRateMeta,
        heartRate.isAcceptableOrUnknown(data['heart_rate']!, _heartRateMeta),
      );
    }
    if (data.containsKey('blood_oxygen')) {
      context.handle(
        _bloodOxygenMeta,
        bloodOxygen.isAcceptableOrUnknown(
          data['blood_oxygen']!,
          _bloodOxygenMeta,
        ),
      );
    }
    if (data.containsKey('steps')) {
      context.handle(
        _stepsMeta,
        steps.isAcceptableOrUnknown(data['steps']!, _stepsMeta),
      );
    }
    if (data.containsKey('calories_burned')) {
      context.handle(
        _caloriesBurnedMeta,
        caloriesBurned.isAcceptableOrUnknown(
          data['calories_burned']!,
          _caloriesBurnedMeta,
        ),
      );
    }
    if (data.containsKey('exercise_type')) {
      context.handle(
        _exerciseTypeMeta,
        exerciseType.isAcceptableOrUnknown(
          data['exercise_type']!,
          _exerciseTypeMeta,
        ),
      );
    }
    if (data.containsKey('exercise_duration')) {
      context.handle(
        _exerciseDurationMeta,
        exerciseDuration.isAcceptableOrUnknown(
          data['exercise_duration']!,
          _exerciseDurationMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HealthMetric map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HealthMetric(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      user: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      heartRate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}heart_rate'],
      ),
      bloodOxygen: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}blood_oxygen'],
      ),
      steps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}steps'],
      ),
      caloriesBurned: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}calories_burned'],
      ),
      exerciseType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_type'],
      ),
      exerciseDuration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercise_duration'],
      ),
    );
  }

  @override
  $HealthMetricsTable createAlias(String alias) {
    return $HealthMetricsTable(attachedDatabase, alias);
  }
}

class HealthMetric extends DataClass implements Insertable<HealthMetric> {
  final int id;
  final String user;
  final DateTime timestamp;
  final int? heartRate;
  final double? bloodOxygen;
  final int? steps;
  final int? caloriesBurned;
  final String? exerciseType;
  final int? exerciseDuration;
  const HealthMetric({
    required this.id,
    required this.user,
    required this.timestamp,
    this.heartRate,
    this.bloodOxygen,
    this.steps,
    this.caloriesBurned,
    this.exerciseType,
    this.exerciseDuration,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user'] = Variable<String>(user);
    map['timestamp'] = Variable<DateTime>(timestamp);
    if (!nullToAbsent || heartRate != null) {
      map['heart_rate'] = Variable<int>(heartRate);
    }
    if (!nullToAbsent || bloodOxygen != null) {
      map['blood_oxygen'] = Variable<double>(bloodOxygen);
    }
    if (!nullToAbsent || steps != null) {
      map['steps'] = Variable<int>(steps);
    }
    if (!nullToAbsent || caloriesBurned != null) {
      map['calories_burned'] = Variable<int>(caloriesBurned);
    }
    if (!nullToAbsent || exerciseType != null) {
      map['exercise_type'] = Variable<String>(exerciseType);
    }
    if (!nullToAbsent || exerciseDuration != null) {
      map['exercise_duration'] = Variable<int>(exerciseDuration);
    }
    return map;
  }

  HealthMetricsCompanion toCompanion(bool nullToAbsent) {
    return HealthMetricsCompanion(
      id: Value(id),
      user: Value(user),
      timestamp: Value(timestamp),
      heartRate: heartRate == null && nullToAbsent
          ? const Value.absent()
          : Value(heartRate),
      bloodOxygen: bloodOxygen == null && nullToAbsent
          ? const Value.absent()
          : Value(bloodOxygen),
      steps: steps == null && nullToAbsent
          ? const Value.absent()
          : Value(steps),
      caloriesBurned: caloriesBurned == null && nullToAbsent
          ? const Value.absent()
          : Value(caloriesBurned),
      exerciseType: exerciseType == null && nullToAbsent
          ? const Value.absent()
          : Value(exerciseType),
      exerciseDuration: exerciseDuration == null && nullToAbsent
          ? const Value.absent()
          : Value(exerciseDuration),
    );
  }

  factory HealthMetric.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HealthMetric(
      id: serializer.fromJson<int>(json['id']),
      user: serializer.fromJson<String>(json['user']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      heartRate: serializer.fromJson<int?>(json['heartRate']),
      bloodOxygen: serializer.fromJson<double?>(json['bloodOxygen']),
      steps: serializer.fromJson<int?>(json['steps']),
      caloriesBurned: serializer.fromJson<int?>(json['caloriesBurned']),
      exerciseType: serializer.fromJson<String?>(json['exerciseType']),
      exerciseDuration: serializer.fromJson<int?>(json['exerciseDuration']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'user': serializer.toJson<String>(user),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'heartRate': serializer.toJson<int?>(heartRate),
      'bloodOxygen': serializer.toJson<double?>(bloodOxygen),
      'steps': serializer.toJson<int?>(steps),
      'caloriesBurned': serializer.toJson<int?>(caloriesBurned),
      'exerciseType': serializer.toJson<String?>(exerciseType),
      'exerciseDuration': serializer.toJson<int?>(exerciseDuration),
    };
  }

  HealthMetric copyWith({
    int? id,
    String? user,
    DateTime? timestamp,
    Value<int?> heartRate = const Value.absent(),
    Value<double?> bloodOxygen = const Value.absent(),
    Value<int?> steps = const Value.absent(),
    Value<int?> caloriesBurned = const Value.absent(),
    Value<String?> exerciseType = const Value.absent(),
    Value<int?> exerciseDuration = const Value.absent(),
  }) => HealthMetric(
    id: id ?? this.id,
    user: user ?? this.user,
    timestamp: timestamp ?? this.timestamp,
    heartRate: heartRate.present ? heartRate.value : this.heartRate,
    bloodOxygen: bloodOxygen.present ? bloodOxygen.value : this.bloodOxygen,
    steps: steps.present ? steps.value : this.steps,
    caloriesBurned: caloriesBurned.present
        ? caloriesBurned.value
        : this.caloriesBurned,
    exerciseType: exerciseType.present ? exerciseType.value : this.exerciseType,
    exerciseDuration: exerciseDuration.present
        ? exerciseDuration.value
        : this.exerciseDuration,
  );
  HealthMetric copyWithCompanion(HealthMetricsCompanion data) {
    return HealthMetric(
      id: data.id.present ? data.id.value : this.id,
      user: data.user.present ? data.user.value : this.user,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      heartRate: data.heartRate.present ? data.heartRate.value : this.heartRate,
      bloodOxygen: data.bloodOxygen.present
          ? data.bloodOxygen.value
          : this.bloodOxygen,
      steps: data.steps.present ? data.steps.value : this.steps,
      caloriesBurned: data.caloriesBurned.present
          ? data.caloriesBurned.value
          : this.caloriesBurned,
      exerciseType: data.exerciseType.present
          ? data.exerciseType.value
          : this.exerciseType,
      exerciseDuration: data.exerciseDuration.present
          ? data.exerciseDuration.value
          : this.exerciseDuration,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HealthMetric(')
          ..write('id: $id, ')
          ..write('user: $user, ')
          ..write('timestamp: $timestamp, ')
          ..write('heartRate: $heartRate, ')
          ..write('bloodOxygen: $bloodOxygen, ')
          ..write('steps: $steps, ')
          ..write('caloriesBurned: $caloriesBurned, ')
          ..write('exerciseType: $exerciseType, ')
          ..write('exerciseDuration: $exerciseDuration')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    user,
    timestamp,
    heartRate,
    bloodOxygen,
    steps,
    caloriesBurned,
    exerciseType,
    exerciseDuration,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HealthMetric &&
          other.id == this.id &&
          other.user == this.user &&
          other.timestamp == this.timestamp &&
          other.heartRate == this.heartRate &&
          other.bloodOxygen == this.bloodOxygen &&
          other.steps == this.steps &&
          other.caloriesBurned == this.caloriesBurned &&
          other.exerciseType == this.exerciseType &&
          other.exerciseDuration == this.exerciseDuration);
}

class HealthMetricsCompanion extends UpdateCompanion<HealthMetric> {
  final Value<int> id;
  final Value<String> user;
  final Value<DateTime> timestamp;
  final Value<int?> heartRate;
  final Value<double?> bloodOxygen;
  final Value<int?> steps;
  final Value<int?> caloriesBurned;
  final Value<String?> exerciseType;
  final Value<int?> exerciseDuration;
  const HealthMetricsCompanion({
    this.id = const Value.absent(),
    this.user = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.heartRate = const Value.absent(),
    this.bloodOxygen = const Value.absent(),
    this.steps = const Value.absent(),
    this.caloriesBurned = const Value.absent(),
    this.exerciseType = const Value.absent(),
    this.exerciseDuration = const Value.absent(),
  });
  HealthMetricsCompanion.insert({
    this.id = const Value.absent(),
    required String user,
    required DateTime timestamp,
    this.heartRate = const Value.absent(),
    this.bloodOxygen = const Value.absent(),
    this.steps = const Value.absent(),
    this.caloriesBurned = const Value.absent(),
    this.exerciseType = const Value.absent(),
    this.exerciseDuration = const Value.absent(),
  }) : user = Value(user),
       timestamp = Value(timestamp);
  static Insertable<HealthMetric> custom({
    Expression<int>? id,
    Expression<String>? user,
    Expression<DateTime>? timestamp,
    Expression<int>? heartRate,
    Expression<double>? bloodOxygen,
    Expression<int>? steps,
    Expression<int>? caloriesBurned,
    Expression<String>? exerciseType,
    Expression<int>? exerciseDuration,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (user != null) 'user': user,
      if (timestamp != null) 'timestamp': timestamp,
      if (heartRate != null) 'heart_rate': heartRate,
      if (bloodOxygen != null) 'blood_oxygen': bloodOxygen,
      if (steps != null) 'steps': steps,
      if (caloriesBurned != null) 'calories_burned': caloriesBurned,
      if (exerciseType != null) 'exercise_type': exerciseType,
      if (exerciseDuration != null) 'exercise_duration': exerciseDuration,
    });
  }

  HealthMetricsCompanion copyWith({
    Value<int>? id,
    Value<String>? user,
    Value<DateTime>? timestamp,
    Value<int?>? heartRate,
    Value<double?>? bloodOxygen,
    Value<int?>? steps,
    Value<int?>? caloriesBurned,
    Value<String?>? exerciseType,
    Value<int?>? exerciseDuration,
  }) {
    return HealthMetricsCompanion(
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
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (user.present) {
      map['user'] = Variable<String>(user.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (heartRate.present) {
      map['heart_rate'] = Variable<int>(heartRate.value);
    }
    if (bloodOxygen.present) {
      map['blood_oxygen'] = Variable<double>(bloodOxygen.value);
    }
    if (steps.present) {
      map['steps'] = Variable<int>(steps.value);
    }
    if (caloriesBurned.present) {
      map['calories_burned'] = Variable<int>(caloriesBurned.value);
    }
    if (exerciseType.present) {
      map['exercise_type'] = Variable<String>(exerciseType.value);
    }
    if (exerciseDuration.present) {
      map['exercise_duration'] = Variable<int>(exerciseDuration.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HealthMetricsCompanion(')
          ..write('id: $id, ')
          ..write('user: $user, ')
          ..write('timestamp: $timestamp, ')
          ..write('heartRate: $heartRate, ')
          ..write('bloodOxygen: $bloodOxygen, ')
          ..write('steps: $steps, ')
          ..write('caloriesBurned: $caloriesBurned, ')
          ..write('exerciseType: $exerciseType, ')
          ..write('exerciseDuration: $exerciseDuration')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $HealthMetricsTable healthMetrics = $HealthMetricsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [healthMetrics];
}

typedef $$HealthMetricsTableCreateCompanionBuilder =
    HealthMetricsCompanion Function({
      Value<int> id,
      required String user,
      required DateTime timestamp,
      Value<int?> heartRate,
      Value<double?> bloodOxygen,
      Value<int?> steps,
      Value<int?> caloriesBurned,
      Value<String?> exerciseType,
      Value<int?> exerciseDuration,
    });
typedef $$HealthMetricsTableUpdateCompanionBuilder =
    HealthMetricsCompanion Function({
      Value<int> id,
      Value<String> user,
      Value<DateTime> timestamp,
      Value<int?> heartRate,
      Value<double?> bloodOxygen,
      Value<int?> steps,
      Value<int?> caloriesBurned,
      Value<String?> exerciseType,
      Value<int?> exerciseDuration,
    });

class $$HealthMetricsTableFilterComposer
    extends Composer<_$AppDatabase, $HealthMetricsTable> {
  $$HealthMetricsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get user => $composableBuilder(
    column: $table.user,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get heartRate => $composableBuilder(
    column: $table.heartRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bloodOxygen => $composableBuilder(
    column: $table.bloodOxygen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get caloriesBurned => $composableBuilder(
    column: $table.caloriesBurned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseType => $composableBuilder(
    column: $table.exerciseType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get exerciseDuration => $composableBuilder(
    column: $table.exerciseDuration,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HealthMetricsTableOrderingComposer
    extends Composer<_$AppDatabase, $HealthMetricsTable> {
  $$HealthMetricsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get user => $composableBuilder(
    column: $table.user,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get heartRate => $composableBuilder(
    column: $table.heartRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bloodOxygen => $composableBuilder(
    column: $table.bloodOxygen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get caloriesBurned => $composableBuilder(
    column: $table.caloriesBurned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseType => $composableBuilder(
    column: $table.exerciseType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get exerciseDuration => $composableBuilder(
    column: $table.exerciseDuration,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HealthMetricsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HealthMetricsTable> {
  $$HealthMetricsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get user =>
      $composableBuilder(column: $table.user, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<int> get heartRate =>
      $composableBuilder(column: $table.heartRate, builder: (column) => column);

  GeneratedColumn<double> get bloodOxygen => $composableBuilder(
    column: $table.bloodOxygen,
    builder: (column) => column,
  );

  GeneratedColumn<int> get steps =>
      $composableBuilder(column: $table.steps, builder: (column) => column);

  GeneratedColumn<int> get caloriesBurned => $composableBuilder(
    column: $table.caloriesBurned,
    builder: (column) => column,
  );

  GeneratedColumn<String> get exerciseType => $composableBuilder(
    column: $table.exerciseType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get exerciseDuration => $composableBuilder(
    column: $table.exerciseDuration,
    builder: (column) => column,
  );
}

class $$HealthMetricsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HealthMetricsTable,
          HealthMetric,
          $$HealthMetricsTableFilterComposer,
          $$HealthMetricsTableOrderingComposer,
          $$HealthMetricsTableAnnotationComposer,
          $$HealthMetricsTableCreateCompanionBuilder,
          $$HealthMetricsTableUpdateCompanionBuilder,
          (
            HealthMetric,
            BaseReferences<_$AppDatabase, $HealthMetricsTable, HealthMetric>,
          ),
          HealthMetric,
          PrefetchHooks Function()
        > {
  $$HealthMetricsTableTableManager(_$AppDatabase db, $HealthMetricsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HealthMetricsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HealthMetricsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HealthMetricsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> user = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<int?> heartRate = const Value.absent(),
                Value<double?> bloodOxygen = const Value.absent(),
                Value<int?> steps = const Value.absent(),
                Value<int?> caloriesBurned = const Value.absent(),
                Value<String?> exerciseType = const Value.absent(),
                Value<int?> exerciseDuration = const Value.absent(),
              }) => HealthMetricsCompanion(
                id: id,
                user: user,
                timestamp: timestamp,
                heartRate: heartRate,
                bloodOxygen: bloodOxygen,
                steps: steps,
                caloriesBurned: caloriesBurned,
                exerciseType: exerciseType,
                exerciseDuration: exerciseDuration,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String user,
                required DateTime timestamp,
                Value<int?> heartRate = const Value.absent(),
                Value<double?> bloodOxygen = const Value.absent(),
                Value<int?> steps = const Value.absent(),
                Value<int?> caloriesBurned = const Value.absent(),
                Value<String?> exerciseType = const Value.absent(),
                Value<int?> exerciseDuration = const Value.absent(),
              }) => HealthMetricsCompanion.insert(
                id: id,
                user: user,
                timestamp: timestamp,
                heartRate: heartRate,
                bloodOxygen: bloodOxygen,
                steps: steps,
                caloriesBurned: caloriesBurned,
                exerciseType: exerciseType,
                exerciseDuration: exerciseDuration,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HealthMetricsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HealthMetricsTable,
      HealthMetric,
      $$HealthMetricsTableFilterComposer,
      $$HealthMetricsTableOrderingComposer,
      $$HealthMetricsTableAnnotationComposer,
      $$HealthMetricsTableCreateCompanionBuilder,
      $$HealthMetricsTableUpdateCompanionBuilder,
      (
        HealthMetric,
        BaseReferences<_$AppDatabase, $HealthMetricsTable, HealthMetric>,
      ),
      HealthMetric,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$HealthMetricsTableTableManager get healthMetrics =>
      $$HealthMetricsTableTableManager(_db, _db.healthMetrics);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'18ce5c8c4d8ddbfe5a7d819d8fb7d5aca76bf416';
