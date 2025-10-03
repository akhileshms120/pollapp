import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TextControllers extends GetxController{
  TextEditingController textEditingController =TextEditingController();

  @override
  void onClose(){
    textEditingController.dispose();
    super.onClose();
  }
}