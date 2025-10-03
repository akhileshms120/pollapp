import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class CustomAppbar  {
 
  String title="";
  static Widget customAppBar({String title=""}){
    return   AppBar(
      title: Text(title),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed:()=>Get.back()
        ));
  }
  }
