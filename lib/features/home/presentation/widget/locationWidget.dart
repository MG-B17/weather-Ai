import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utilies/ColorManager.dart';

class LocationWidget extends StatelessWidget {

  String location;

  LocationWidget({required this.location});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: Duration(milliseconds: 750),
      child: Padding(
        padding:EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.location_on_outlined,
              color: ColorManager.myWhite,
              weight: 20.h,
            ),
            Text(
              location,
              style: TextStyle(
                  color: ColorManager.myWhite,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
    );
  }
}
