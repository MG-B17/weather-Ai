import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weatherai/core/di/di.dart'as di;
import 'package:weatherai/core/helpers/cacheHelper.dart';
import 'package:weatherai/core/helpers/fireBase/fireBaseKey.dart';
import 'package:weatherai/core/utilies/variables.dart';
import 'AiWeather.dart';
import 'config/bloc_Observer.dart';
import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
 );

 await ScreenUtil.ensureScreenSize();

 di.init();

 Bloc.observer = MyBlocObserver();

 checkLogin();

 runApp(AiWeather());

}

void checkLogin()async{
  String uid= await CacheHelper.getData(key: FireBaseKeys.uid)??"";
  if(uid.isNotEmpty){
    Variables.isUserLogin=true;
  }else{
    Variables.isUserLogin=false;
  }
}
