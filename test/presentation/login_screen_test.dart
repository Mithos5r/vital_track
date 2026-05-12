import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vital_track/data/firebase_auth/auth_repository_impl.dart';
import 'package:vital_track/domain/auth/auth_repository.dart';
import 'package:vital_track/domain/auth/user_entity.dart';
import 'package:vital_track/presentation/auth/login_screen.dart';
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
        home: LoginScreen(),
      ),
    );
  }

  group('LoginScreen Tests', () {
    testWidgets('shows validation errors when fields are empty', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      final loginButton = find.byType(ElevatedButton);
      await tester.tap(loginButton);
      await tester.pump();

      expect(find.text('Campo requerido'), findsNWidgets(2));
    });

    testWidgets('shows validation error for invalid email', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).first, 'invalid-email');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Email inválido'), findsOneWidget);
    });

    testWidgets('calls signIn and shows loading state', (tester) async {
      const email = 'test@example.com';
      const password = 'Password123';

      when(() => mockAuthRepository.signIn(email: email, password: password))
          .thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 1));
        return const UserEntity(uid: '123', email: email);
      });

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).first, email);
      await tester.enterText(find.byType(TextFormField).last, password);
      
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump(); // Start loading

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      await tester.pumpAndSettle(); // Finish loading
      verify(() => mockAuthRepository.signIn(email: email, password: password)).called(1);
    });
  });
}
