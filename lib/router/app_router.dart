import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sxe/providers/auth_provider.dart';
import 'package:sxe/ui/screens/auth/login_screen.dart';
import 'package:sxe/ui/screens/auth/register_screen.dart';
import 'package:sxe/ui/screens/main/main_navigation.dart';
import 'package:sxe/ui/screens/splash_screen.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter createRouter(AuthProvider authProvider) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/splash',
      refreshListenable: authProvider,
      redirect: (context, state) {
        final authState = authProvider.state;
        final isAuthRoute = state.matchedLocation.startsWith('/auth');
        final isSplashRoute = state.matchedLocation == '/splash';

        // Show splash screen during initialization
        if (authState == AuthState.initial) {
          return '/splash';
        }

        // If user is authenticated and trying to access auth routes, redirect to home
        if (authProvider.isAuthenticated && isAuthRoute) {
          return '/home';
        }

        // If user is not authenticated and not on auth routes, redirect to login
        if (!authProvider.isAuthenticated && !isAuthRoute && !isSplashRoute) {
          return '/auth/login';
        }

        // If on splash and auth state is determined, redirect appropriately
        if (isSplashRoute && authState != AuthState.initial) {
          return authProvider.isAuthenticated ? '/home' : '/auth/login';
        }

        return null; // No redirect needed
      },
      routes: [
        // Splash route
        GoRoute(
          path: '/splash',
          name: 'splash',
          builder: (context, state) => const SplashScreen(),
        ),

        // Auth routes
        GoRoute(
          path: '/auth/login',
          name: 'login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/auth/register',
          name: 'register',
          builder: (context, state) => const RegisterScreen(),
        ),

        // Main app routes
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => const MainNavigation(),
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                'Page not found',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                state.error.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.go('/home'),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
