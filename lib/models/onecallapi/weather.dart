import 'package:weather_app/utils/mapping.dart';

enum WeatherCondition {
  thunderstorm,
  drizzle,
  rain,
  snow,
  atmosphere, // dust, ash, fog, sand etc.
  mist,
  fog,
  cloudy,
  clear,
  unknown,
}

class DailyWeather {
  final WeatherCondition condition;
  final String description;
  final double temp;
  final double feelLikeTemp;
  final int cloudiness;
  final DateTime date;

  DailyWeather({
    required this.condition,
    required this.description,
    required this.temp,
    required this.feelLikeTemp,
    required this.cloudiness,
    required this.date,
  });

  static DailyWeather fromDailyJson(dynamic daily) {
    var cloudiness = daily['clouds'];
    var weather = daily['weather'][0];

    return DailyWeather(
        condition: Mapping.mapStringToWeatherCondition(weather['main']),
        description: weather['description'].toString(),
        cloudiness: cloudiness,
        temp: daily['temp']['day'].toDouble(),
        date: DateTime.fromMillisecondsSinceEpoch(daily['dt'] * 1000,
            isUtc: true),
        feelLikeTemp: daily['feels_like']['day'].toDouble());
  }
}

class HourlyWeather {
  final WeatherCondition condition;
  final String description;
  final double temp;
  final double feelLikeTemp;
  final int cloudiness;
  final DateTime date;

  HourlyWeather({
    required this.condition,
    required this.description,
    required this.temp,
    required this.feelLikeTemp,
    required this.cloudiness,
    required this.date,
  });

  static HourlyWeather fromDailyJson(dynamic daily) {
    var cloudiness = daily['clouds'];
    var weather = daily['weather'][0];

    return HourlyWeather(
        condition: Mapping.mapStringToWeatherCondition(weather['main']),
        description: weather['description'].toString(),
        cloudiness: cloudiness,
        temp: daily['temp'].toDouble(),
        date: DateTime.fromMillisecondsSinceEpoch(daily['dt'] * 1000,
            isUtc: true),
        feelLikeTemp: daily['feels_like'].toDouble());
  }
}
