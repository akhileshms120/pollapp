// lib/Presentation/Singletons/recently_used_singleton.dart

import 'package:pollapp/Presentation/Cubit/cubit_files/recentlyUser_cubit.dart';

class RecentlyUsedSingleton {
  // Private static instance
  static final RecentlyUsedSingleton _instance = RecentlyUsedSingleton._internal();
  
  // Private constructor - this was missing!
  RecentlyUsedSingleton._internal();
  
  // Factory constructor that returns the singleton instance
  factory RecentlyUsedSingleton() {
    return _instance;
  }
  
  // The single instance of the cubit
  final RecentlyUsedCubit cubit = RecentlyUsedCubit();
}