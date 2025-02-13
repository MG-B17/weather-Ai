import 'package:dartz/dartz.dart';
import 'package:weatherai/core/error/failure.dart';
import 'package:weatherai/features/home/domain/entity/currentWeatherEntity.dart';
import '../repo/repo.dart';

class GetCurrentWeatherUSeCase {

  final WeatherRepo weatherRepo;

  GetCurrentWeatherUSeCase({required this.weatherRepo});


  Future<Either<Failure,CurrentWeatherEntity>> call()async{
    return await weatherRepo.getCurrentWeather();
  }

}