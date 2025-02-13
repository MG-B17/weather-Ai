class CurrentWeatherEntity {

  final String region;

  final String country;

  final String temp;

  final String lastUpDate;

  final String condition;

  final int  id;

  final String wind_kph;

  final String humidity;

  final String dewPoint_c;

  CurrentWeatherEntity({
    required this.country,
    required this.lastUpDate,
    required this.region,
    required this.temp,
    required this.condition,
    required this.id,
    required this.dewPoint_c,
    required this.humidity,
    required this.wind_kph
  });
}