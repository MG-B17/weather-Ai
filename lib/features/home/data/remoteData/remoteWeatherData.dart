import 'package:weatherai/core/helpers/DioHelper/ApiStrings.dart';
import 'package:weatherai/core/helpers/DioHelper/dioHelper.dart';
import 'package:weatherai/core/helpers/loactionHelper/locationHelper.dart';
import 'package:weatherai/features/home/data/model/currentweatherModel.dart';
import 'package:weatherai/features/home/data/model/forecastModel/forecastmodel.dart';
import 'package:weatherai/features/home/domain/entity/currentWeatherEntity.dart';
import 'package:weatherai/features/home/domain/entity/forecastEntity.dart';

import '../../../../core/error/exception.dart';

abstract class BaseRemoteWeatherData {

  Future<CurrentWeatherEntity> getCurrentWeather ({required String location});

  Future<List<ForecastEntity>> getForeCastWeather ({required String location});
}

class RemoteWeatherData  extends BaseRemoteWeatherData{

  @override
  Future<CurrentWeatherEntity> getCurrentWeather({required String location})async {


    try{
      final response = await DioHelper.get(
          endPoint: ApiStrings.currentWeatherEndPoint,
          query: {
            "key":ApiStrings.apiKey,
            "q":location
          }
      );
      return currentWeatherModel.fromJson(response);
    }catch (e){
      print(e.toString());
      throw(ServerException);
    }
  }

  @override
  Future<List<ForecastEntity>> getForeCastWeather({required String location})async {

    final location = await LocationManager().determinePosition();

    try{
      final response = await DioHelper.get(
          endPoint: ApiStrings.forecastWeatherEndpoint,
          query: {
            "key":ApiStrings.apiKey,
            "q":location,
            "days":3,
            "hour":12
          }
      );
      return ForecastDay.fromJsonList(response["forecast"]["forecastday"]);
    }catch (e){
      print(e.toString());
      throw(ServerException);
    }
  }

}