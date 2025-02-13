import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utilies/ColorManager.dart';
import '../../../../../core/utilies/strings.dart';

class LoginStatment extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            Strings.login,
            style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
                color: ColorManager.textColor
            ),
          ),
          Text(
            Strings.loginStatement,
            style: TextStyle(
                color: ColorManager.textColor!.withOpacity(.8),
                fontSize: 18
            ),
          ),
        ],
      ),
    );;
  }
}
