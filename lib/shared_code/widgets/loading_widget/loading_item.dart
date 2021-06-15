import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:interview_project/shared_code/utils/materials/app_color.dart';
import 'package:interview_project/shared_code/widgets/animation_widget/scale_animation.dart';

class LoadingItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaleAnimation(
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: AppColor.primaryBackgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 12,
              spreadRadius: 0.1,
              offset: Offset(
                1, // horizontal, move right 10
                1, // vertical, move down 10
              ),
            )
          ],
        ),
        child: SpinKitFadingCircle(
          color: AppColor.primaryColor,
        ),
      ),
    );
  }
}
