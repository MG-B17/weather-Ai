import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:weatherai/core/widget/errorDialog.dart';
import 'package:weatherai/features/auth/Sing%20Up/presentation/widget/cmWidget.dart';
import 'package:weatherai/features/home/Home.dart';
import '../../../../../config/route/Navigator.dart';
import '../../../../../core/utilies/ColorManager.dart';
import '../../../../../core/utilies/strings.dart';
import '../../../../../core/widget/Button.dart';
import '../../../../../core/widget/Logo.dart';
import '../../../../../core/widget/loading.dart';
import '../../../../../core/widget/textform.dart';
import '../../../login/presentation/login.dart';
import '../controller/cubit.dart';
import '../controller/states.dart';
import 'package:weatherai/core/di/di.dart' as di;

import '../widget/SingUpStatment.dart';

class CompleteSingUp extends StatefulWidget {

  final String userName;
  final String email;
  final String password ;

  CompleteSingUp({required this.userName, required this.email,required this.password});

  @override
  State<CompleteSingUp> createState() => _CompleteSingUpState();
}

class _CompleteSingUpState extends State<CompleteSingUp> {
  var birthDateController = TextEditingController();

  var heightController = TextEditingController();

  var weightController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>di.sl<SingUpCubit>(),
      child: BlocConsumer<SingUpCubit,SingUpStates>(
        listener: (context,state){
          if(state is SingUpSuccess){
            PushAndRemoveNavigation().navigation(context: context, screen: Home());
          }else if (state is SingUpFail){
            showDialog(context: context, builder:(context)=>errorAlertDialog(
                errorTittle:Strings.singUpError, errorMessage: state.message),
              barrierColor: ColorManager.primaryColor!.withOpacity(.7)
            );
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              leading: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: ColorManager.textColor,
                  size: 24.h,
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 20.h),
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
                              name: "Birth Date",
                              controller:birthDateController ,
                              keyboardType: TextInputType.none,
                              onTap: (){
                                showDatePicker(
                                    context: context,
                                  firstDate: DateTime(1960),
                                  lastDate:DateTime(2008),
                                  initialDate: DateTime(2000)
                                ).then((value){
                                  setState(() {
                                    final f = new DateFormat.yMMMMd();
                                    birthDateController.text= f.format(value!);
                                    print(birthDateController.text);
                                  });
                                });
                              },
                              onFiledSubmitted: (value){},
                              validation:(value){
                                if(value!.isEmpty){
                                  return Strings.birthDateValidate;
                                }
                                return null;
                              }
                          ),
                          //email
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextForm(
                                    name: "Height",
                                    controller:heightController,
                                    keyboardType: TextInputType.number,
                                    onFiledSubmitted: (value){},
                                    validation:(value){}
                                ),
                              ),
                              CmWidget(text: "CM",)
                            ],
                          ),
                          //password
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextForm(
                                    name: "Weight",
                                    controller:weightController,
                                    keyboardType: TextInputType.number,
                                    onFiledSubmitted: (value){},
                                    validation:(value){}
                                ),
                              ),
                             CmWidget(text: "Kg",)
                            ],
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                         state is LoadingSingUp?Center( child:spinkit,) : Button(
                              text: Strings.singUp,
                              width: double.infinity,
                              onTap: (){
                                if(formKey.currentState!.validate()){
                                  SingUpCubit.of(context).singUp(
                                      userName: widget.userName,
                                      email: widget.email,
                                      password: widget.password,
                                      birthDate: birthDateController.text,
                                      height: heightController.text,
                                      weight: weightController.text,
                                      context: context);
                                }
                              }
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
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
          );
        },
      ),
    );
  }
}
