import 'package:conditions/models/Metadata.dart';

class DailyForecast {
  final Metadata metadata;
  final List<DayWeatherConditions> days;

  DailyForecast({
    this.metadata,
    this.days
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    var days = json['days'].map<DayWeatherConditions>((json) => DayWeatherConditions.fromJson(json)).toList();

    return DailyForecast(
      metadata: Metadata.fromJson(json['metadata']),
      days: days
    );
  }
}

class DayWeatherConditions {
  DateTime forecastStart;
  DateTime forecastEnd;
  String conditionCode;
  int maxUvIndex;
  String moonPhase;
  DateTime moonrise;
  DateTime moonset;
  double precipitationAmount;
  Map<String, double> precipitationAmountByType;
  double precipitationChance;
  String precipitationType;
  double snowfallAmount;
  DateTime solarMidnight;
  DateTime solarNoon;
  DateTime sunrise;
  DateTime sunriseCivil;
  DateTime sunriseNautical;
  DateTime sunriseAstronomical;
  DateTime sunset;
  DateTime sunsetCivil;
  DateTime sunsetNautical;
  DateTime sunsetAstronomical;
  double temperatureMax;
  double temperatureMin;
  DaypartForecast daytimeForecast;
  DaypartForecast overnightForecast;
  DaypartForecast restOfDayForecast;

  DayWeatherConditions({
    this.forecastStart,
    this.forecastEnd,
    this.conditionCode,
    this.maxUvIndex,
    this.moonPhase,
    this.moonrise,
    this.moonset,
    this.precipitationAmount,
    this.precipitationAmountByType,
    this.precipitationChance,
    this.precipitationType,
    this.snowfallAmount,
    this.solarMidnight,
    this.solarNoon,
    this.sunrise,
    this.sunriseCivil,
    this.sunriseNautical,
    this.sunriseAstronomical,
    this.sunset,
    this.sunsetCivil,
    this.sunsetNautical,
    this.sunsetAstronomical,
    this.temperatureMax,
    this.temperatureMin,
    this.daytimeForecast,
    this.overnightForecast,
    this.restOfDayForecast
  });

  factory DayWeatherConditions.fromJson(Map<String, dynamic> json) {
    return DayWeatherConditions(
      forecastStart: DateTime.parse(json['forecastStart']),
      forecastEnd: DateTime.parse(json['forecastEnd']),
      conditionCode: json['conditionCode'],
      maxUvIndex: json['maxUvIndex'],
      moonPhase: json['moonPhase'],
      moonrise: (json.containsKey('moonrise')) ? DateTime.parse(json['moonrise']) : null,
      moonset: (json.containsKey('moonset')) ? DateTime.parse(json['moonset']) : null,
      precipitationAmount: json['precipitationAmount'],
      precipitationAmountByType: Map<String, double>.from(json['precipitationAmountByType']),
      precipitationChance: json['precipitationChance'],
      precipitationType: json['precipitationType'],
      snowfallAmount: json['snowfallAmount'],
      solarMidnight: (json.containsKey('solarMidnight')) ? DateTime.parse(json['solarMidnight']) : null,
      solarNoon: (json.containsKey('solarNoon')) ? DateTime.parse(json['solarNoon']) : null,
      sunrise: (json.containsKey('sunrise')) ? DateTime.parse(json['sunrise']) : null,
      sunriseCivil: (json.containsKey('sunriseCivil')) ? DateTime.parse(json['sunriseCivil']) : null,
      sunriseNautical: (json.containsKey('sunriseNautical')) ? DateTime.parse(json['sunriseNautical']) : null,
      sunriseAstronomical: (json.containsKey('sunriseAstronomical')) ? DateTime.parse(json['sunriseAstronomical']) : null,
      sunset: (json.containsKey('sunset')) ? DateTime.parse(json['sunset']) : null,
      sunsetCivil: (json.containsKey('sunsetCivil')) ? DateTime.parse(json['sunsetCivil']) : null,
      sunsetNautical: (json.containsKey('sunsetNautical')) ? DateTime.parse(json['sunsetNautical']) : null,
      sunsetAstronomical: (json.containsKey('sunsetAstronomical')) ? DateTime.parse(json['sunsetAstronomical']) : null,
      temperatureMax: json['temperatureMax'],
      temperatureMin: json['temperatureMin'],
      daytimeForecast: DaypartForecast.fromJson(json['daytimeForecast']),
      overnightForecast: DaypartForecast.fromJson(json['overnightForecast']),
      restOfDayForecast: DaypartForecast.fromJson(json['restOfDayForecast'])
    );
  }
}

class DaypartForecast {
  DateTime forecastStart;
  DateTime forecastEnd;
  double cloudCover;
  String conditionCode;
  double humidity;
  double precipitationAmount;
  Map<String, double> precipitationAmountByType;
  double precipitationChance;
  String precipitationType;
  double snowfallAmount;
  int windDirection;
  double windSpeed;

  DaypartForecast({
    this.forecastStart,
    this.forecastEnd,
    this.cloudCover,
    this.conditionCode,
    this.humidity,
    this.precipitationAmount,
    this.precipitationAmountByType,
    this.precipitationChance,
    this.precipitationType,
    this.snowfallAmount,
    this.windDirection,
    this.windSpeed,
  });

  factory DaypartForecast.fromJson(Map<String, dynamic> json) {
    if(json == null) return DaypartForecast();

    return DaypartForecast(
      forecastStart: DateTime.parse(json['forecastStart']),
      forecastEnd: DateTime.parse(json['forecastEnd']),
      cloudCover: json['cloudCover'],
      conditionCode: json['conditionCode'],
      humidity: json['humidity'],
      precipitationAmount: json['precipitationAmount'],
      precipitationAmountByType: Map<String, double>.from(json['precipitationAmountByType']),
      precipitationChance: json['precipitationChance'],
      precipitationType: json['precipitationType'],
      snowfallAmount: json['snowfallAmount'],
      windDirection: json['windDirection'],
      windSpeed: json['windSpeed'],
    );
  }
}