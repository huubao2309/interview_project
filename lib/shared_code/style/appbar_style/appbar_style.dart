import 'package:flutter/material.dart';
import 'package:interview_project/shared_code/style/text_style/txt_style.dart';
import 'package:interview_project/shared_code/utils/materials/app_color.dart';

class AppBarStyle {
  static TextStyle titleAppBar() {
    return AppBarTitleTextStyle.titleBoldAppBar();
  }

  static Color backgroundAppBar() {
    return AppColor.primaryColor;
  }

  static Color backgroundCustomAppBar() {
    return AppColor.primaryColor;
  }

  static Icon iconAppBar() {
    return Icon(
      Icons.arrow_back,
      color: AppColor.textSecondColor,
    );
  }
}
