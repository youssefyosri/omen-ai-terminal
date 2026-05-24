import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/home/screens/history_screen.dart';
import '../../features/home/screens/result_screen.dart';
import '../auth/auth_provider.dart';
import '../../features/home/screens/prompt_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final isAuthenticated = ref.watch(authStateProvider);
  final analytics = FirebaseAnalytics.instance;

  return GoRouter(
    initialLocation: '/',
    observers: [
      FirebaseAnalyticsObserver(analytics: analytics),
    ],
    redirect: (context, state) {
      final isLoggingIn = state.matchedLocation == '/login';
      final isRegistering = state.matchedLocation == '/register';

      final isAuthScreen = isLoggingIn || isRegistering;

      if (!isAuthenticated && !isAuthScreen) {
        return '/login';
      }

      if (isAuthenticated && isAuthScreen) {
        return '/';
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
        path: '/',
        name: 'prompt',
        builder: (context, state) => const PromptScreen(),
      ),
      GoRoute(
        path: '/result',
        builder: (context, state) {
          final output = state.extra as String;
          return ResultScreen(output: output);
        },
      ),
      GoRoute(
        path: '/history',
        builder: (context, state) => const HistoryScreen(),
      ),
    ],
  );
});