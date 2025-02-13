import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherai/core/error/failure.dart';
import 'package:weatherai/core/error/handelError.dart';
import 'package:weatherai/features/home/domain/entity/currentWeatherEntity.dart';
import 'package:weatherai/features/home/domain/entity/forecastEntity.dart';
import 'package:weatherai/features/home/domain/usecase/getCurrentWeatherUseCase.dart';
import 'package:weatherai/features/home/domain/usecase/getForecastWeatherUseCase.dart';
import 'package:weatherai/features/home/presentation/controller/states.dart';

class WeatherCubit extends Cubit<WeatherStates>{

  final GetCurrentWeatherUSeCase getCurrentWeatherUSeCase;
  final GetForecastWeatherUSeCase getForecastWeatherUSeCase;

  WeatherCubit({required this.getCurrentWeatherUSeCase,required this.getForecastWeatherUSeCase}):super(InitialWeatherState());

  static WeatherCubit get(context)=>BlocProvider.of(context);

  Future<void> getCurrentWeather()async{
    emit(LoadingGetCurrentWeather());
    final Either<Failure,CurrentWeatherEntity> currentWeatherResult = await getCurrentWeatherUSeCase.call();
    currentWeatherResult.fold((failure)=>emit(GetCurrentWeatherFail(message: MapFailureToMessage(failure))),(r){
      emit(GetCurrentWeatherSuccess(currentWeatherEntity: r));
      getForecastWeather();
    });
  }

  Future<void> getForecastWeather()async{
    emit(LoadingGetForecastWeather());
    final Either<Failure,List<ForecastEntity>> forecastResult = await getForecastWeatherUSeCase.call();
    forecastResult.fold((failure)=>emit(GetForecastWeatherFail(message: MapFailureToMessage(failure))),(r)=>emit(GetForecastWeatherSuccess(forecastList: r)));
  }
}