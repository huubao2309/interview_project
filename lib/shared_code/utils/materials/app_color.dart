import 'package:flutter/material.dart';

class AppColor extends ChangeNotifier {
  AppColor();

  static Map<int, Color> color = {
    50: const Color.fromRGBO(76, 175, 80, .1),
    100: const Color.fromRGBO(76, 175, 80, .2),
    200: const Color.fromRGBO(76, 175, 80, .3),
    300: const Color.fromRGBO(76, 175, 80, .4),
    400: const Color.fromRGBO(76, 175, 80, .5),
    500: const Color.fromRGBO(76, 175, 80, .6),
    600: const Color.fromRGBO(76, 175, 80, .7),
    700: const Color.fromRGBO(76, 175, 80, .8),
    800: const Color.fromRGBO(76, 175, 80, .9),
    900: const Color.fromRGBO(76, 175, 80, 1),
  };

  // static Color colorNavajoWhite = const Color(0xFF4CAF50); // Green
  static Color colorGrey = Colors.grey;
  static Color colorGreen = Colors.green;
  static Color colorBlue = Colors.blue;
  static Color colorWhite = Colors.white;
  static Color colorRed = Colors.red;
  static Color colorPink = Colors.pink;
  static Color colorOrange = Colors.orange;
  static Color colorCyan = Colors.cyan;

  static Brightness brightness = Brightness.light;
  static MaterialColor defaultHeaderOSColor = MaterialColor(0xFF087f23, AppColor.color); // dark green
  static MaterialColor primaryColor = MaterialColor(0xFF4CAF50, AppColor.color); // green
  static MaterialColor accentColor = MaterialColor(0xFFFFD600, AppColor.color); // yellow
  static MaterialColor dividerColor = MaterialColor(0xFFF1F1F1, AppColor.color); // grey
  static MaterialColor textPrimaryColor = MaterialColor(0xFF000000, color); // black
  static MaterialColor textSecondColor = MaterialColor(0xFFFFFFFF, color); // white
  static MaterialColor primaryHintColor = MaterialColor(0xFFADADAD, color); // gray
  static MaterialColor primaryBorderColor = MaterialColor(0xFFADADAD, color); // gray
  static MaterialColor primarySelectedColor = MaterialColor(0xFFADADAD, color); // gray
  static MaterialColor primaryBackgroundColor = MaterialColor(0xFFFFFFFF, color); // white
  static MaterialColor disabledColor = MaterialColor(0xFFADADAD, color); // gray
  static MaterialColor errorColor = MaterialColor(0xFFEE0707, color); // red
  static MaterialColor cursorColor = MaterialColor(0xFF000000, color); // black
  // static MaterialColor secondBackgroundColor = MaterialColor(0xFFFFFFFF, color); // white
  static MaterialColor shadowColor = MaterialColor(0x42000000, color); // black26

  void switchMode({bool isDarkTheme = false}) {
    if (!isDarkTheme) {
      // Light Mode
      brightness = Brightness.light;
      defaultHeaderOSColor = MaterialColor(0xFF087f23, AppColor.color); // dark green
      primaryColor = MaterialColor(0xFF4CAF50, AppColor.color); // green
      accentColor = MaterialColor(0xFFFFD600, AppColor.color); // yellow
      dividerColor = MaterialColor(0xFFF1F1F1, AppColor.color); // grey
      textPrimaryColor = MaterialColor(0xFF000000, color); // black
      textSecondColor = MaterialColor(0xFFFFFFFF, color); // white
      primaryHintColor = MaterialColor(0xFFADADAD, color); // gray
      primaryBorderColor = MaterialColor(0xFFADADAD, color); // gray
      primarySelectedColor = MaterialColor(0xFFADADAD, color); // gray
      primaryBackgroundColor = MaterialColor(0xFFFFFFFF, color); // white
      disabledColor = MaterialColor(0xFFADADAD, color); // gray
      errorColor = MaterialColor(0xFFEE0707, color); // red
      cursorColor = MaterialColor(0xFF000000, color); // black
      // secondBackgroundColor = MaterialColor(0xFFFFFFFF, color); // white
      shadowColor = MaterialColor(0x42000000, color); // black26
    } else {
      // Dark Mode
      brightness = Brightness.dark;
      defaultHeaderOSColor = MaterialColor(0xFF087f23, AppColor.color); // dark green
      primaryColor = MaterialColor(0xFF4CAF50, AppColor.color); // green
      accentColor = MaterialColor(0xFFFFD600, AppColor.color); // yellow
      dividerColor = MaterialColor(0xFFF1F1F1, AppColor.color); // grey
      textPrimaryColor = MaterialColor(0xFFFFFFFF, color); // white
      textSecondColor = MaterialColor(0xFF000000, color); // black
      primaryHintColor = MaterialColor(0xFFADADAD, color); // gray
      primaryBorderColor = MaterialColor(0xFFADADAD, color); // gray
      primarySelectedColor = MaterialColor(0xFFADADAD, color); // gray
      primaryBackgroundColor = MaterialColor(0xFF000000, color); // black
      disabledColor = MaterialColor(0xFFADADAD, color); // gray
      errorColor = MaterialColor(0xFFEE0707, color); // red
      cursorColor = MaterialColor(0xFFFFFFFF, color); // white
      // secondBackgroundColor = MaterialColor(0xFF000000, color); // black
      shadowColor = MaterialColor(0xFFFFFFFF, color); // white
    }

    notifyListeners();
  }
}
