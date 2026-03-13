import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primaryBlue,
      scaffoldBackgroundColor: AppColors.slate50,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryBlue,
        secondary: AppColors.gold,
        surface: AppColors.white,
        error: AppColors.googleRed,
        onPrimary: AppColors.white,
        onSecondary: AppColors.darkGrey,
        onSurface: AppColors.darkGrey,
        onError: AppColors.white,
      ),
      textTheme: GoogleFonts.beVietnamProTextTheme().copyWith(
        bodyLarge: GoogleFonts.beVietnamPro(color: AppColors.darkGrey),
        bodyMedium: GoogleFonts.beVietnamPro(color: AppColors.slate600),
        titleLarge: GoogleFonts.beVietnamPro(
          color: AppColors.darkGrey,
          fontWeight: FontWeight.bold,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white, // Text color on AppBar
        elevation: 0,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: AppColors.primaryBlue,
      scaffoldBackgroundColor: AppColors.darkGrey,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryBlue,
        secondary: AppColors.amber300,
        surface:
            AppColors
                .veryDarkRed, // Using the very dark red for dark mode surfaces to give a unique tint
        error: AppColors.googleRed,
        onPrimary: AppColors.white,
        onSecondary: AppColors.darkGrey,
        onSurface: AppColors.slate50,
        onError: AppColors.white,
      ),
      textTheme: GoogleFonts.beVietnamProTextTheme(
        ThemeData.dark().textTheme,
      ).copyWith(
        bodyLarge: GoogleFonts.beVietnamPro(color: AppColors.slate50),
        bodyMedium: GoogleFonts.beVietnamPro(color: AppColors.slate400),
        titleLarge: GoogleFonts.beVietnamPro(
          color: AppColors.slate50,
          fontWeight: FontWeight.bold,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkGrey,
        foregroundColor: AppColors.slate50,
        elevation: 0,
      ),
    );
  }
}
