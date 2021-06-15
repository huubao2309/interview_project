import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:interview_project/shared_code/style/text_style/txt_style.dart';
import 'package:interview_project/shared_code/utils/materials/app_color.dart';
import 'package:interview_project/shared_code/utils/materials/system.dart';

class DialogTwoButton extends StatelessWidget {
  const DialogTwoButton({
    required this.onPressedCancel,
    required this.onPressedAgree,
    required this.title,
    required this.content,
  });

  final VoidCallback onPressedCancel;
  final VoidCallback onPressedAgree;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _dialogOnButtonContent(context),
    );
  }

  Widget _dialogOnButtonContent(BuildContext context) {
    return Container(
      width: sizeDevice.width,
      margin: const EdgeInsets.only(left: 20, right: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.primaryBackgroundColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColor.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              Text(
                content,
                style: TextStyle(
                  color: AppColor.textPrimaryColor,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: onPressedAgree,
                      child: Card(
                        color: AppColor.primaryColor,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Container(
                          height: 35,
                          margin: const EdgeInsets.all(2),
                          padding: const EdgeInsets.all(5),
                          child: Center(
                            child: Text(
                              tr('Yes').toUpperCase(),
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColor.textSecondColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: onPressedCancel,
                      child: Card(
                        color: AppColor.primaryBackgroundColor,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Container(
                          height: 35,
                          margin: const EdgeInsets.all(2),
                          padding: const EdgeInsets.all(5),
                          child: Center(
                            child: Text(
                              tr('No').toUpperCase(),
                              style: SubTextStyle.bold(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
