import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weatherai/core/di/di.dart' as di;
import 'package:weatherai/core/helpers/loactionHelper/locationHelper.dart';
import 'package:weatherai/core/methods/mapCondtionToIamge.dart';
import 'package:weatherai/core/utilies/ColorManager.dart';
import 'package:weatherai/core/utilies/strings.dart';
import 'package:weatherai/core/widget/loading.dart';
import 'package:weatherai/features/home/domain/entity/currentWeatherEntity.dart';
import 'package:weatherai/features/home/domain/entity/forecastEntity.dart';
import 'package:weatherai/features/home/presentation/controller/cubit.dart';
import 'package:weatherai/features/home/presentation/controller/states.dart';
import 'package:weatherai/features/home/presentation/widget/bar.dart';
import 'package:weatherai/features/home/presentation/widget/barIcon.dart';
import 'package:weatherai/features/home/presentation/widget/currentWeatherWidget.dart';
import 'package:weatherai/features/home/presentation/widget/locationWidget.dart';
import 'package:weatherai/features/home/presentation/widget/nextForecastWidget.dart';


class Home extends StatelessWidget {
  List<ForecastEntity> forecast =[];

  CurrentWeatherEntity? currentWeatherEntity;

  bool isLoading = false;

  String message ="";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>di.sl<WeatherCubit>(),
      child: BlocConsumer<WeatherCubit,WeatherStates>(
        listener: (context,state){
          if(state is GetForecastWeatherSuccess){
            forecast=state.forecastList;
            message="";
          }
         else if(state is GetCurrentWeatherSuccess){
             currentWeatherEntity= state.currentWeatherEntity;
             message="";
           }
         else if (state is GetForecastWeatherFail){
           message= state.message;
          }
         else if (state is GetCurrentWeatherFail){
           message=state.message;
          }
        },
        builder: (context,state){
          if(state is LoadingGetCurrentWeather || state is LoadingGetForecastWeather){
           return Scaffold(
              body: Container(
                decoration:BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(8, 36,79, 1),
                        Color.fromRGBO(19, 76,181, 1),
                        Color.fromRGBO(11, 66,171, 1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: const [0.15, 0.7,1],
                    )
                ),
                  child: Center(child: spinkit,)
              ),
            );
          }
          else if(message.isNotEmpty){
            return Scaffold(
              body: SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(8, 36,79, 1),
                          Color.fromRGBO(19, 76,181, 1),
                          Color.fromRGBO(11, 66,171, 1),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: const [0.15, 0.7,1],
                      )
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                  image: message==ErrorMessage.PleaseEnableLoCation?AssetImage("assets/images/noLocation.png"):AssetImage("assets/images/no-wifi.png"),
                                width: 100.w,
                                height: 100.h,
                              ),
                              SizedBox(height: 10.h,),
                              Text(
                                message,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorManager.myWhite,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(height: 10.h,),
                              InkWell(
                                onTap: (){
                                  WeatherCubit.get(context).getCurrentWeather();
                                },
                                child: CircleAvatar(
                                  radius: 25.r,
                                  backgroundColor:ColorManager.containerColor ,
                                  child:Icon(
                                    Icons.refresh,
                                    color: ColorManager.myWhite,
                                    size: 28.h,
                                  ) ,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          else{
            return Scaffold(
              body: SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(8, 36,79, 1),
                          Color.fromRGBO(19, 76,181, 1),
                          Color.fromRGBO(11, 66,171, 1),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: const [0.15, 0.7,1],
                      )
                  ),
                  child:Column(
                    children: [
                     currentWeatherEntity != null? Column(
                        children: [
                          LocationWidget(location:currentWeatherEntity!.country),
                          CurrentWeatherWidget(
                            region:currentWeatherEntity!.region,
                            image: mapCondtionToImage(condition:currentWeatherEntity!.id),
                            temp:currentWeatherEntity!.temp,
                            contidion:currentWeatherEntity!.condition,
                          ),
                          Bar(
                              humidity: currentWeatherEntity!.humidity,
                              wind_kph: currentWeatherEntity!.wind_kph,
                              dewPoint_c: currentWeatherEntity!.dewPoint_c
                          )
                        ],
                      ) :const SizedBox(),
                      NextForecastWidget(list:forecast)
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
