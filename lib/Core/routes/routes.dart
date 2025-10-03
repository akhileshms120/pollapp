import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:pollapp/Core/app_constants/routes_constant.dart';
import 'package:pollapp/Presentation/Views/home_screen.dart';
import 'package:pollapp/Presentation/Views/login_screen.dart';
import 'package:pollapp/Presentation/Views/oneboarding_screen.dart';
import 'package:pollapp/Presentation/Views/otp_screen.dart';
import 'package:pollapp/Presentation/Views/splash_screen.dart';

class RoutePages {

 static final List<GetPage> appPages=[ 
   GetPage(name: "/", page: () => SplashScreen()),
  GetPage(name:RoutesName.onBoardingScreen , page: ()=>OnboardingScreen(),
  transition: Transition.fade,
  transitionDuration: Duration(milliseconds: 500),
  ),
  GetPage(name:RoutesName.homeScreen , page: ()=>HomeScreen()),
  GetPage(name:RoutesName.loginScreen , page: ()=>LoginScreen()),
  GetPage(name:RoutesName.otpScreen , page: ()=>OtpScreen()),
  
  
  
  
  
  ];
}