import 'package:dartz/dartz.dart';
import 'package:weatherai/core/error/failure.dart';
import 'package:weatherai/features/home/domain/entity/forecastEntity.dart';
import 'package:weatherai/features/home/domain/repo/repo.dart';

class GetForecastWeatherUSeCase {
  final WeatherRepo weatherRepo;

  GetForecastWeatherUSeCase({required this.weatherRepo});

  Future<Either<Failure,List<ForecastEntity>>>call()async{
    return await weatherRepo.getForecastWeather();
  }
}