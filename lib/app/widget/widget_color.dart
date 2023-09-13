import 'package:flutter/material.dart';

class WidgetColor {
  static bool isDarkMode = false;

  static Color get cleanWhite => isDarkMode ? Colors.black : Colors.white;
  static Color get backgroundColor =>
      isDarkMode ? Colors.grey[850]! : const Color(0xffF2F2F2);
  static Color get mainColor => const Color(0xff70A3F3);
  static Color get lightMainColor => const Color(0xffE2EDFD);
  static Color get mainBlack =>
      isDarkMode ? Colors.white : const Color(0xff151515);
}

const deepGray = Color(0xffB9B9B9);
const lightGray = Color(0xffD9D9D9);
