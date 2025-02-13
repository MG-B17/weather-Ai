import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utilies/colorManager.dart';
import '../../../core/utilies/strings.dart';

class ImageAndText extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                colors:[
                  ColorManager.primaryColor!,
                  ColorManager.primaryColor!.withOpacity(0.0),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                stops: const [0.14, 0.4],
              )
          ),
          child: Image(
            image:const AssetImage("assets/images/onBoarding.jpg"),
            width: double.infinity,
            height: 530.h,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          Strings.onBoardingStatement,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorManager.textColor,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        )
      ],
    );
  }
}
