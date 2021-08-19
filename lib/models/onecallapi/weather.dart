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
  final String main;
  final String description;
  final double temp;
  final double feelLikeTemp;
  final int cloudiness;
  final DateTime date;

  DailyWeather({
    required this.condition,
    required this.main,
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
        main: weather['main'],
        description: weather['description'].toString(),
        cloudiness: cloudiness,
        temp: daily['temp']['day'].toDouble(),
        date: DateTime.fromMillisecondsSinceEpoch(
          daily['dt'] * 1000,
          isUtc: true,
        ),
        feelLikeTemp: daily['feels_like']['day'].toDouble());
  }
}

class HourlyWeather {
  final WeatherCondition condition;
  final double temp;
  final double uvi;
  final DateTime date;
  final speed;
  final degree;

  HourlyWeather({
    required this.condition,
    required this.temp,
    required this.uvi,
    required this.date,
    required this.speed,
    required this.degree,
  });

  static HourlyWeather fromHourlyJson(dynamic hourly) {
    var weather = hourly['weather'][0];

    return HourlyWeather(
      condition: Mapping.mapStringToWeatherCondition(weather['main']),
      uvi: hourly['uvi'].toDouble(),
      temp: hourly['temp'].toDouble(),
      date: DateTime.fromMillisecondsSinceEpoch(
        hourly['dt'] * 1000,
        isUtc: true,
      ),
      speed: hourly['wind_speed'],
      degree: hourly['wind_deg'],
    );
  }
}
