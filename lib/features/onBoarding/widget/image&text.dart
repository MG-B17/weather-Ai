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
                colors: [
                  Color.fromRGBO(8, 36,79, 1),
                  Color.fromRGBO(19, 76,181, 1),
                  Color.fromRGBO(11, 66,171, 1),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                stops: const [0.15, 0.7,1],
              )
          ),
          child: Center(
            child: Image(
              image:const AssetImage("assets/images/onBoarding.jpg"),
              width: double.infinity,
              height: 530.h,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          Strings.onBoardingStatement,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorManager.myWhite,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        )
      ],
    );
  }
}
