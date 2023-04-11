import 'dart:convert';
import 'dart:io';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:http/http.dart' as http;

import 'package:conditions/models/DailyForecast.dart';
import 'package:conditions/models/CurrentWeather.dart';

class WeatherKit {
  String token;

  WeatherKit({ bundleId, teamId, keyId, pem, expiresIn}) {
    this.token = generateJWT(bundleId: bundleId, teamId: teamId, keyId: keyId, pem: pem, expiresIn: expiresIn);
  }

  String generateJWT({
    String bundleId,
    String teamId,
    String keyId,
    String pem,
    Duration expiresIn,
  }) {
    final jwt = JWT(
      {
        'sub': bundleId,
      },
      issuer: teamId,
      header: {
        "typ": "JWT",
        'id': "$teamId.$bundleId",
        'alg': 'ES256',
        'kid': keyId,
      },
    );

    final token = jwt.sign(
      ECPrivateKey(
        pem,
      ),
      algorithm: JWTAlgorithm.ES256,
      expiresIn: expiresIn,
    );
    return token;
  }

  Future<WeatherKitData> fetchWeatherData({latitude, longitude, timezone}) async {
    String url = "https://weatherkit.apple.com/api/v1/weather/en/$latitude/$longitude?dataSets=currentWeather,forecastDaily,&timezone=$timezone";

    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.authorizationHeader: this.token},
    );

    final data = json.decode(response.body) as Map<String, dynamic>;

    return WeatherKitData.fromJson(data);
  }
}

class WeatherKitData {
  final CurrentWeather currentWeather;
  final DailyForecast forecastDaily;

  WeatherKitData({
    this.currentWeather,
    this.forecastDaily
  });

  factory WeatherKitData.fromJson(Map<String, dynamic> json) {
    return WeatherKitData(
      currentWeather: CurrentWeather.fromJson(json['currentWeather']),
      forecastDaily: DailyForecast.fromJson(json['forecastDaily'])
    );
  }
}