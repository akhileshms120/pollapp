import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> with WidgetsBindingObserver {
  ThemeCubit() : super(ThemeState.initial()) {
    _initializeSystemTheme();
    WidgetsBinding.instance.addObserver(this);
  }

  void _initializeSystemTheme() {
    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    emit(state.copyWith(isSystemDark: brightness == Brightness.dark));
  }

  @override
  void didChangePlatformBrightness() {
    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    emit(state.copyWith(isSystemDark: brightness == Brightness.dark));
  }

  // Main theme methods
  void changeTheme(ThemeMode themeMode) {
    emit(state.copyWith(themeMode: themeMode));
  }

  void setLightTheme() => changeTheme(ThemeMode.light);
  
  void setDarkTheme() => changeTheme(ThemeMode.dark);
  
  void setSystemTheme() => changeTheme(ThemeMode.system);

  void toggleTheme() {
    if (state.themeMode == ThemeMode.system) {
      // If on system mode, toggle to opposite of current system theme
      changeTheme(state.isSystemDark ? ThemeMode.light : ThemeMode.dark);
    } else {
      // Toggle between light and dark
      changeTheme(state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
    }
  }

  // Utility getters
  bool get isLightMode => state.themeMode == ThemeMode.light;
  bool get isDarkMode => state.themeMode == ThemeMode.dark;
  bool get isSystemMode => state.themeMode == ThemeMode.system;

  String get currentThemeName {
    switch (state.themeMode) {
      case ThemeMode.light:
        return 'Light Mode';
      case ThemeMode.dark:
        return 'Dark Mode';
      case ThemeMode.system:
        return 'System Mode';
    }
  }

  IconData get currentThemeIcon {
    switch (state.themeMode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.auto_mode;
    }
  }

  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }
}
