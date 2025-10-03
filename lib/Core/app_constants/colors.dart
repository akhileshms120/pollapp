import 'package:flutter/material.dart';

class AppColor {
  // Base Colors
  static const blackColor = Color(0xFF000000);
  static const whiteColor = Color(0xFFFFFFFF);
  
  // Dark Mode Colors
  static const darkBackground = Color(0xFF2C3341);
  static const darkSurface = Color(0xFF3A4252);
  static const darkBorder = Color(0xFF6B7A8F);
  
  // Light Mode Colors
  static const lightBackground = Color(0xFFFFFFFF);
  static const lightSurface = Color(0xFFF0F2F5);
  static const lightBorder = Color(0xFFE0E0E0);
  
  // Text Colors
  static const textPrimaryDark = Color(0xFFE8E8E8);
  static const textPrimaryLight = Color(0xFF212121);
  static const textSecondaryDark = Color(0xFFB0B0B0);
  static const textSecondaryLight = Color(0xFF666666);
  
  // Icon Colors
  static const iconColorDark = Color(0xFFE8E8E8);      // Light icons for dark mode
  static const iconColorLight = Color(0xFF424242);     // Dark icons for light mode
  
  // Link Colors
  static const linkColorDark = Color(0xFF64B5F6);      // Light blue for dark mode
  static const linkColorLight = Color(0xFF1976D2);     // Darker blue for light mode
  
  // Accent Colors
  static const primaryAccent = Color(0xFF007AFF);
  static const secondaryAccent = Color(0xFF34C759);
  
  // Error Color
  static const errorMessage = Color(0xFFFF0000);
  
  // Onboarding Colors
  static const onBoardingPage1Color = Color(0xFF80B9DC);
  static const onBoardingPage2Color = Color(0xFFFDDCDF);
  static const onBoardingPage3Color = Color(0xFFFDCBD0);
  
  // Login Screen Colors
  static const termTextColor = Color(0xFF2C3341);
 
  static Color colorMode({
    required bool mode,
    Color darkModeColor = const Color(0xFF212121),
    Color lightModeColor = const Color(0xFFFFFFFF)
  }) {
    return mode ? darkModeColor : lightModeColor;
  }
  
  // Background Gradient
  static LinearGradient getBackgroundGradient(bool isDarkMode) {
    return LinearGradient(
      colors: isDarkMode
        ? [
            darkBackground.withOpacity(0.8),
            darkBackground.withOpacity(0.9),
          ]
        : [
            lightBackground,
            lightBackground,
          ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }
  
  // Container Gradient
  static LinearGradient getContainerGradient(bool isDarkMode) {
    return LinearGradient(
      colors: isDarkMode
        ? [
            darkBackground.withOpacity(0.8),
            darkBackground.withOpacity(0.9),
          ]
        : [
            lightBackground,
            lightBackground,
          ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }
  
  static Color getBackgroundColor(bool isDarkMode) {
    return isDarkMode ? darkBackground : lightBackground;
  }
  
  static Color getShadowColor(bool isDarkMode) {
    return isDarkMode 
      ? blackColor.withOpacity(0.3) 
      : blackColor.withOpacity(0.1);
  }
  
  static Color getBorderColor(bool isDarkMode) {
    return isDarkMode ? darkBorder : lightBorder;
  }
  
  static Color getButtonColor(bool isDarkMode) {
    return isDarkMode ? darkSurface : lightSurface;
  }
  
  static Color getButtonTextColor(bool isDarkMode) {
    return isDarkMode ? whiteColor : darkBackground;
  }
  
 
  
  static Color getIndicatorColor(bool isDarkMode) {
    return isDarkMode ? darkBorder : const Color(0xFFE0E0E0);
  }
  
  static Color getTitleColor(bool isDarkMode) {
    return isDarkMode ? whiteColor : blackColor;
  }
  
  static Color getSubtitleColor(bool isDarkMode) {
    return isDarkMode 
      ? whiteColor.withOpacity(0.8) 
      : blackColor.withOpacity(0.6);
  }
  
  // IMPROVED: Better text color for light mode
  static Color getTextColor(bool isDarkMode) {
    return isDarkMode ? textPrimaryDark : textPrimaryLight;
  }
  
  // IMPROVED: Better hint color
  static Color getHintColor(bool isDarkMode) {
    return isDarkMode ? textSecondaryDark : textSecondaryLight;
  }

  static Color getIconBackgroundColor(bool isDarkMode) {
    return isDarkMode 
      ? iconColorDark : iconColorLight;
  }
  
  // NEW: Link color for clickable text (email, etc.)
  static Color getLinkColor(bool isDarkMode) {
    return isDarkMode ? linkColorDark : linkColorLight;
  }
  
  // NEW: Secondary text color
  static Color getSecondaryTextColor(bool isDarkMode) {
    return isDarkMode ? textSecondaryDark : textSecondaryLight;
  }
}