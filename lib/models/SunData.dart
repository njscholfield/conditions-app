import 'package:intl/intl.dart';

class SunData {
  final String sunrise;
  final String sunset;
  final String solarNoon;
  final String dayLength;
  final String civilTwilightBegin;
  final String civilTwilightEnd;
  final String nauticalTwilightBegin;
  final String nauticalTwilightEnd;
  final String astroTwilightBegin;
  final String astroTwilightEnd;

  SunData(
    {required this.sunrise,
    required this.sunset,
    required this.solarNoon,
    required this.dayLength,
    required this.civilTwilightBegin,
    required this.civilTwilightEnd,
    required this.nauticalTwilightBegin,
    required this.nauticalTwilightEnd,
    required this.astroTwilightBegin,
    required this.astroTwilightEnd
  });

  factory SunData.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> results = json['results'];

    String formatTime(String dateString) {
      return new DateFormat.jm().format(DateTime.parse(dateString).toLocal());
    }

    String formatDuration(int dayLen) {
      Duration duration = new Duration(seconds: dayLen);
      return duration.toString().split('.')[0];
    }

    return new SunData(
      sunrise: formatTime(results['sunrise']),
      sunset: formatTime(results['sunset']),
      solarNoon: formatTime(results['solar_noon']),
      dayLength: formatDuration(results['day_length']),
      civilTwilightBegin: formatTime(results['civil_twilight_begin']),
      civilTwilightEnd: formatTime(results['civil_twilight_end']),
      nauticalTwilightBegin: formatTime(results['nautical_twilight_begin']),
      nauticalTwilightEnd: formatTime(results['nautical_twilight_end']),
      astroTwilightBegin: formatTime(results['astronomical_twilight_begin']),
      astroTwilightEnd: formatTime(results['astronomical_twilight_end'])
    );
  }
}