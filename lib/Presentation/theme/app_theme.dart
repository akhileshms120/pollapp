// app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  // Color constants
  static const Color primaryBlue = Color(0xFF2196F3);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color lightGrey = Color(0xFFBDBDBD);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color darkGrey = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color cardDark = Color(0xFF2C2C2C);
  static const Color backgroundLight = Color(0xFFFAFAFA);

  // Light Theme
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryBlue,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: backgroundLight,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryBlue,
          foregroundColor: white,
          elevation: 2,
          centerTitle: true,
          toolbarHeight: 48,
          titleTextStyle: TextStyle(
            color: white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: black,
          ),
          displayMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: black,
          ),
          displaySmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: black,
          ),
          headlineLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: black,
          ),
          headlineMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: black,
          ),
          headlineSmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: black,
          ),
          titleLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: black,
          ),
          titleMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: black,
          ),
          titleSmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: black,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Color(0xFF424242),
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Color(0xFF616161),
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Color(0xFF757575),
          ),
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: black,
          ),
          labelMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: black,
          ),
          labelSmall: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Color(0xFF757575),
          ),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF616161)),
      );

  // Dark Theme (as you provided)
  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryBlue,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: darkGrey,
        appBarTheme: AppBarTheme(
          backgroundColor: darkGrey,
          foregroundColor: white,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 48,
          titleTextStyle: const TextStyle(
            color: white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: white,
          ),
          displayMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: white,
          ),
          displaySmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: white,
          ),
          headlineLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: white,
          ),
          headlineMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: white,
          ),
          headlineSmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: white,
          ),
          titleLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: white,
          ),
          titleMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: white,
          ),
          titleSmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: white,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: lightGrey,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: lightGrey,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: grey,
          ),
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: white,
          ),
          labelMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: white,
          ),
          labelSmall: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: grey,
          ),
        ),
        cardTheme: CardThemeData(
          color: cardDark,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        iconTheme: const IconThemeData(color: lightGrey),
      );
}