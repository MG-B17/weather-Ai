import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weatherai/core/widget/errorDialog.dart';
import 'package:weatherai/core/widget/loading.dart';
import 'package:weatherai/features/auth/login/presentation/controller/cubit.dart';
import 'package:weatherai/features/auth/login/presentation/controller/states.dart';
import 'package:weatherai/features/auth/login/presentation/widget/forgetPassword.dart';
import 'package:weatherai/features/auth/login/presentation/widget/loginStatment.dart';
import 'package:weatherai/features/home/Home.dart';
import '../../../../config/route/Navigator.dart';
import '../../../../core/utilies/ColorManager.dart';
import '../../../../core/utilies/strings.dart';
import '../../../../core/widget/Button.dart';
import '../../../../core/widget/Logo.dart';
import '../../../../core/widget/textform.dart';
import '../../Sing Up/presentation/screens/Sing Up.dart';
import 'package:weatherai/core/di/di.dart' as di;

class Login extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>di.sl<LoginCubit>(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){
          if (state is LoginSuccess){
            PushAndRemoveNavigation().navigation(context: context, screen: Home());
          }else if(state is LoginFail){
            showDialog(
                barrierColor: ColorManager.primaryColor!.withOpacity(.7),
                context: context,
                builder:(context)=> errorAlertDialog(errorTittle: Strings.loginError,errorMessage: state.message)
            );
          }
        },
        builder: (context,state){
         return Scaffold(
            body:SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 20.h),
                child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Logo(),
                        //form
                        Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              LoginStatment(),
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
                              //forget Password
                              ForgetPassword(),
                             state is LoadingLogin? Center(child: spinkit,) : Button(
                                  text: Strings.login,
                                  width: double.infinity,
                                  onTap: (){
                                    if(formKey.currentState!.validate()){
                                      LoginCubit.of(context).login(password:passwordController.text, email:emailController.text);
                                    }
                                  }
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 100.h,
                        ),
                        TextButton(
                            onPressed: (){
                              PushNavigation().navigation(context: context, screen: SingUp());
                            },
                            child: Text(
                              Strings.doNotHaveAnAccount,
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
        },
      ),
    );
  }
}
