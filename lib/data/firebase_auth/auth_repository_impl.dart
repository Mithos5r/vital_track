import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/auth/auth_repository.dart';
import '../../domain/auth/user_entity.dart';
import 'firebase_auth_data_source.dart';

part 'auth_repository_impl.g.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  Stream<UserEntity?> get authStateChanges => _dataSource.authStateChanges.map(
        (user) => user != null ? UserEntity(uid: user.uid, email: user.email ?? '') : null,
      );

  @override
  UserEntity? get currentUser {
    final user = _dataSource.currentUser;
    return user != null ? UserEntity(uid: user.uid, email: user.email ?? '') : null;
  }

  @override
  Future<UserEntity> signIn({required String email, required String password}) async {
    final credential = await _dataSource.signIn(email, password);
    final user = credential.user!;
    return UserEntity(uid: user.uid, email: user.email ?? '');
  }

  @override
  Future<UserEntity> signUp({required String email, required String password}) async {
    final credential = await _dataSource.signUp(email, password);
    final user = credential.user!;
    return UserEntity(uid: user.uid, email: user.email ?? '');
  }

  @override
  Future<void> signOut() {
    return _dataSource.signOut();
  }
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(ref.watch(firebaseAuthDataSourceProvider));
}

@riverpod
Stream<UserEntity?> authStateChanges(Ref ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
}
