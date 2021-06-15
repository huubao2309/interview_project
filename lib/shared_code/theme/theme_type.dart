import 'package:flutter/material.dart';
import 'package:interview_project/common/common.dart';
import 'package:interview_project/shared_code/utils/materials/app_color.dart';

enum ThemeType { DARK, LIGHT }

class ThemeState extends ChangeNotifier {
  ThemeState() {
    getTheme().then((type) {
      isDarkTheme = type == ThemeType.DARK;
      notifyListeners();
    });
  }

  bool isDarkTheme = false;

  Future<ThemeType> getTheme() async {
    return isDarkTheme ? ThemeType.DARK : ThemeType.LIGHT;
  }

  String get themeName => isDarkTheme ? DARK_THEME : LIGHT_THEME;

  ThemeType get theme => isDarkTheme ? ThemeType.DARK : ThemeType.LIGHT;

  set theme(ThemeType type) => setTheme(type);

  Future<void> setTheme(ThemeType type) async {
    isDarkTheme = type == ThemeType.DARK;

    AppColor().switchMode(isDarkTheme: isDarkTheme);
    notifyListeners();
  }

  ThemeData setColorTheme() {
    return ThemeData(
      colorScheme: const ColorScheme.light().copyWith(
        primary: AppColor.primaryColor,
        brightness: AppColor.brightness,
      ),
      brightness: AppColor.brightness,
      primaryColor: AppColor.primaryColor,
      accentColor: AppColor.accentColor,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColor.cursorColor,
        selectionColor: Colors.black.withOpacity(0.5),
        selectionHandleColor: Colors.black,
      ),
      toggleableActiveColor: AppColor.primaryColor,
      fontFamily: 'Quicksand',
    );
  }
}
