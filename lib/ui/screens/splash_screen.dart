import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sxe/providers/auth_provider.dart';
import 'package:sxe/ui/theme/sxe_colors.dart';
import 'package:sxe/ui/theme/sxe_typography.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
    ));

    _animationController.forward();

    // Initialize auth provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context, listen: false).initialize();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SXEColors.background,
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App logo
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            SXEColors.primary,
                            SXEColors.secondary,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: SXEColors.primary.withValues(alpha: 0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.trending_up,
                        color: SXEColors.onPrimary,
                        size: 60,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // App name
                    Text(
                      'SXE',
                      style: SXETypography.mainHeadline.copyWith(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Tagline
                    Text(
                      'Personal Development Platform',
                      style: SXETypography.bodyLarge.copyWith(
                        color: SXEColors.textSecondary,
                        letterSpacing: 1.2,
                      ),
                    ),

                    const SizedBox(height: 60),

                    // Loading indicator
                    Consumer<AuthProvider>(
                      builder: (context, authProvider, child) {
                        return Column(
                          children: [
                            SizedBox(
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  SXEColors.primary.withValues(alpha: 0.7),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _getLoadingText(authProvider.state),
                              style: SXETypography.bodySmall.copyWith(
                                color: SXEColors.textTertiary,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _getLoadingText(AuthState state) {
    switch (state) {
      case AuthState.initial:
        return 'Initializing...';
      case AuthState.loading:
        return 'Checking session...';
      case AuthState.authenticated:
        return 'Welcome back!';
      case AuthState.unauthenticated:
        return 'Ready to connect!';
      case AuthState.error:
        return 'Something went wrong';
    }
  }
}
