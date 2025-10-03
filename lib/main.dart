import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:flutter_screenutil/flutter_screenutil.dart';
>>>>>>> 204d81a74058ff17fac2a4af6c9287b4fd6d26af
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pollapp/Core/routes/routes.dart';
import 'package:pollapp/Core/app_constants/routes_constant.dart';
import 'package:pollapp/Presentation/Cubit/theme_cubit.dart';
import 'package:pollapp/Presentation/Cubit/theme_state.dart';
<<<<<<< HEAD
=======
import 'package:pollapp/Presentation/Views/oneboarding_screen.dart';
import 'Presentation/Views/splash_screen.dart';
import 'Presentation/Views/home_screen.dart';
>>>>>>> 204d81a74058ff17fac2a4af6c9287b4fd6d26af
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
          return GetMaterialApp(
            title: 'Theme Cubit Demo',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            initialRoute: RoutesName.splashScreen,
            getPages: RoutePages.appPages,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}