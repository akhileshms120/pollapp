import 'package:flutter/material.dart';
import 'package:pollapp/Core/app_constants/colors.dart';

class CustomWidget{

  static Widget customTextWidget({required String text, double fontSize=0, FontWeight? fontWeight, Color? textColor}  ) {
    return Text(text,style: TextStyle(
      fontSize: fontSize,
      fontWeight:fontWeight??FontWeight.normal,
      color:textColor?? AppColor.blackColor
    ),);
  }
}