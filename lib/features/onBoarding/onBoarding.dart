import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weatherai/features/onBoarding/widget/image&text.dart';
import '../../config/route/Navigator.dart';
import '../../core/utilies/strings.dart';
import '../../core/widget/Button.dart';
import '../auth/Sing Up/presentation/screens/Sing Up.dart';
import '../auth/login/presentation/login.dart';

class OnBoarding extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          ImageAndText(),
          const Spacer(),
          Padding(
            padding:EdgeInsets.symmetric(vertical: 18.h,horizontal: 12.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // sing up button
                Button(
                    text: Strings.singUp,
                    width: double.infinity,
                    onTap: (){
                      PushNavigation().navigation(context: context, screen: SingUp());
                    }
                ),
                SizedBox(
                  height: 15.h,
                ),
                // login button
                Button(
                    text: Strings.login,
                    width: double.infinity,
                    onTap: ()async{
                     PushNavigation().navigation(context: context, screen: Login());
                    }
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
