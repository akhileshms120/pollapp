import 'package:flutter/material.dart';
import 'package:pollapp/Core/routes/routes_name.dart';
import 'package:pollapp/Presentation/Views/home_screen.dart';
import 'package:pollapp/Presentation/Views/services_screen.dart';

class Routes{

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name){
      // case RoutesName.splashScreen:
      //   return MaterialPageRoute(builder: (context)=>HomeScreen());
      //case RoutesName.servicesScreen:
       //return MaterialPageRoute(builder: (context)=>ServicesScreen());
      default:
      return MaterialPageRoute(builder: (context)=>const Scaffold(
        body: Center(
          child: Text("No route Gnerated"),
        ),
      ));
    }
  }
  }