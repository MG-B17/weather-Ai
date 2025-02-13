import 'package:weatherai/features/home/domain/entity/currentWeatherEntity.dart';

import 'currentsubModel.dart';
import 'locationSubModel.dart';

class currentWeatherModel extends CurrentWeatherEntity{

  Location location;
  Current current;

  currentWeatherModel({required this.location, required this.current}):super(
      country:location.country ,
      lastUpDate:current.lastUpdated,
      region:location.region,
      temp:current.tempC.toString(),
      condition: current.condition.text,
    id: current.condition.code,
    humidity:current.humidity.toString(),
    dewPoint_c:current.dewpointC.toString(),
    wind_kph:current.windKph.toString(),
  );

  factory currentWeatherModel.fromJson(Map<String, dynamic> json) {
    return currentWeatherModel(
      location: Location.fromJson(json['location']),
      current: Current.fromJson(json['current']),
    );
  }

}