import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vital_track/domain/auth/user_entity.dart';
import 'package:vital_track/domain/auth/auth_repository.dart';
import 'package:vital_track/domain/health_metrics/health_metric_entity.dart';
import 'package:vital_track/domain/health_metrics/health_repository.dart';
import 'package:vital_track/data/firebase_auth/auth_repository_impl.dart';
import 'package:vital_track/data/health_metrics/health_repository_impl.dart';
import 'package:vital_track/presentation/health_metrics/history_screen.dart';
import 'package:vital_track/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MockAuthRepository extends Mock implements AuthRepository {}
class MockHealthRepository extends Mock implements HealthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late MockHealthRepository mockHealthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockHealthRepository = MockHealthRepository();
    
    when(() => mockAuthRepository.currentUser).thenReturn(
      const UserEntity(uid: '123', email: 'test@test.com')
    );
  });

  Widget createWidgetUnderTest(String param) {
    return ProviderScope(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockAuthRepository),
        healthRepositoryProvider.overrideWithValue(mockHealthRepository),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [Locale('es')],
        home: HistoryScreen(param: param),
      ),
    );
  }

  group('HistoryScreen Tests', () {
    testWidgets('shows empty state when no metrics match the param', (tester) async {
      when(() => mockHealthRepository.watchHealthMetrics('123'))
          .thenAnswer((_) => Stream.value([]));

      await tester.pumpWidget(createWidgetUnderTest('steps'));
      await tester.pumpAndSettle();

      expect(find.textContaining('No hay registros disponibles'), findsOneWidget);
      expect(find.byIcon(Icons.history), findsOneWidget);
    });

    testWidgets('shows list of heart rate metrics', (tester) async {
      final metrics = [
        HealthMetricEntity(
          user: '123',
          timestamp: DateTime(2026, 5, 12, 10, 0),
          heartRate: 75,
        ),
        HealthMetricEntity(
          user: '123',
          timestamp: DateTime(2026, 5, 12, 11, 0),
          heartRate: 85,
        ),
      ];

      when(() => mockHealthRepository.watchHealthMetrics('123'))
          .thenAnswer((_) => Stream.value(metrics));

      await tester.pumpWidget(createWidgetUnderTest('heartRate'));
      await tester.pumpAndSettle();

      expect(find.text('75 bpm'), findsOneWidget);
      expect(find.text('85 bpm'), findsOneWidget);
      expect(find.text('12/05/2026 10:00'), findsOneWidget);
      expect(find.text('12/05/2026 11:00'), findsOneWidget);
    });

    testWidgets('shows detailed exercise information', (tester) async {
      final metrics = [
        HealthMetricEntity(
          user: '123',
          timestamp: DateTime(2026, 5, 12, 15, 0),
          exerciseType: 'Running',
          exerciseDuration: 45,
        ),
      ];

      when(() => mockHealthRepository.watchHealthMetrics('123'))
          .thenAnswer((_) => Stream.value(metrics));

      await tester.pumpWidget(createWidgetUnderTest('exercise'));
      await tester.pumpAndSettle();

      expect(find.text('Running'), findsOneWidget);
      expect(find.text('45 min'), findsOneWidget);
      expect(find.text('12/05/2026 15:00'), findsOneWidget);
    });
  });
}
