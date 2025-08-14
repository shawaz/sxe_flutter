import 'package:flutter/material.dart';

/// SXE brand color palette
class SXEColors {
  // Primary brand colors
  static const Color sxeBlack = Color(0xFF1A1A1A);
  static const Color sxeWhite = Color(0xFFFFFEFD);
  static const Color brightWhite = Color(0xFFFFFFFF);

  // Purple family
  static const Color midnight = Color(0xFF3E1768);
  static const Color aubergine = Color(0xFF67295F);
  static const Color lilac = Color(0xFF75457D);
  static const Color mauve = Color(0xFF9F81A5);
  static const Color mist = Color(0xFFC7C7E5);

  // Neutral family
  static const Color sand = Color(0xFFCCAC9F);
  static const Color pebble = Color(0xFFEEE1DB);
  static const Color stone = Color(0xFF484848);

  // Green family
  static const Color forest = Color(0xFF025656);
  static const Color kelp = Color(0xFF097270);

  // Alert color
  static const Color coral = Color(0xFFD45847);

  // Semantic colors
  static const Color primary = midnight;
  static const Color secondary = aubergine;
  static const Color accent = lilac;
  static const Color surface = sxeWhite;
  static const Color background = sxeWhite;
  static const Color error = coral;
  static const Color onPrimary = sxeWhite;
  static const Color onSecondary = sxeWhite;
  static const Color onSurface = sxeBlack;
  static const Color onBackground = sxeBlack;
  static const Color onError = sxeWhite;

  // Text colors
  static const Color textPrimary = sxeBlack;
  static const Color textSecondary = stone;
  static const Color textTertiary = Color(0xFF56565C);

  // Button colors
  static const Color buttonPrimary = midnight;
  static const Color buttonSecondary = aubergine;
  static const Color buttonDisabled = pebble;

  // Border colors
  static const Color borderLight = pebble;
  static const Color borderMedium = sand;
  static const Color borderDark = stone;

  // Dark theme colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkSurfaceVariant = Color(0xFF2D2D2D);
  static const Color darkTextPrimary = Color(0xFFE1E1E1);
  static const Color darkTextSecondary = Color(0xFFB3B3B3);
  static const Color darkTextTertiary = Color(0xFF8A8A8A);
  static const Color darkBorderLight = Color(0xFF3A3A3A);
  static const Color darkBorderMedium = Color(0xFF4A4A4A);
  static const Color darkBorderDark = Color(0xFF5A5A5A);
  static const Color darkOnSurface = darkTextPrimary;
  static const Color darkOnBackground = darkTextPrimary;
}
