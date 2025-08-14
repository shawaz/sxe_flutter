import 'package:flutter/material.dart';

/// SXE typography system based on brand guidelines
/// Uses system fonts as fallback for Tiempos Headline and Modern Era
class SXETypography {
  // Font families (using system fonts as fallback)
  static const String _headlineFont =
      'Georgia'; // Fallback for Tiempos Headline
  static const String _bodyFont = 'SF Pro Text'; // Fallback for Modern Era

  // Main headline styles (Tiempos Headline equivalent)
  static const TextStyle mainHeadline = TextStyle(
    fontFamily: _headlineFont,
    fontSize: 32,
    fontWeight: FontWeight.w600,
    height: 1.1,
    letterSpacing: 0,
  );

  static const TextStyle largeHeadline = TextStyle(
    fontFamily: _headlineFont,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0,
  );

  static const TextStyle mediumHeadline = TextStyle(
    fontFamily: _headlineFont,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0,
  );

  static const TextStyle smallHeadline = TextStyle(
    fontFamily: _headlineFont,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: 0,
  );

  // Functional headline (Modern Era equivalent)
  static const TextStyle functionalHeadline = TextStyle(
    fontFamily: _bodyFont,
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.3,
    letterSpacing: -0.2,
  );

  // Body text styles (Modern Era)
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: _bodyFont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: _bodyFont,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 0,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: _bodyFont,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 0.2,
  );

  // Button text styles
  static const TextStyle buttonLarge = TextStyle(
    fontFamily: _bodyFont,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: 0.2,
  );

  static const TextStyle buttonMedium = TextStyle(
    fontFamily: _bodyFont,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: 0.2,
  );

  // Label and caption styles
  static const TextStyle label = TextStyle(
    fontFamily: _bodyFont,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: 0.5,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: _bodyFont,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    height: 1.3,
    letterSpacing: 0.4,
  );

  // Input field styles
  static const TextStyle inputLabel = TextStyle(
    fontFamily: _bodyFont,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0,
  );

  static const TextStyle inputText = TextStyle(
    fontFamily: _bodyFont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.3,
    letterSpacing: 0,
  );

  static const TextStyle inputHint = TextStyle(
    fontFamily: _bodyFont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.3,
    letterSpacing: 0,
  );
}
