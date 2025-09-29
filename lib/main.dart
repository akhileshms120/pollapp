import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollapp/Core/routes/routes.dart';
import 'package:pollapp/Core/routes/routes_name.dart';
import 'package:pollapp/Presentation/Cubit/theme_cubit.dart';
import 'package:pollapp/Presentation/Cubit/theme_state.dart';
import 'package:pollapp/Presentation/Views/oneboarding_screen.dart';
import 'Presentation/Views/splash_screen.dart';
import 'Presentation/Views/home_screen.dart';
import 'Core/theme/app_theme.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Theme Cubit Demo',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            home:  SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}