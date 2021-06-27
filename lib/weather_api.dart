import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/models/weather.dart';

class WeatherAPI {
  final apikey = '618d67fe3ad2a8af158022fff834119c';
  WeatherAPI();

  Future<Forecast> apiCall(String lat, String lon) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&appid=$apikey'));

    if (response.statusCode == 200)
      return Forecast.fromJson(jsonDecode(response.body));
    else
      throw Exception('Failed to get weather');
  }
}
