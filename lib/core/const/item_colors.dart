import 'package:flutter/material.dart';

class ItemsColor {
  // Light theme colors - soft pastels
  static List<Color?> lightColors = [
    const Color(0xFFE8F5E8), // Soft mint green
    const Color(0xFFFFF0E8), // Soft peach
    const Color(0xFFF0E8F5), // Soft lavender
    const Color(0xFFE8F0F5), // Soft sky blue
    const Color(0xFFFFF8E8), // Soft cream yellow
    const Color(0xFFF5E8E8), // Soft rose
    const Color(0xFFE8F5F0), // Soft seafoam
    const Color(0xFFF0F0E8), // Soft sage
  ];

  // Dark theme colors - rich deep tones
  static List<Color?> darkColors = [
    const Color(0xFF2D4A3E), // Deep forest green
    const Color(0xFF4A3D35), // Deep cocoa
    const Color(0xFF3D3548), // Deep purple gray
    const Color(0xFF354048), // Deep slate blue
    const Color(0xFF48453A), // Deep olive
    const Color(0xFF483A3A), // Deep burgundy
    const Color(0xFF3A4845), // Deep teal
    const Color(0xFF424238), // Deep moss
  ];

  // Legacy - kept for compatibility
  static List<Color?> itemsColor = lightColors;

  // Get colors based on theme brightness
  static List<Color?> getColors(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? darkColors : lightColors;
  }
}
