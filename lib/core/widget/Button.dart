import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utilies/colorManager.dart';

class Button extends StatelessWidget {
  String text ;
  double width ;
  void Function() onTap;

  Button({required this.text,required this.width,required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: 45.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
            color:ColorManager.secondaryColor
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp
            ),
          ),
        ),
      ),
    );
  }
}
