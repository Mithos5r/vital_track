import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vital_track/data/firebase_auth/firebase_auth_data_source.dart';
import 'package:vital_track/domain/auth/auth_exceptions.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockUserCredential extends Mock implements UserCredential {}

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late FirebaseAuthDataSource dataSource;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    dataSource = FirebaseAuthDataSource(mockFirebaseAuth);
  });

  group('FirebaseAuthDataSource', () {
    const email = 'test@example.com';
    const password = 'password123';

    test('signIn returns UserCredential on success', () async {
      final mockCredential = MockUserCredential();
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          )).thenAnswer((_) async => mockCredential);

      final result = await dataSource.signIn(email, password);

      expect(result, mockCredential);
      verify(() => mockFirebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          )).called(1);
    });

    test('signIn throws UserNotFoundException on user-not-found code', () async {
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          )).thenThrow(FirebaseAuthException(code: 'user-not-found'));

      expect(() => dataSource.signIn(email, password),
          throwsA(isA<UserNotFoundException>()));
    });

    test('signIn throws WrongPasswordException on wrong-password code', () async {
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          )).thenThrow(FirebaseAuthException(code: 'wrong-password'));

      expect(() => dataSource.signIn(email, password),
          throwsA(isA<WrongPasswordException>()));
    });

    test('signUp returns UserCredential on success', () async {
      final mockCredential = MockUserCredential();
      when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          )).thenAnswer((_) async => mockCredential);

      final result = await dataSource.signUp(email, password);

      expect(result, mockCredential);
    });

    test('signUp throws EmailAlreadyInUseException on email-already-in-use', () async {
      when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          )).thenThrow(FirebaseAuthException(code: 'email-already-in-use'));

      expect(() => dataSource.signUp(email, password),
          throwsA(isA<EmailAlreadyInUseException>()));
    });
  });
}
