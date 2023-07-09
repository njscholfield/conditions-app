import "package:conditions/models/Metadata.dart";

class CurrentWeather {
  final Metadata metadata;
  final DateTime asOf;
  final double cloudCover;
  final double cloudCoverLowAltPct;
  final double cloudCoverMidAltPct;
  final double cloudCoverHighAltPct;
  final String conditionCode;
  final bool daylight;
  final double humidity;
  final double precipitationIntensity;
  final double pressure;
  final String pressureTrend;
  final double temperature;
  final double temperatureApparent;
  final double temperatureDewPoint;
  final int uvIndex;
  final double visibility;
  final int windDirection;
  final double windGust;
  final double windSpeed;

  CurrentWeather({
    required this.metadata,
    required this.asOf,
    required this.cloudCover,
    required this.cloudCoverLowAltPct,
    required this.cloudCoverMidAltPct,
    required this.cloudCoverHighAltPct,
    required this.conditionCode,
    required this.daylight,
    required this.humidity,
    required this.precipitationIntensity,
    required this.pressure,
    required this.pressureTrend,
    required this.temperature,
    required this.temperatureApparent,
    required this.temperatureDewPoint,
    required this.uvIndex,
    required this.visibility,
    required this.windDirection,
    required this.windGust,
    required this.windSpeed,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      metadata: Metadata.fromJson(json['metadata']),
      asOf: DateTime.parse(json['asOf']),
      cloudCover: json['cloudCover'].toDouble(),
      cloudCoverLowAltPct: json['cloudCoverLowAltPct'].toDouble(),
      cloudCoverMidAltPct: json['cloudCoverMidAltPct'].toDouble(),
      cloudCoverHighAltPct: json['cloudCoverHighAltPct'].toDouble(),
      conditionCode: json['conditionCode'],
      daylight: json['daylight'],
      humidity: json['humidity'].toDouble(),
      precipitationIntensity: json['precipitationIntensity'].toDouble(),
      pressure: json['pressure'].toDouble(),
      pressureTrend: json['pressureTrend'],
      temperature: json['temperature'].toDouble(),
      temperatureApparent: json['temperatureApparent'].toDouble(),
      temperatureDewPoint: json['temperatureDewPoint'].toDouble(),
      uvIndex: json['uvIndex'],
      visibility: json['visibility'].toDouble(),
      windDirection: json['windDirection'],
      windGust: json['windGust'].toDouble(),
      windSpeed: json['windSpeed'].toDouble(),
    );
  }
}
