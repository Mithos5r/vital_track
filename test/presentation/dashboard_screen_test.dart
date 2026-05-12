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
      expect(find.byIcon(Icons.analytics_outlined), findsOneWidget);
      expect(find.byIcon(Icons.add), findsNWidgets(2)); // AppBar + FAB (collapsed)
    });

    testWidgets('shows metrics in Bento Box when data is available', (tester) async {
      final metrics = [
        HealthMetricEntity(
          user: '123',
          timestamp: DateTime.now(),
          heartRate: 75,
          steps: 10000,
          caloriesBurned: 500,
          bloodOxygen: 98.0,
        ),
      ];

      when(() => mockHealthRepository.getHealthMetrics('123'))
          .thenAnswer((_) async => metrics);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('75'), findsOneWidget);
      expect(find.text('10000'), findsOneWidget);
      expect(find.text('500'), findsOneWidget);
      expect(find.text('98.0%'), findsOneWidget);
    });

    testWidgets('expands FAB and shows options when clicked', (tester) async {
      when(() => mockHealthRepository.getHealthMetrics('123'))
          .thenAnswer((_) async => []);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Find the main FAB toggle
      final mainFab = find.byIcon(Icons.menu_open_outlined).hitTestable().evaluate().isEmpty 
          ? find.byType(FloatingActionButton).last 
          : find.byIcon(Icons.menu_open_outlined);

      await tester.tap(mainFab);
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.add), findsNWidgets(2)); // AppBar + FAB (expanded)
      expect(find.byIcon(Icons.logout), findsOneWidget);
    });
  });
}
