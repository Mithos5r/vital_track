import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/firebase_auth/auth_repository_impl.dart';
import '../../../presentation/auth/initialization_provider.dart';
import '../../../presentation/auth/login_screen.dart';
import '../../../presentation/auth/register_screen.dart';
import '../../../presentation/auth/splash_screen.dart';
import '../../../presentation/dashboard/dashboard_screen.dart';
import '../../../presentation/health_metrics/add_entry_screen.dart';
import '../../../presentation/health_metrics/history_screen.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  final authState = ref.watch(authStateChangesProvider);
  final initStatus = ref.watch(initializationProvider);
  
  return GoRouter(
    initialLocation: '/splash',
    errorBuilder: (context, state) => const SplashScreen(),
    redirect: (context, state) {
      final isSplash = state.matchedLocation == '/splash';
      
      // While initialization (timer + auth check) is in progress, stay on splash
      if (initStatus.isLoading || authState.isLoading) {
        return '/splash';
      }

      final user = authState.value;
      final isLoggedIn = user != null;
      final isAuthPath = state.matchedLocation == '/login' || state.matchedLocation == '/register';

      if (!isLoggedIn) {
        if (!isAuthPath) return '/login';
        return null;
      }

      // If logged in and on splash or auth path, go to home
      if (isAuthPath || isSplash) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
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
