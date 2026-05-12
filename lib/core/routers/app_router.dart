import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/firebase_auth/auth_repository_impl.dart';
import '../../../presentation/auth/login_screen.dart';
import '../../../presentation/auth/register_screen.dart';
import '../../../presentation/dashboard/dashboard_screen.dart';
import '../../../presentation/health_metrics/add_entry_screen.dart';
import '../../../presentation/health_metrics/history_screen.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  final authState = ref.watch(authStateChangesProvider);
  
  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final user = authState.value;
      final isLoading = authState.isLoading;

      if (isLoading) return null;

      final isLoggedIn = user != null;
      final isAuthPath = state.matchedLocation == '/login' || state.matchedLocation == '/register';

      if (!isLoggedIn && !isAuthPath) {
        return '/login';
      }

      if (isLoggedIn && isAuthPath) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/add-entry',
        builder: (context, state) => const AddEntryScreen(),
      ),
      GoRoute(
        path: '/history/:param',
        builder: (context, state) {
          final param = state.pathParameters['param']!;
          return HistoryScreen(param: param);
        },
      ),
    ],
  );
}
