import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utilies/colorManager.dart';

class CustomTextForm extends StatelessWidget {

   String name;
   TextEditingController controller;
   String? Function(String?)? validation;
   TextInputType keyboardType ;
   void Function(String)? onFiledSubmitted;
   void Function(String)? onChange;
   void Function()? onTap;
   bool hideInput;
   bool readOnly;

  CustomTextForm({
   required this.name,
   required this.controller,
   required this.keyboardType,
    this.hideInput = false,
   required this.onFiledSubmitted,
   required this.validation,
    this.readOnly = false,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.symmetric(vertical:5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
                fontSize: 18.sp,
                color: ColorManager.textColor
            ),
          ),
          TextFormField(
            style: TextStyle(
                color: ColorManager.textColor,
                fontSize: 16.sp
            ),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide(
                    color:  Colors.white.withOpacity(.1),
                  )
              ),
              focusedBorder:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide(
                    color: ColorManager.textColor!,
                  )
              ),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide(
                    color: ColorManager.errorColor,
                  )
              ) ,
              filled: true,
              fillColor: Colors.white.withOpacity(.1),
            ),
            validator: validation,
            controller: controller,
            cursorColor: ColorManager.textColor,
            keyboardType: keyboardType,
            onFieldSubmitted: onFiledSubmitted,
            onTap: onTap,
            obscureText: hideInput,
            readOnly: readOnly,
          ),
        ],
      ),
    );
  }
}
