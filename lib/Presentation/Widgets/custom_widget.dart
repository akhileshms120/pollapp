import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pollapp/Core/app_constants/colors.dart';
import 'package:pollapp/Core/app_constants/image_constant.dart';
import 'package:pollapp/logs/app_logger.dart';

class CustomWidget {
  //////////////////// Text Widget ///////////////////////////////////////////////////////////////////////////////

 
  static Widget customTextWidget({
    required String text,
    double? height,
    double fontSize = 14.0,
    FontWeight fontWeight = FontWeight.normal,
    Color? textColor,
    Color? backgroundColor, 
    TextOverflow? overflow,
    TextAlign? textAlign = TextAlign.start,
    TextDecoration? textDecoration

  }) {
    try {
      return Text(
        text,
        overflow: overflow,
        textAlign: textAlign,
      
        style: TextStyle(
          
          height: height,
          decoration:textDecoration ,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor ?? AppColor.blackColor, 
          backgroundColor: backgroundColor,
        ),
      );
    } catch (e, stackTrace) {
      LogService.error("Error in customTextWidget: $e",);
      if (kDebugMode) {
        debugPrint('Stack trace: $stackTrace'); 
      }
      return Text(
        "Error: $text", 
        style: TextStyle(
          color: AppColor.errorMessage,
          fontSize: 14.0,
          backgroundColor: Colors.red.withOpacity(0.1), 
        ),
      );
    }
  }

  //////////////////////////////////////////// Image Widget ///////////////////////////////////////

 

static Widget customImageWidget({
  required String imagePath,
  double width = 100.0,
  double height = 100.0,
  BoxFit fit = BoxFit.cover,
  double borderRadius = 0.0,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(borderRadius),
    child: Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        LogService.error("Error loading image '$imagePath': $error");
        if (kDebugMode) debugPrint('Stack trace: $stackTrace');
        return Icon(Icons.broken_image, size: width, color: AppColor.errorMessage);
      },
    ),
  );
}


  static Widget customSizedBox({double? height, double? width}) {
    return SizedBox(
      height: height ?? 0.0,
      width: width ?? 0.0,
    );
  }


  static Widget verticalSpacer(double height) => SizedBox(height: height);
  static Widget horizontalSpacer(double width) => SizedBox(width: width);





  static Widget iconWidget({required IconData icon, Color? iconColor,bool isDarkMode=false}){
    return Icon(icon,color: AppColor.getIconBackgroundColor(isDarkMode),);
  }
}