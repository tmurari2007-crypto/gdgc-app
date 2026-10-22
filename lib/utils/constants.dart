import 'package:flutter/material.dart';

/// App color palette and aesthetic constants tailored for modern travel applications
class AppColors {
  // Primary brand palette (Teal / Ocean Blue)
  static const Color primaryTeal = Color(0xFF0D9488); // Vibrant Teal 600
  static const Color primaryDarkTeal = Color(0xFF0F766E); // Teal 700
  static const Color primaryLightTeal = Color(0xFF14B8A6); // Teal 500
  static const Color accentCyan = Color(0xFF06B6D4); // Cyan 500
  static const Color accentAmber = Color(0xFFF59E0B); // Amber 500 (Star/rating/accent)
  static const Color wishlistRed = Color(0xFFEF4444); // Red 500 for heart toggle

  // Light Theme background & surfaces
  static const Color lightBackground = Color(0xFFF8FAFC); // Slate 50
  static const Color lightSurface = Colors.white;
  static const Color lightCard = Colors.white;
  static const Color lightTextPrimary = Color(0xFF0F172A); // Slate 900
  static const Color lightTextSecondary = Color(0xFF64748B); // Slate 500
  static const Color lightBorder = Color(0xFFE2E8F0); // Slate 200

  // Dark Theme background & surfaces
  static const Color darkBackground = Color(0xFF0B1320); // Deep rich navy/slate
  static const Color darkSurface = Color(0xFF131D2F);
  static const Color darkCard = Color(0xFF182438);
  static const Color darkTextPrimary = Color(0xFFF1F5F9); // Slate 100
  static const Color darkTextSecondary = Color(0xFF94A3B8); // Slate 400
  static const Color darkBorder = Color(0xFF1E293B); // Slate 800
}

/// App typography and dimensions
class AppConstants {
  static const double cardRadius = 16.0;
  static const double chipRadius = 24.0;
  static const double buttonRadius = 14.0;
  static const double defaultPadding = 16.0;
}
