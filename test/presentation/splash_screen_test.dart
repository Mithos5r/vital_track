import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vital_track/data/firebase_auth/auth_repository_impl.dart';
import 'package:vital_track/domain/auth/auth_repository.dart';
import 'package:vital_track/presentation/auth/splash_screen.dart';
import 'package:vital_track/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
  });

  Widget createWidgetUnderTest() {
    return ProviderScope(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockAuthRepository),
      ],
      child: const MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [Locale('es')],
        home: SplashScreen(),
      ),
    );
  }

  group('SplashScreen Tests', () {
    testWidgets('renders all visual elements correctly', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(); // Just one pump for initial render

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Cargando...'), findsOneWidget);
      // Background color is checked via the Scaffold
      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffold.backgroundColor, const Color(0xFF4CAF50));
    });
  });
}
