import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'initialization_provider.g.dart';

@riverpod
class InitializationNotifier extends _$InitializationNotifier {
  @override
  Future<void> build() async {
    // Artificial delay to allow the splash animation to be seen
    await Future.delayed(const Duration(seconds: 2));
  }
}
