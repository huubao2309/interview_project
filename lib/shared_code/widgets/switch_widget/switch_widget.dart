import 'package:flutter/material.dart';
import 'package:interview_project/shared_code/utils/materials/app_color.dart';

class SwitchWidget extends StatelessWidget {
  const SwitchWidget({
    required this.value,
    required this.onChanged,
    this.inactiveTrackColor,
    this.inactiveThumbColor,
  });

  final bool value;
  final Function(bool) onChanged;
  final Color? inactiveTrackColor;
  final Color? inactiveThumbColor;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      activeColor: AppColor.primaryColor,
      activeTrackColor: AppColor.disabledColor,
      inactiveTrackColor: inactiveTrackColor ?? AppColor.disabledColor,
      inactiveThumbColor: inactiveThumbColor ?? AppColor.primaryColor,
      onChanged: onChanged,
    );
  }
}
