import 'package:flutter/material.dart';

class ColorPallete {
  static const Color mainColor = Color.fromRGBO(72, 181, 132, 1);
  static const Color secondaryColor = Color(0xFF17203A);
  static const Color therdColor = Color.fromARGB(255, 0, 0, 0);
  static const Color green = Color(0xFF009E19);
  static const Color red = Color(0xFFC72C41);
  static const Color grey = Color(0xFF949498);

  static MaterialColor getMaterialColor(Color color) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(color.value, shades);
  }
}
