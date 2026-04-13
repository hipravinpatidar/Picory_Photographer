// import 'package:flutter/material.dart';
//
// class AppTheme {
//   // Primary Colors
//   static const Color royalPurple = Color(0xFF6C63FF);
//   static const Color deepBlue = Color(0xFF2D3561);
//   static const Color accentPurple = Color(0xFF9D8FFF);
//
//   // Light Theme Colors
//   static const Color lightBackground = Color(0xFFF8F9FD);
//   static const Color lightSurface = Colors.white;
//   static const Color lightTextPrimary = Color(0xFF1A1A1A);
//   static const Color lightTextSecondary = Color(0xFF6B7280);
//
//   // Dark Theme Colors
//   static const Color darkBackground = Color(0xFF0F0F23);
//   static const Color darkSurface = Color(0xFF1A1A2E);
//   static const Color darkTextPrimary = Color(0xFFFFFFFF);
//   static const Color darkTextSecondary = Color(0xFFB0B0B0);
//
//   // Common Colors
//   static const Color successGreen = Color(0xFF10B981);
//   static const Color warningOrange = Color(0xFFF59E0B);
//   static const Color errorRed = Color(0xFFEF4444);
//
//   // Border Radius
//   static const double radiusSmall = 8.0;
//   static const double radiusMedium = 12.0;
//   static const double radiusLarge = 16.0;
//   static const double radiusXLarge = 24.0;
//
//   // Spacing
//   static const double spacing4 = 4.0;
//   static const double spacing8 = 8.0;
//   static const double spacing12 = 12.0;
//   static const double spacing16 = 16.0;
//   static const double spacing20 = 20.0;
//   static const double spacing24 = 24.0;
//   static const double spacing32 = 32.0;
//
//   // Light Theme
//   static ThemeData lightTheme = ThemeData(
//     useMaterial3: true,
//     brightness: Brightness.light,
//     colorScheme: const ColorScheme.light(
//       primary: royalPurple,
//       secondary: accentPurple,
//       surface: lightSurface,
//       background: lightBackground,
//       error: errorRed,
//       onPrimary: Colors.white,
//       onSecondary: Colors.white,
//       onSurface: lightTextPrimary,
//       onBackground: lightTextPrimary,
//     ),
//     scaffoldBackgroundColor: lightBackground,
//     appBarTheme: const AppBarTheme(
//       backgroundColor: lightSurface,
//       elevation: 0,
//       iconTheme: IconThemeData(color: lightTextPrimary),
//       titleTextStyle: TextStyle(
//         color: lightTextPrimary,
//         fontSize: 20,
//         fontWeight: FontWeight.w600,
//       ),
//     ),
//     cardTheme: CardThemeData( // Changed from CardTheme to CardThemeData
//       color: lightSurface,
//       elevation: 0,
//       shadowColor: Colors.black.withOpacity(0.05),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(radiusLarge),
//       ),
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: royalPurple,
//         foregroundColor: Colors.white,
//         elevation: 0,
//         padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(radiusMedium),
//         ),
//         textStyle: const TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     ),
//     outlinedButtonTheme: OutlinedButtonThemeData(
//       style: OutlinedButton.styleFrom(
//         foregroundColor: royalPurple,
//         side: const BorderSide(color: royalPurple, width: 1.5),
//         padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(radiusMedium),
//         ),
//       ),
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//       fillColor: lightSurface,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(radiusMedium),
//         borderSide: BorderSide(color: Colors.grey.shade300),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(radiusMedium),
//         borderSide: BorderSide(color: Colors.grey.shade300),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(radiusMedium),
//         borderSide: const BorderSide(color: royalPurple, width: 2),
//       ),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//     ),
//     fontFamily: 'SF Pro Display',
//   );
//
//   // Dark Theme
//   static ThemeData darkTheme = ThemeData(
//     useMaterial3: true,
//     brightness: Brightness.dark,
//     colorScheme: const ColorScheme.dark(
//       primary: royalPurple,
//       secondary: accentPurple,
//       surface: darkSurface,
//       background: darkBackground,
//       error: errorRed,
//       onPrimary: Colors.white,
//       onSecondary: Colors.white,
//       onSurface: darkTextPrimary,
//       onBackground: darkTextPrimary,
//     ),
//     scaffoldBackgroundColor: darkBackground,
//     appBarTheme: const AppBarTheme(
//       backgroundColor: darkSurface,
//       elevation: 0,
//       iconTheme: IconThemeData(color: darkTextPrimary),
//       titleTextStyle: TextStyle(
//         color: darkTextPrimary,
//         fontSize: 20,
//         fontWeight: FontWeight.w600,
//       ),
//     ),
//     cardTheme: CardThemeData( // Changed from CardTheme to CardThemeData
//       color: darkSurface,
//       elevation: 0,
//       shadowColor: Colors.black.withOpacity(0.3),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(radiusLarge),
//       ),
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: royalPurple,
//         foregroundColor: Colors.white,
//         elevation: 0,
//         padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(radiusMedium),
//         ),
//         textStyle: const TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     ),
//     outlinedButtonTheme: OutlinedButtonThemeData(
//       style: OutlinedButton.styleFrom(
//         foregroundColor: royalPurple,
//         side: const BorderSide(color: royalPurple, width: 1.5),
//         padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(radiusMedium),
//         ),
//       ),
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//       fillColor: darkSurface,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(radiusMedium),
//         borderSide: const BorderSide(color: Color(0xFF2A2A3E)),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(radiusMedium),
//         borderSide: const BorderSide(color: Color(0xFF2A2A3E)),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(radiusMedium),
//         borderSide: const BorderSide(color: royalPurple, width: 2),
//       ),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//     ),
//     fontFamily: 'SF Pro Display',
//   );
// }

import 'package:flutter/material.dart';

// class AppTheme {
//   // ==================== ATTRACTIVE PHOTOGRAPHY COLORS ====================
//
//   // Primary Colors - Cinematic & Vibrant
//   static const Color royalPurple = Color(0xFF00B4D8); // Electric Teal (Primary)
//   static const Color deepBlue = Color(0xFF03045E); // Deep Navy (Secondary)
//   static const Color accentPurple = Color(0xFFFF6B6B); // Coral Red (Accent)
//
//   // Light Theme Colors - Clean & Fresh
//   static const Color lightBackground = Color(0xFFF8F9FF); // Soft off-white
//   static const Color lightSurface = Colors.white;
//   static const Color lightTextPrimary = Color(0xFF03045E); // Deep Navy
//   static const Color lightTextSecondary = Color(0xFF5C6B7E); // Slate Gray
//
//   // Dark Theme Colors - Moody & Cinematic
//   static const Color darkBackground = Color(0xFF0A0F1E); // Rich dark navy
//   static const Color darkSurface = Color(0xFF141B2B); // Slightly lighter
//   static const Color darkTextPrimary = Color(0xFFF0F4FF); // Ice white
//   static const Color darkTextSecondary = Color(0xFF9AA8C1); // Cool gray
//
//   // Common Colors
//   static const Color successGreen = Color(0xFF06D6A0); // Mint green
//   static const Color warningOrange = Color(0xFFFFB347); // Warm orange
//   static const Color errorRed = Color(0xFFEF476F); // Soft red
//
//   // Border Radius
//   static const double radiusSmall = 8.0;
//   static const double radiusMedium = 12.0;
//   static const double radiusLarge = 16.0;
//   static const double radiusXLarge = 24.0;
//
//   // Spacing
//   static const double spacing4 = 4.0;
//   static const double spacing8 = 8.0;
//   static const double spacing12 = 12.0;
//   static const double spacing16 = 16.0;
//   static const double spacing20 = 20.0;
//   static const double spacing24 = 24.0;
//   static const double spacing32 = 32.0;
//   static const double spacing64 = 64.0;
//
//   // ==================== LIGHT THEME ====================
//   static ThemeData lightTheme = ThemeData(
//     useMaterial3: true,
//     brightness: Brightness.light,
//     colorScheme: const ColorScheme.light(
//       primary: royalPurple, // Electric Teal
//       secondary: accentPurple, // Coral Red
//       surface: lightSurface,
//       background: lightBackground,
//       error: errorRed,
//       onPrimary: Colors.white,
//       onSecondary: Colors.white,
//       onSurface: lightTextPrimary,
//       onBackground: lightTextPrimary,
//     ),
//     scaffoldBackgroundColor: lightBackground,
//     appBarTheme: const AppBarTheme(
//       backgroundColor: lightSurface,
//       elevation: 0,
//       centerTitle: true,
//       iconTheme: IconThemeData(color: deepBlue),
//       titleTextStyle: TextStyle(
//         color: deepBlue,
//         fontSize: 20,
//         fontWeight: FontWeight.w600,
//       ),
//     ),
//     cardTheme: CardThemeData(
//       color: lightSurface,
//       elevation: 4,
//       shadowColor: Color(0xFF03045E).withOpacity(0.08),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(radiusLarge),
//       ),
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: royalPurple,
//         foregroundColor: Colors.white,
//         elevation: 4,
//         padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(radiusMedium),
//         ),
//         textStyle: const TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     ),
//     outlinedButtonTheme: OutlinedButtonThemeData(
//       style: OutlinedButton.styleFrom(
//         foregroundColor: royalPurple,
//         side: const BorderSide(color: royalPurple, width: 1.5),
//         padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(radiusMedium),
//         ),
//       ),
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//       fillColor: lightSurface,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(radiusMedium),
//         borderSide: BorderSide(color: Colors.grey.shade300),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(radiusMedium),
//         borderSide: BorderSide(color: Colors.grey.shade300),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(radiusMedium),
//         borderSide: const BorderSide(color: royalPurple, width: 2),
//       ),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//     ),
//     fontFamily: 'SF Pro Display',
//   );
//
//   // ==================== DARK THEME ====================
//   static ThemeData darkTheme = ThemeData(
//     useMaterial3: true,
//     brightness: Brightness.dark,
//     colorScheme: const ColorScheme.dark(
//       primary: royalPurple, // Electric Teal
//       secondary: accentPurple, // Coral Red
//       surface: darkSurface,
//       background: darkBackground,
//       error: errorRed,
//       onPrimary: Colors.white,
//       onSecondary: Colors.white,
//       onSurface: darkTextPrimary,
//       onBackground: darkTextPrimary,
//     ),
//     scaffoldBackgroundColor: darkBackground,
//     appBarTheme: const AppBarTheme(
//       backgroundColor: darkSurface,
//       elevation: 0,
//       centerTitle: true,
//       iconTheme: IconThemeData(color: royalPurple),
//       titleTextStyle: TextStyle(
//         color: darkTextPrimary,
//         fontSize: 20,
//         fontWeight: FontWeight.w600,
//       ),
//     ),
//     cardTheme: CardThemeData(
//       color: darkSurface,
//       elevation: 4,
//       shadowColor: Colors.black.withOpacity(0.5),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(radiusLarge),
//       ),
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: royalPurple,
//         foregroundColor: Colors.white,
//         elevation: 4,
//         padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(radiusMedium),
//         ),
//         textStyle: const TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     ),
//     outlinedButtonTheme: OutlinedButtonThemeData(
//       style: OutlinedButton.styleFrom(
//         foregroundColor: royalPurple,
//         side: const BorderSide(color: royalPurple, width: 1.5),
//         padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(radiusMedium),
//         ),
//       ),
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//       fillColor: darkSurface,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(radiusMedium),
//         borderSide: const BorderSide(color: Color(0xFF2A3A4A)),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(radiusMedium),
//         borderSide: const BorderSide(color: Color(0xFF2A3A4A)),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(radiusMedium),
//         borderSide: const BorderSide(color: royalPurple, width: 2),
//       ),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//     ),
//     fontFamily: 'SF Pro Display',
//   );
// }

class AppTheme {
  // Primary Colors (Blue Focus 🔵)
  static const Color royalPurple = Color(0xFF3B82F6); // vibrant blue (main highlight)
  static const Color deepBlue = Color(0xFF0A0A0A); // almost black (pro photography feel)
  static const Color accentPurple = Color(0xFF60A5FA); // soft blue accent

  // Light Theme Colors (clean gallery look)
  static const Color lightBackground = Color(0xFFF9FAFB);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF6B7280);

  // Dark Theme Colors (BEST for photography apps 🔥)
  static const Color darkBackground = Color(0xFF000000); // pure black (images pop!)
  static const Color darkSurface = Color(0xFF0F172A); // subtle blue-black
  static const Color darkTextPrimary = Color(0xFFE5E7EB);
  static const Color darkTextSecondary = Color(0xFF9CA3AF);

  // Common Colors
  static const Color successGreen = Color(0xFF22C55E);
  static const Color warningOrange = Color(0xFFF59E0B);
  static const Color errorRed = Color(0xFFEF4444);

  // Border Radius (slightly modern)
  static const double radiusSmall = 10.0;
  static const double radiusMedium = 14.0;
  static const double radiusLarge = 20.0;
  static const double radiusXLarge = 28.0;

  // Spacing (same)
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing20 = 20.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: royalPurple,
      secondary: accentPurple,
      surface: lightSurface,
      background: lightBackground,
      error: errorRed,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: lightTextPrimary,
      onBackground: lightTextPrimary,
    ),
    scaffoldBackgroundColor: lightBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: lightSurface,
      elevation: 0,
      iconTheme: IconThemeData(color: lightTextPrimary),
      titleTextStyle: TextStyle(
        color: lightTextPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    cardTheme: CardThemeData(
      color: lightSurface,
      elevation: 0,
      shadowColor: Color(0x14000000),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusLarge),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: royalPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: royalPurple,
        side: const BorderSide(color: royalPurple),
      ),
    ),
    fontFamily: 'SF Pro Display',
  );

  // Dark Theme (MAIN EXPERIENCE 📸🔥)
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: royalPurple,
      secondary: accentPurple,
      surface: darkSurface,
      background: darkBackground,
      error: errorRed,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: darkTextPrimary,
      onBackground: darkTextPrimary,
    ),
    scaffoldBackgroundColor: darkBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: darkTextPrimary),
      titleTextStyle: TextStyle(
        color: darkTextPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    cardTheme: CardThemeData(
      color: darkSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusLarge),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: royalPurple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    ),
    fontFamily: 'SF Pro Display',
  );
}