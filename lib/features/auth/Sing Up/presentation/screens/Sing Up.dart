import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weatherai/features/auth/Sing%20Up/presentation/screens/completeSingUp.dart';
import 'package:weatherai/features/auth/Sing%20Up/presentation/widget/SingUpStatment.dart';
import '../../../../../config/route/Navigator.dart';
import '../../../../../core/utilies/ColorManager.dart';
import '../../../../../core/utilies/strings.dart';
import '../../../../../core/widget/Button.dart';
import '../../../../../core/widget/Logo.dart';
import '../../../../../core/widget/textform.dart';
import '../../../login/presentation/login.dart';


class SingUp extends StatelessWidget {

  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 20.h),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Logo(),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SingUpStatement(),
                      //userName
                      CustomTextForm(
                          name: " userName",
                          controller:userNameController ,
                          keyboardType: TextInputType.text,
                          onFiledSubmitted: (value){},
                          validation:(value){
                            if(value!.isEmpty){
                              return Strings.userNameValidate;
                            }
                            return null;
                          }
                      ),
                      //email
                      CustomTextForm(
                          name: " Email",
                          controller:emailController,
                          keyboardType: TextInputType.emailAddress,
                          onFiledSubmitted: (value){},
                          validation:(value){
                            if(value!.isEmpty){
                              return Strings.emailValidate;
                            }
                            return null;
                          }
                      ),
                      //password
                      CustomTextForm(
                          name: " Password",
                          controller:passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          hideInput: true,
                          onFiledSubmitted: (value){},
                          validation:(value){
                            if(value!.isEmpty){
                              return Strings.passwordValidate;
                            }
                            return null;
                          }
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Button(
                          text: Strings.next,
                          width: double.infinity,
                          onTap: (){
                            if(formKey.currentState!.validate()){
                              PushNavigation().navigation(
                                  context: context,
                                  screen: CompleteSingUp(
                                      userName: userNameController.text,
                                      email: emailController.text,
                                      password: passwordController.text
                                  ));
                            }
                          }
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                TextButton(
                    onPressed: (){
                      PushNavigation().navigation(context: context, screen: Login());
                    },
                    child: Text(
                      Strings.haveAnAccount ,
                      style: TextStyle(
                        color: ColorManager.secondaryColor,
                        fontSize: 18.sp,
                      ),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
