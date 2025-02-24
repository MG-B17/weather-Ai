import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weatherai/core/widget/errorDialog.dart';
import 'package:weatherai/core/widget/loading.dart';
import 'package:weatherai/features/auth/login/presentation/controller/cubit.dart';
import 'package:weatherai/features/auth/login/presentation/controller/states.dart';
import 'package:weatherai/features/auth/login/presentation/widget/forgetPassword.dart';
import 'package:weatherai/features/auth/login/presentation/widget/loginStatment.dart';
import 'package:weatherai/features/home/presentation/screen/Home.dart';
import '../../../../config/route/Navigator.dart';
import '../../../../core/utilies/ColorManager.dart';
import '../../../../core/utilies/strings.dart';
import '../../../../core/widget/Button.dart';
import '../../../../core/widget/textform.dart';
import '../../Sing Up/presentation/screens/Sing Up.dart';
import 'package:weatherai/core/di/di.dart' as di;

class Login extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit,LoginStates>(
      listener: (context,state){
        if (state is LoginSuccess){
          PushAndRemoveNavigation().navigation(context: context, screen: Home());
        }else if(state is LoginFail){
          showDialog(
              context: context,
              builder:(context)=> errorAlertDialog(errorTittle: Strings.loginError,errorMessage: state.message)
          );
        }
      },
      builder: (context,state){
       return Scaffold(
          body:SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 FadeInUp(
                     child: LoginStatment(),
                   duration: Duration(seconds: 1),
                 ) ,
                  //form
                  Padding(
                    padding:EdgeInsets.symmetric(vertical: 10.h,horizontal: 26.w),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //email
                          CustomTextForm(
                              name: " Email",
                              preFixICon: Icons.email_outlined,
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
                              preFixICon: Icons.lock_outlined,
                              sufFixICon:LoginCubit.of(context).hidePassword?Icons.visibility:Icons.visibility_off_outlined,
                              onTap: (){
                                LoginCubit.of(context).changePassword();
                              },
                              controller:passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              hideInput:LoginCubit.of(context).hidePassword,
                              onFiledSubmitted: (value){},
                              validation:(value){
                                if(value!.isEmpty){
                                  return Strings.passwordValidate;
                                }
                                return null;
                              }
                          ),
                          //forget Password
                          ForgetPassword(),
                         state is LoadingLogin? Center(child: spinkit,) : FadeInUp(
                           duration: Duration(seconds: 1),
                           child: Button(
                                text: Strings.login,
                                width: double.infinity,
                                onTap: (){
                                  if(formKey.currentState!.validate()){
                                    LoginCubit.of(context).login(password:passwordController.text, email:emailController.text);
                                  }
                                }
                            ),
                         ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Padding(
                    padding:EdgeInsets.symmetric(vertical: 10.h),
                    child: TextButton(
                        onPressed: (){
                          PushNavigation().navigation(context: context, screen: SingUp());
                        },
                        child: Text(
                          Strings.doNotHaveAnAccount,
                          style: TextStyle(
                            color: ColorManager.textColor,
                            fontSize: 18.sp,
                          ),
                        )
                    ),
                  ),
                ],
              ),
            ),
          );
      },
    );
  }
}
