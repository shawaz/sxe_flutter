import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sxe/ui/theme/sxe_colors.dart';
import 'package:sxe/ui/theme/sxe_typography.dart';

class SXETheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Color scheme
      colorScheme: const ColorScheme.light(
        primary: SXEColors.primary,
        secondary: SXEColors.secondary,
        tertiary: SXEColors.accent,
        surface: SXEColors.surface,
        error: SXEColors.error,
        onPrimary: SXEColors.onPrimary,
        onSecondary: SXEColors.onSecondary,
        onSurface: SXEColors.onSurface,
        onError: SXEColors.onError,
        outline: SXEColors.borderMedium,
        outlineVariant: SXEColors.borderLight,
      ),

      // Scaffold
      scaffoldBackgroundColor: SXEColors.background,

      // App bar
      appBarTheme: const AppBarTheme(
        backgroundColor: SXEColors.background,
        foregroundColor: SXEColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: SXETypography.functionalHeadline,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),

      // Text theme
      textTheme: const TextTheme(
        displayLarge: SXETypography.mainHeadline,
        displayMedium: SXETypography.largeHeadline,
        displaySmall: SXETypography.mediumHeadline,
        headlineLarge: SXETypography.largeHeadline,
        headlineMedium: SXETypography.mediumHeadline,
        headlineSmall: SXETypography.smallHeadline,
        titleLarge: SXETypography.functionalHeadline,
        titleMedium: SXETypography.functionalHeadline,
        titleSmall: SXETypography.functionalHeadline,
        bodyLarge: SXETypography.bodyLarge,
        bodyMedium: SXETypography.bodyMedium,
        bodySmall: SXETypography.bodySmall,
        labelLarge: SXETypography.buttonLarge,
        labelMedium: SXETypography.buttonMedium,
        labelSmall: SXETypography.label,
      ),

      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: SXEColors.buttonPrimary,
          foregroundColor: SXEColors.onPrimary,
          disabledBackgroundColor: SXEColors.buttonDisabled,
          disabledForegroundColor: SXEColors.textTertiary,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: SXETypography.buttonLarge,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: SXEColors.primary,
          side: const BorderSide(color: SXEColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: SXETypography.buttonLarge,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: SXEColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: SXETypography.buttonMedium,
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: SXEColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: SXEColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: SXEColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: SXEColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: SXEColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: SXEColors.error, width: 2),
        ),
        labelStyle: SXETypography.inputLabel,
        hintStyle: SXETypography.inputHint,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),

      // Card theme
      cardTheme: const CardThemeData(
        color: SXEColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          side: BorderSide(color: SXEColors.borderLight),
        ),
        margin: EdgeInsets.all(8),
      ),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: SXEColors.surface,
        selectedItemColor: SXEColors.primary,
        unselectedItemColor: SXEColors.textTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      // Divider theme
      dividerTheme: const DividerThemeData(
        color: SXEColors.borderLight,
        thickness: 1,
        space: 1,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Color scheme
      colorScheme: const ColorScheme.dark(
        primary: SXEColors.primary,
        secondary: SXEColors.secondary,
        tertiary: SXEColors.accent,
        surface: SXEColors.darkSurface,
        error: SXEColors.error,
        onPrimary: SXEColors.onPrimary,
        onSecondary: SXEColors.onSecondary,
        onSurface: SXEColors.darkOnSurface,
        onError: SXEColors.onError,
        outline: SXEColors.darkBorderMedium,
        outlineVariant: SXEColors.darkBorderLight,
      ),

      // Scaffold
      scaffoldBackgroundColor: SXEColors.darkBackground,

      // App bar
      appBarTheme: const AppBarTheme(
        backgroundColor: SXEColors.darkBackground,
        foregroundColor: SXEColors.darkTextPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: SXETypography.functionalHeadline,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),

      // Text theme
      textTheme: const TextTheme(
        displayLarge: SXETypography.mainHeadline,
        displayMedium: SXETypography.largeHeadline,
        displaySmall: SXETypography.mediumHeadline,
        headlineLarge: SXETypography.largeHeadline,
        headlineMedium: SXETypography.mediumHeadline,
        headlineSmall: SXETypography.smallHeadline,
        titleLarge: SXETypography.functionalHeadline,
        titleMedium: SXETypography.functionalHeadline,
        titleSmall: SXETypography.functionalHeadline,
        bodyLarge: SXETypography.bodyLarge,
        bodyMedium: SXETypography.bodyMedium,
        bodySmall: SXETypography.bodySmall,
        labelLarge: SXETypography.buttonLarge,
        labelMedium: SXETypography.buttonMedium,
        labelSmall: SXETypography.label,
      ),

      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: SXEColors.buttonPrimary,
          foregroundColor: SXEColors.onPrimary,
          disabledBackgroundColor: SXEColors.darkBorderMedium,
          disabledForegroundColor: SXEColors.darkTextTertiary,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: SXETypography.buttonLarge,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: SXEColors.primary,
          side: const BorderSide(color: SXEColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: SXETypography.buttonLarge,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: SXEColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: SXETypography.buttonMedium,
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: SXEColors.darkSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: SXEColors.darkBorderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: SXEColors.darkBorderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: SXEColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: SXEColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: SXEColors.error, width: 2),
        ),
        labelStyle: SXETypography.inputLabel,
        hintStyle: SXETypography.inputHint,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),

      // Card theme
      cardTheme: const CardThemeData(
        color: SXEColors.darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          side: BorderSide(color: SXEColors.darkBorderLight),
        ),
        margin: EdgeInsets.all(8),
      ),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: SXEColors.darkSurface,
        selectedItemColor: SXEColors.primary,
        unselectedItemColor: SXEColors.darkTextTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      // Divider theme
      dividerTheme: const DividerThemeData(
        color: SXEColors.darkBorderLight,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
