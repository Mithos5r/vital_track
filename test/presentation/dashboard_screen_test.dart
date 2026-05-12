import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vital_track/data/firebase_auth/auth_repository_impl.dart';
import 'package:vital_track/data/health_metrics/health_repository_impl.dart';
import 'package:vital_track/domain/auth/auth_repository.dart';
import 'package:vital_track/domain/auth/user_entity.dart';
import 'package:vital_track/domain/health_metrics/health_metric_entity.dart';
import 'package:vital_track/domain/health_metrics/health_repository.dart';
import 'package:vital_track/presentation/dashboard/dashboard_screen.dart';
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
    
    when(() => mockAuthRepository.currentUser).thenReturn(const UserEntity(uid: '123', email: 'test@test.com'));
  });

  Widget createWidgetUnderTest() {
    return ProviderScope(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockAuthRepository),
        healthRepositoryProvider.overrideWithValue(mockHealthRepository),
      ],
      child: const MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [Locale('es')],
        home: DashboardScreen(),
      ),
    );
  }

  group('DashboardScreen Tests', () {
    testWidgets('shows empty state when no metrics are available', (tester) async {
      when(() => mockHealthRepository.getHealthMetrics('123'))
          .thenAnswer((_) async => []);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('No esperes más. Pulsa + para añadir datos'), findsOneWidget);
    });

    testWidgets('shows metrics from multiple records (independent aggregation)', (tester) async {
      final now = DateTime.now();
      final metrics = [
        // Latest record: only exercise
        HealthMetricEntity(
          user: '123',
          timestamp: now,
          exerciseType: 'Running',
          exerciseDuration: 30,
        ),
        // Previous record: heart rate
        HealthMetricEntity(
          user: '123',
          timestamp: now.subtract(const Duration(hours: 1)),
          heartRate: 75,
        ),
        // Older record: steps and calories
        HealthMetricEntity(
          user: '123',
          timestamp: now.subtract(const Duration(days: 1)),
          steps: 10000,
          caloriesBurned: 500,
        ),
      ];

      when(() => mockHealthRepository.getHealthMetrics('123'))
          .thenAnswer((_) async => metrics);

      await tester.binding.setSurfaceSize(const Size(800, 1200));
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Check all metrics are from their latest available versions
      expect(find.text('75'), findsOneWidget);
      expect(find.text('10000'), findsOneWidget);
      expect(find.text('500'), findsOneWidget);
      
      // Exercise tile content: Duration is '30' and Unit is 'min'
      expect(find.text('30'), findsOneWidget);
      expect(find.text('min'), findsOneWidget);
      expect(find.text('Running'), findsOneWidget);

      await tester.binding.setSurfaceSize(null);
    });

    testWidgets('expands FAB and shows options when clicked', (tester) async {
      when(() => mockHealthRepository.getHealthMetrics('123'))
          .thenAnswer((_) async => []);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      final fabToggle = find.byType(FloatingActionButton).last;
      await tester.tap(fabToggle);
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.add), findsAtLeastNWidgets(1));
      expect(find.byIcon(Icons.logout), findsOneWidget);
    });
  });
}
