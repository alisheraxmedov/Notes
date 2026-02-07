import 'package:flutter/material.dart';

class ColorClass {
  // Base colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // New soft warm palette - Light theme
  static const Color warmCream = Color(0xFFFAF8F5); // Background
  static const Color softBeige = Color(0xFFF5F0E8); // Card backgrounds
  static const Color warmSand = Color(0xFFE8E0D5); // Borders/dividers
  static const Color terracotta = Color(0xFFD4A574); // Primary accent
  static const Color mutedOrange = Color(0xFFC98B5E); // Secondary accent
  static const Color warmBrown = Color(0xFF8B7355); // Text secondary
  static const Color charcoal = Color(0xFF3D3D3D); // Text primary

  // Card colors - soft pastels
  static const Color softMint = Color(0xFFE8F5E8); // Soft green card
  static const Color softPeach = Color(0xFFFFF0E8); // Soft peach card
  static const Color softLavender = Color(0xFFF0E8F5); // Soft purple card
  static const Color softSky = Color(0xFFE8F0F5); // Soft blue card

  // Dark theme colors
  static const Color darkBackground = Color(0xFF1A1A1A);
  static const Color darkSurface = Color(0xFF2D2D2D);
  static const Color darkCard = Color(0xFF383838);
  static const Color darkAccent = Color(0xFFE0B088); // Warm accent for dark

  // Legacy colors (kept for compatibility)
  static const Color teal = Color(0xFF008080);
  static const Color tealDark = Color(0xFF004D4D);
  static const Color orangeAccent = Color(0xFFFFA000);
  static const Color amberAccent = Color(0xFFFFC107);
  static const Color lightTeal = Color(0xFF80CBC4);
  static const Color lightTealAccent = Color(0xFFB2DFDB);
  static const Color grey = Color(0xFFBDBDBD);
  static const Color lightGrey = Color(0xFF757575);
  static const Color darkGrey = Color(0xFF616161);
  static const Color tealLight = Color(0xFF4DB6AC);
  static const Color deepGreen = Color(0xFFD4A574); // Remapped to terracotta
  static const Color deepGreen2 = Color(0xFFC98B5E); // Remapped to mutedOrange
  static const Color deepGreen3 =
      Color(0xFFE8D5C4); // Remapped to warm sand light
  static const Color red = Colors.red;
  static const Color blue = Colors.blue;
  static const Color green = Colors.green;

  static const Color settingsListLight = Color(0xFFF5F0E8); // Soft beige
  static const Color settingsListDark = Color(0xFF2D2D2D);
}
