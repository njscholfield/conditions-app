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
    this.metadata,
    this.asOf,
    this.cloudCover,
    this.cloudCoverLowAltPct,
    this.cloudCoverMidAltPct,
    this.cloudCoverHighAltPct,
    this.conditionCode,
    this.daylight,
    this.humidity,
    this.precipitationIntensity,
    this.pressure,
    this.pressureTrend,
    this.temperature,
    this.temperatureApparent,
    this.temperatureDewPoint,
    this.uvIndex,
    this.visibility,
    this.windDirection,
    this.windGust,
    this.windSpeed,
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
