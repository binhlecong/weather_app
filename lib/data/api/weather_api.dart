import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/data/models/api/current_weather.dart';
import 'package:weather_app/data/models/api/forecast.dart';

class WeatherAPI {
  static final _apikey = '618d67fe3ad2a8af158022fff834119c';

  static Future<CurrentWeather> fetchCurrentWeather(String cityName) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$_apikey'));

    if (response.statusCode == 200)
      return CurrentWeather.fromJson(jsonDecode(response.body));
    else
      throw Exception('Failed to get current weather data');
  }

  static Future<CurrentWeather> fetchCurrentWeatherByCoor(
    double lat,
    double lon,
  ) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$_apikey'));

    if (response.statusCode == 200)
      return CurrentWeather.fromJson(jsonDecode(response.body));
    else
      throw Exception('Failed to get current weather data');
  }

  static Future<Forecast> fetchOneCallAPI(
    double lat,
    double lon,
  ) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=minutely&appid=$_apikey'));

    if (response.statusCode == 200)
      return Forecast.fromJson(jsonDecode(response.body));
    else
      throw Exception('Failed to get one call api');
  }

  static Future<Forecast> fetchInCircle(
    double lat,
    double lon,
    int cnt,
  ) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&cnt=$cnt&appid=$_apikey'));

    if (response.statusCode == 200)
      return Forecast.fromJson(jsonDecode(response.body));
    else
      throw Exception('Failed to get one call api');
  }
}
