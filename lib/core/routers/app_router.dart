import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/firebase_auth/auth_repository_impl.dart';
import '../../../presentation/auth/login_screen.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  final authState = ref.watch(authStateChangesProvider);
  
  return GoRouter(
    initialLocation: '/login', // Start at login
    redirect: (context, state) {
      final user = authState.value;
      final isLoading = authState.isLoading;
      
      developer.log('Router Redirect: location=${state.matchedLocation}, isLoading=$isLoading, user=${user?.email}');

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
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Register Screen')),
        ),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Home Screen')),
        ),
      ),
    ],
  );
}
