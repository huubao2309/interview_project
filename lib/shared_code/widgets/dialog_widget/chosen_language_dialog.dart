import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:interview_project/common/common.dart';
import 'package:interview_project/data/shared_preferences/shared_preferences.dart';
import 'package:interview_project/shared_code/utils/materials/app_color.dart';
import 'package:interview_project/shared_code/utils/materials/constant.dart';
import 'package:interview_project/shared_code/utils/materials/system.dart';

class ChosenLanguageDialog extends StatelessWidget {
  const ChosenLanguageDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _dialogContent(context),
    );
  }

  Widget _dialogContent(BuildContext context) {
    return Container(
      width: sizeDevice.width,
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
            tr('chosenLanguage').toUpperCase(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColor.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  // Change Language
                  EasyLocalization.of(context)!.setLocale(EasyLocalization.of(context)!.supportedLocales[0]); // 0: Vietnamese

                  // Save Language
                  SPref.instance.set(SPrefCache.LANGUAGE_APP, VIETNAMESE_LANGUAGE);

                  Navigator.of(context).pop(); // To close the dialog
                },
                child: Card(
                  color: AppColor.primaryBackgroundColor,
                  elevation: 2,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    width: sizeDevice.width,
                    height: 35,
                    child: Row(
                      children: [
                        const Spacer(),
                        Text(
                          tr('VietNamese').toUpperCase(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColor.textPrimaryColor,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.navigate_next,
                          color: AppColor.textPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  // Change Language
                  EasyLocalization.of(context)!.setLocale(EasyLocalization.of(context)!.supportedLocales[1]); // 1: English

                  // Save Language
                  SPref.instance.set(SPrefCache.LANGUAGE_APP, ENGLISH_LANGUAGE);

                  Navigator.of(context).pop(); // To close the dialog
                },
                child: Card(
                  color: AppColor.primaryBackgroundColor,
                  elevation: 2,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    width: sizeDevice.width,
                    height: 35,
                    child: Row(
                      children: [
                        const Spacer(),
                        Text(
                          tr('English').toUpperCase(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColor.textPrimaryColor,
                          ),
                        ),
                        const Spacer(),
                        Icon(Icons.navigate_next, color: AppColor.textPrimaryColor),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
