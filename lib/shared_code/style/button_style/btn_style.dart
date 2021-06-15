import 'package:flutter/material.dart';
import 'package:interview_project/shared_code/utils/materials/app_color.dart';

class BtnStyle {
  static TextStyle textButtonBold() {
    return TextStyle(
      fontSize: 14,
      color: AppColor.textSecondColor,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle textButtonNormal() {
    return TextStyle(
      fontSize: 14,
      color: AppColor.textSecondColor,
      fontWeight: FontWeight.normal,
    );
  }

  static TextStyle textSmallButtonBold() {
    return TextStyle(
      fontSize: 12,
      color: AppColor.textSecondColor,
      fontWeight: FontWeight.bold,
    );
  }
}
