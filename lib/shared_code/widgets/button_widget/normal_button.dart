import 'package:flutter/material.dart';
import 'package:interview_project/shared_code/style/button_style/btn_style.dart';
import 'package:interview_project/shared_code/utils/materials/app_color.dart';
import 'package:interview_project/shared_code/utils/materials/system.dart';

class NormalButton extends StatelessWidget {
  const NormalButton({
    required this.onPressed,
    required this.title,
    this.color,
    this.heightButton,
    this.minimumText = false,
    this.focusNode,
  });

  final VoidCallback onPressed;
  final String title;
  final Color? color;
  final double? heightButton;
  final bool minimumText;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      focusNode: focusNode,
      onPressed: onPressed,
      style: ButtonStyle(
        // foregroundColor: MaterialStateProperty.resolveWith<Color>(
        //   // text color
        //       (Set<MaterialState> states) => states.contains(MaterialState.disabled)
        //       ? disabledTextColorx
        //       : textColorx,
        // ),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          // background color    this is color:
          (states) => states.contains(MaterialState.disabled)
              ? color ?? AppColor.primaryColor[500]
              : color ?? AppColor.primaryColor.withOpacity(0.2),
        ),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Colors.transparent),
        )),
      ),
      child: Container(
        width: sizeDevice.width,
        height: heightButton ?? 55,
        child: Center(
          child: Text(
            title.toUpperCase(),
            textAlign: TextAlign.center,
            style: minimumText ? BtnStyle.textSmallButtonBold() : BtnStyle.textButtonBold(),
          ),
        ),
      ),
    );
  }
}
