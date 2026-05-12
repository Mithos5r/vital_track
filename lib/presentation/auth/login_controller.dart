import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/firebase_auth/auth_repository_impl.dart';

part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<void> build() {
    // Nothing to initialize
  }

  Future<bool> signIn(String email, String password) async {
    state = const AsyncLoading();
    
    final result = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).signIn(
            email: email,
            password: password,
          );
    });

    if (result.hasError) {
      state = AsyncError(result.error!, result.stackTrace!);
      return false;
    }

    state = const AsyncData(null);
    return true;
  }
}
