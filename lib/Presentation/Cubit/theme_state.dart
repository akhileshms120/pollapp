import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final ThemeMode themeMode;
  final bool isSystemDark;

  const ThemeState({
    required this.themeMode,
    required this.isSystemDark,
  });

  factory ThemeState.initial() => const ThemeState(
    themeMode: ThemeMode.system,
    isSystemDark: false,
  );

  ThemeState copyWith({
    ThemeMode? themeMode,
    bool? isSystemDark,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      isSystemDark: isSystemDark ?? this.isSystemDark,
    );
  }

  @override
  List<Object> get props => [themeMode, isSystemDark];
}