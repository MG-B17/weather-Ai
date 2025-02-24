import 'package:dartz/dartz.dart';
import 'package:weatherai/core/error/failure.dart';
import 'package:weatherai/features/home/domain/entity/currentWeatherEntity.dart';
import 'package:weatherai/features/home/domain/entity/forecastEntity.dart';

abstract class WeatherRepo {
  Future<Either<Failure, CurrentWeatherEntity>> getCurrentWeather();

  Future<Either<Failure,List<ForecastEntity>>> getForecastWeather();
}