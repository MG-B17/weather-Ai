import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:weatherai/core/widget/errorDialog.dart';
import 'package:weatherai/features/home/presentation/screen/Home.dart';
import '../../../../../config/route/Navigator.dart';
import '../../../../../core/utilies/ColorManager.dart';
import '../../../../../core/utilies/strings.dart';
import '../../../../../core/widget/Button.dart';
import '../../../../../core/widget/loading.dart';
import '../../../../../core/widget/textform.dart';
import '../../../login/presentation/login.dart';
import '../controller/cubit.dart';
import '../controller/states.dart';


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
    return BlocConsumer<SingUpCubit,SingUpStates>(
      listener: (context,state){
        if(state is SingUpSuccess){
          PushAndRemoveNavigation().navigation(context: context, screen: Home());
        }else if (state is SingUpFail){
          showDialog(context: context, builder:(context)=>errorAlertDialog(
              errorTittle:Strings.singUpError, errorMessage: state.message),
          );
        }
      },
      builder: (context,state){
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FadeInUp(
                  duration: Duration(seconds: 1),
                    child: SingUpStatement()),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 20.h),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //userName
                        CustomTextForm(
                            name: "Birth Date",
                            preFixICon:Icons.calendar_month_outlined,
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
                                  preFixICon: Icons.person_outline_outlined,
                                  controller:heightController,
                                  keyboardType: TextInputType.number,
                                  onFiledSubmitted: (value){},
                                  validation:(value){}
                              ),
                            ),
                          ],
                        ),
                        //password
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextForm(
                                  name: "Weight",
                                  preFixICon: Icons.line_weight_outlined,
                                  controller:weightController,
                                  keyboardType: TextInputType.number,
                                  onFiledSubmitted: (value){},
                                  validation:(value){}
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                       state is LoadingSingUp? Center( child:spinkit,) : FadeInUp(
                         duration: Duration(seconds: 1),
                         child: Button(
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
                       ),
                      ],
                    ),
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
                        color: ColorManager.textColor,
                        fontSize: 18.sp,
                      ),
                    )
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
