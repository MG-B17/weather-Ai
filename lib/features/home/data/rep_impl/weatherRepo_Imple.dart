import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherai/core/error/exception.dart';
import 'package:weatherai/core/error/failure.dart';
import 'package:weatherai/core/network/network_checker.dart';
import 'package:weatherai/features/home/data/remoteData/remoteWeatherData.dart';
import 'package:weatherai/features/home/domain/entity/currentWeatherEntity.dart';
import 'package:weatherai/features/home/domain/entity/forecastEntity.dart';
import 'package:weatherai/features/home/domain/repo/repo.dart';

import '../../../../core/helpers/loactionHelper/locationHelper.dart';

class CurrentWeatherImpel extends WeatherRepo{

  final BaseRemoteWeatherData baseRemoteWeatherData;

  final NetworkInfo networkInfo;

  CurrentWeatherImpel({required this.networkInfo,required this.baseRemoteWeatherData});

  @override
  Future<Either<Failure, CurrentWeatherEntity>> getCurrentWeather()async {
    if(await networkInfo.isConnected()){
      try{
        final Either<Failure,Position> location = await LocationManager().determinePosition();
        return await  location.fold((failure){
          return left(LocationDisabledFailure());
        }, (r)
        async{
          final  String latitude= r.latitude.toString();
          final  String longitude= r.latitude.toString();
          final response = await baseRemoteWeatherData.getCurrentWeather(location:"${latitude},${longitude}" );
          return right(response);
        });
      } on ServerException{
        return left(ServerFailure());
      }
    }else{
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure,List<ForecastEntity>>> getForecastWeather()async{
    if(await networkInfo.isConnected()){
    try{
      final Either<Failure,Position> location = await LocationManager().determinePosition();
      return await  location.fold((failure){
        return left(LocationDisabledFailure());
      }, (r)
      async{
        final  String latitude= r.latitude.toString();
        final  String longitude= r.latitude.toString();
        final response = await baseRemoteWeatherData.getForeCastWeather(location:"${latitude},${longitude}");
        return right(response);
      });
    } on ServerException{
    return left(ServerFailure());
    }
    }else{
    return left(OfflineFailure());
    }
  }
}