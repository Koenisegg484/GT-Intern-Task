import 'package:flutter/cupertino.dart';

class ScreenUtils {
  static double?  screenHeight;
  static double? screenWidth;

  static void init(BuildContext context){
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
  }
}