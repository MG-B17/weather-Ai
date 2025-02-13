import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weatherai/core/utilies/variables.dart';
import 'package:weatherai/features/home/Home.dart';

import 'config/theme/appTheme.dart';
import 'features/onBoarding/onBoarding.dart';

class AiWeather extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_ , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: appTheme(),
          home:Variables.isUserLogin?Home():OnBoarding(),
        );
      },
    );
  }
}
