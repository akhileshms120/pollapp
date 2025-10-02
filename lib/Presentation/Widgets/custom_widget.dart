import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pollapp/Core/app_constants/colors.dart';
import 'package:pollapp/Core/app_constants/image_constant.dart';

class CustomWidget{

  ////////////////////Text Widget///////////////////////////////////////////////////////////////////////////////

  static Widget customTextWidget({required String text, double? fontSize, FontWeight? fontWeight, Color? textColor,Color? bgColor}  ) {
    try{
       return Text(text,style: TextStyle(
      fontSize: fontSize??0,
      fontWeight:fontWeight??FontWeight.normal,
      color:textColor?? AppColor.blackColor,backgroundColor:bgColor??AppColor.blackColor 
    ),);
    }catch(e){
      return Text("Error in text Widget $e",style: TextStyle(color: AppColor.errorMessage,backgroundColor: AppColor.blackColor),);
    }
   
  }
 ////////////////////////////////////////////Image Widget.///////////////////////////////////////
 
 static Widget customImageWidget({required String imageText ,double? width ,double? height}){
  try{
   return Image.asset(imageText,width: width??0,height: height??0,);
  }
  catch(e){
  log("Error in Image Widget $e");
   return Image.asset(errorImage);
  }
 }
 static Widget customSizedBox(double height,double width){
  try{
 return SizedBox(height: height,width: width,);
  }catch(e){
    log("Error in Sized Box $e");
    return SizedBox();
  }
 }
  
}