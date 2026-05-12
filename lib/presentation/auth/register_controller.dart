import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/firebase_auth/auth_repository_impl.dart';

part 'register_controller.g.dart';

@riverpod
class RegisterController extends _$RegisterController {
  @override
  FutureOr<void> build() {
    // Nothing to initialize
  }

  Future<bool> signUp(String email, String password) async {
    state = const AsyncLoading();
    
    final result = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).signUp(
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
