import 'package:flutter/material.dart';
import 'package:interview_project/shared_code/utils/materials/app_color.dart';

class AppBarTitleTextStyle {
  static TextStyle titleBoldAppBar() {
    return TextStyle(
      fontSize: 24,
      color: AppColor.textSecondColor,
      fontWeight: FontWeight.bold,
    );
  }
}

class TitleTextStyle {
  static TextStyle normal() {
    return TextStyle(
      fontSize: 16,
      color: AppColor.textPrimaryColor.withOpacity(0.7),
    );
  }

  static TextStyle bold() {
    return TextStyle(
      fontSize: 16,
      color: AppColor.textPrimaryColor,
      fontWeight: FontWeight.bold,
    );
  }
}

class SubTextStyle {
  static TextStyle normal() {
    return TextStyle(
      fontSize: 14,
      color: AppColor.textPrimaryColor,
    );
  }

  static TextStyle bold() {
    return TextStyle(
      fontSize: 14,
      color: AppColor.textPrimaryColor,
      fontWeight: FontWeight.bold,
    );
  }
}

class InputTextFormFieldStyle {
  static TextStyle hintText() {
    return TextStyle(
      fontSize: 16,
      color: AppColor.textPrimaryColor.withOpacity(0.4),
      fontWeight: FontWeight.normal,
    );
  }

  static TextStyle labelText() {
    return TextStyle(
      fontSize: 16,
      color: AppColor.textPrimaryColor.withOpacity(0.4),
      fontWeight: FontWeight.normal,
    );
  }

  static TextStyle inputText() {
    return TextStyle(
      fontSize: 20,
      color: AppColor.textPrimaryColor,
      fontWeight: FontWeight.normal,
    );
  }
}

class InputInfoFormFieldStyle {
  static TextStyle hintText() {
    return TextStyle(
      fontSize: 14,
      color: AppColor.textPrimaryColor.withOpacity(0.4),
      fontWeight: FontWeight.normal,
    );
  }

  static TextStyle labelText() {
    return TextStyle(
      fontSize: 14,
      color: AppColor.textPrimaryColor.withOpacity(0.4),
      fontWeight: FontWeight.normal,
    );
  }

  static TextStyle inputText() {
    return TextStyle(
      fontSize: 14,
      color: AppColor.textPrimaryColor,
      fontWeight: FontWeight.normal,
    );
  }

  static TextStyle inputBoldText() {
    return TextStyle(
      fontSize: 14,
      color: AppColor.textPrimaryColor,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle errorText() {
    return TextStyle(
      fontSize: 14,
      color: AppColor.errorColor,
      fontWeight: FontWeight.normal,
    );
  }
}

class LoginPageTextStyle {
  static TextStyle welcomeLogin() {
    return TextStyle(
      fontSize: 15,
      color: AppColor.textSecondColor,
    );
  }

  static TextStyle titleLogin() {
    return TextStyle(
      fontSize: 22,
      color: AppColor.textSecondColor,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle contentLogin() {
    return TextStyle(
      fontSize: 15,
      color: AppColor.textSecondColor,
      fontWeight: FontWeight.normal,
    );
  }
}

