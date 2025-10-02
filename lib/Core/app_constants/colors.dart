//onBoarding colors

import 'package:flutter/material.dart';


class AppColor{




static const blackColor =Color(0xFF000000);
///Dark Mode and Light Mode//////

static Color colorMode({required bool mode}){
return mode?Color(0xFF212121):Color(0x0fffffff);
}
// static const  darkModeColor=Color(0xFF212121);
// static const lightModeColor =  Color(0xFFFFFFF);

///////////////////////////Splash Screen////////////
static const errorMessage=Color(0xFFFF0000);
static const onBoardingPage1Color =Color(0xFF80B9DC);
static const onBoardingPage2Color =Color(0xfffddcdf);
static const onBoardingPage3Color =Color(0x0fffdcbd);

//////////////////////////////Login Screen Colors ///////////
static const termTextColor =Color(0xFF6B7A8F);
}

