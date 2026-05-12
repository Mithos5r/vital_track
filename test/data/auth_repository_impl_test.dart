import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vital_track/data/firebase_auth/auth_repository_impl.dart';
import 'package:vital_track/data/firebase_auth/firebase_auth_data_source.dart';
import 'package:vital_track/domain/auth/user_entity.dart';

class MockFirebaseAuthDataSource extends Mock implements FirebaseAuthDataSource {}
class MockUserCredential extends Mock implements UserCredential {}
class MockUser extends Mock implements User {}

void main() {
  late MockFirebaseAuthDataSource mockDataSource;
  late AuthRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockFirebaseAuthDataSource();
    repository = AuthRepositoryImpl(mockDataSource);
  });

  group('AuthRepositoryImpl', () {
    const email = 'test@example.com';
    const password = 'password123';
    const uid = '12345';

    test('signIn returns UserEntity on success', () async {
      final mockCredential = MockUserCredential();
      final mockUser = MockUser();
      
      when(() => mockUser.uid).thenReturn(uid);
      when(() => mockUser.email).thenReturn(email);
      when(() => mockCredential.user).thenReturn(mockUser);
      when(() => mockDataSource.signIn(email, password))
          .thenAnswer((_) async => mockCredential);

      final result = await repository.signIn(email: email, password: password);

      expect(result, const UserEntity(uid: uid, email: email));
      verify(() => mockDataSource.signIn(email, password)).called(1);
    });

    test('authStateChanges maps Firebase User to UserEntity', () {
      final mockUser = MockUser();
      when(() => mockUser.uid).thenReturn(uid);
      when(() => mockUser.email).thenReturn(email);

      when(() => mockDataSource.authStateChanges)
          .thenAnswer((_) => Stream.fromIterable([mockUser, null]));

      expect(
        repository.authStateChanges,
        emitsInOrder([
          const UserEntity(uid: uid, email: email),
          null,
        ]),
      );
    });

    test('signOut calls data source signOut', () async {
      when(() => mockDataSource.signOut()).thenAnswer((_) async => {});

      await repository.signOut();

      verify(() => mockDataSource.signOut()).called(1);
    });
  });
}
