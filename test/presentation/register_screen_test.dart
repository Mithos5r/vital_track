import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vital_track/data/firebase_auth/auth_repository_impl.dart';
import 'package:vital_track/domain/auth/auth_repository.dart';
import 'package:vital_track/domain/auth/user_entity.dart';
import 'package:vital_track/presentation/auth/register_screen.dart';
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
        home: RegisterScreen(),
      ),
    );
  }

  group('RegisterScreen Tests', () {
    testWidgets('shows validation errors when fields are empty', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      final registerButton = find.byType(ElevatedButton);
      await tester.tap(registerButton);
      await tester.pump();

      expect(find.text('Campo requerido'), findsNWidgets(3));
    });

    testWidgets('validates password security rules', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      final passwordField = find.byType(TextFormField).at(1);

      // Rule: Length
      await tester.enterText(passwordField, '12345');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(find.text('Mínimo 6 caracteres'), findsOneWidget);

      // Rule: Uppercase
      await tester.enterText(passwordField, 'password123!');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(find.text('Requiere una mayúscula'), findsOneWidget);

      // Rule: Lowercase
      await tester.enterText(passwordField, 'PASSWORD123!');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(find.text('Requiere una minúscula'), findsOneWidget);

      // Rule: Digit
      await tester.enterText(passwordField, 'Password!');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(find.text('Requiere un número'), findsOneWidget);

      // Rule: Special Character
      await tester.enterText(passwordField, 'Password123');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(find.text('Requiere un carácter especial'), findsOneWidget);
    });

    testWidgets('validates that passwords match', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).at(1), 'Password123!');
      await tester.enterText(find.byType(TextFormField).at(2), 'Password123');
      
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Las contraseñas no coinciden'), findsOneWidget);
    });

    testWidgets('calls signUp on valid input', (tester) async {
      const email = 'newuser@example.com';
      const password = 'Password123!';

      when(() => mockAuthRepository.signUp(email: email, password: password))
          .thenAnswer((_) async => const UserEntity(uid: '456', email: email));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).at(0), email);
      await tester.enterText(find.byType(TextFormField).at(1), password);
      await tester.enterText(find.byType(TextFormField).at(2), password);
      
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      verify(() => mockAuthRepository.signUp(email: email, password: password)).called(1);
    });
  });
}
