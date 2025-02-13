import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weatherai/core/utilies/ColorManager.dart';

AlertDialog errorAlertDialog ({required String errorTittle,required String errorMessage})
{
  return AlertDialog(
    backgroundColor: ColorManager.textColor!.withOpacity(.6),
    shadowColor: ColorManager.textColor!.withOpacity(.6),
    icon: Icon(
      Icons.error_outline,
      color: ColorManager.errorColor,
      size: 28.h,
    ),
    title:Text(
      errorTittle,
      style: TextStyle(
        color: ColorManager.errorColor,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold
      ),
    ),
    content:Text(
      errorMessage,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: ColorManager.primaryColor,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold
      ),
    ) ,
  );
}