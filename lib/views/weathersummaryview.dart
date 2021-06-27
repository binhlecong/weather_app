import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/utils/temperatureconvert.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherSummary extends StatelessWidget {
  final WeatherCondition condition;
  final double temp;
  final double feelsLike;
  final bool isdayTime;

  WeatherSummary(
      {Key key,
      @required this.condition,
      @required this.temp,
      @required this.feelsLike,
      @required this.isdayTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Column(
          children: [
            Text(
              '${_formatTemperature(this.temp)}°ᶜ',
              style: TextStyle(
                fontSize: 50,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              'Feels like ${_formatTemperature(this.feelsLike)}°ᶜ',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        _mapWeatherConditionToIcon(this.condition, this.isdayTime),
      ]),
    );
  }

  String _formatTemperature(double t) {
    var temp = (t == null
        ? ''
        : TemperatureConvert.kelvinToCelsius(t).round().toString());
    return temp;
  }

  Widget _mapWeatherConditionToIcon(
      WeatherCondition condition, bool isDayTime) {
    Icon icon;
    switch (condition) {
      case WeatherCondition.thunderstorm:
        icon = Icon(WeatherIcons.day_thunderstorm, size: 75);
        break;
      case WeatherCondition.heavyCloud:
        icon = Icon(WeatherIcons.cloudy, size: 75);
        break;
      case WeatherCondition.lightCloud:
        isdayTime
            ? icon = Icon(WeatherIcons.day_cloudy, size: 75)
            : icon = Icon(WeatherIcons.night_cloudy, size: 75);
        break;
      case WeatherCondition.drizzle:
      case WeatherCondition.mist:
        icon = Icon(WeatherIcons.fog, size: 75);
        break;
      case WeatherCondition.clear:
        isdayTime
            ? icon = Icon(WeatherIcons.day_sunny, size: 75)
            : icon = Icon(WeatherIcons.night_clear, size: 75);
        break;
      case WeatherCondition.fog:
        icon = Icon(WeatherIcons.fog, size: 75);
        break;
      case WeatherCondition.snow:
        icon = Icon(WeatherIcons.snow, size: 75);
        break;
      case WeatherCondition.rain:
        icon = Icon(WeatherIcons.rain, size: 75);
        break;
      case WeatherCondition.atmosphere:
        icon = Icon(WeatherIcons.day_sunny_overcast, size: 75);
        break;

      default:
        icon = Icon(Icons.question_answer_outlined, size: 75);
    }

    return Padding(padding: const EdgeInsets.only(top: 5), child: icon);
  }
}
