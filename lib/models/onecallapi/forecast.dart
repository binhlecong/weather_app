import 'package:weather_app/models/onecallapi/weather.dart';
import 'package:weather_app/utils/mapping.dart';

class Forecast {
  final DateTime lastUpdated;
  final double longitude;
  final double latitude;
  final List<DailyWeather> daily;
  final List<HourlyWeather> hourly;
  final DailyWeather current;
  final bool isDayTime;

  Forecast(
      {required this.lastUpdated,
      required this.longitude,
      required this.latitude,
      required this.daily,
      required this.hourly,
      required this.current,
      required this.isDayTime});

  static Forecast fromJson(dynamic json) {
    var weather = json['current']['weather'][0];
    var date = DateTime.fromMillisecondsSinceEpoch(json['current']['dt'] * 1000,
        isUtc: true);

    var sunrise = DateTime.fromMillisecondsSinceEpoch(
        json['current']['sunrise'] * 1000,
        isUtc: true);

    var sunset = DateTime.fromMillisecondsSinceEpoch(
        json['current']['sunset'] * 1000,
        isUtc: true);

    bool isDay = date.isAfter(sunrise) && date.isBefore(sunset);

    bool hasDaily = json['daily'] != null;
    List<DailyWeather> tempDaily = [];
    if (hasDaily) {
      List items = json['daily'];
      tempDaily = items
          .map((item) => DailyWeather.fromDailyJson(item))
          .toList()
          .skip(1)
          .take(7)
          .toList();
    }

    bool hasHourly = json['hourly'] != null;
    List<HourlyWeather> tempHourly = [];
    if (hasHourly) {
      List items = json['hourly'];
      tempHourly = items
          .map((item) => HourlyWeather.fromHourlyJson(item))
          .toList()
          .take(24)
          .toList();
    }

    var currentForecast = DailyWeather(
      cloudiness: int.parse(json['current']['clouds'].toString()),
      temp: json['current']['temp'].toDouble(),
      condition: Mapping.mapStringToWeatherCondition(weather['main']),
      description: weather['description'],
      feelLikeTemp: json['current']['feels_like'].toDouble(),
      date: date,
    );

    return Forecast(
      lastUpdated: DateTime.now(),
      current: currentForecast,
      latitude: json['lat'].toDouble(),
      longitude: json['lon'].toDouble(),
      daily: tempDaily,
      hourly: tempHourly,
      isDayTime: isDay,
    );
  }
}
