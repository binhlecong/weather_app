import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/currentweather/currentweather.dart';
import 'package:weather_app/models/onecallapi/forecast.dart';
import 'package:weather_app/models/onecallapi/weather.dart';

class WeatherAPI {
  static final apikey = '618d67fe3ad2a8af158022fff834119c';

  static Future<CurrentWeather> fetchCurrentWeather(String cityName) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apikey'));

    if (response.statusCode == 200)
      return CurrentWeather.fromJson(jsonDecode(response.body));
    else
      throw Exception('Failed to get current weather data');
  }

    static Future<Forecast> fetchOneCallAPI(String lat, String lon) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=minutely&appid=$apikey'));

    if (response.statusCode == 200)
      return Forecast.fromJson(jsonDecode(response.body));
    else
      throw Exception('Failed to get one call api');
  }
}
