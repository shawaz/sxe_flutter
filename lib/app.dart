import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sxe/data/repository/appwrite_repository.dart';
import 'package:sxe/providers/auth_provider.dart';
import 'package:sxe/providers/session_provider.dart';
import 'package:sxe/providers/theme_provider.dart';
import 'package:sxe/router/app_router.dart';
import 'package:sxe/ui/theme/sxe_theme.dart';

class SXE extends StatelessWidget {
  const SXE({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AppwriteRepository().authService;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(authService),
        ),
        ChangeNotifierProvider(
          create: (context) => SessionProvider(authService),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider()..loadTheme(),
        ),
      ],
      child: Consumer2<AuthProvider, ThemeProvider>(
        builder: (context, authProvider, themeProvider, child) {
          final router = AppRouter.createRouter(authProvider);

          return MaterialApp.router(
            title: 'SXE',
            debugShowCheckedModeBanner: false,
            theme: SXETheme.lightTheme,
            darkTheme: SXETheme.darkTheme,
            themeMode: themeProvider.themeMode,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
