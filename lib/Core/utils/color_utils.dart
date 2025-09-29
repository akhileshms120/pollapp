import 'package:flutter/material.dart';

class ColorUtils {
  static Color parseHexColor(String hexString) {
    return Color(int.parse(hexString.replaceAll('#', '0xFF')));
  }
}