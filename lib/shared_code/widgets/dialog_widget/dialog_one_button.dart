import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:interview_project/shared_code/utils/materials/app_color.dart';

class DialogOneButton extends StatelessWidget {
  const DialogOneButton({
    required this.onPressed,
    required this.title,
    required this.content,
    this.textButton = '',
  });

  final VoidCallback onPressed;
  final String title;
  final String content;
  final String textButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.colorWhite.withOpacity(0.1),
      child: AlertDialog(
        title: Text(title, style: TextStyle(color: AppColor.textPrimaryColor)),
        content: Text(content, style: TextStyle(color: AppColor.textPrimaryColor)),
        backgroundColor: AppColor.primaryBackgroundColor,
        actions: <Widget>[
          TextButton(
            onPressed: onPressed,
            child: Text(
              textButton.isEmpty ? tr('OK').toUpperCase() : textButton.toUpperCase(),
              style: TextStyle(color: AppColor.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
