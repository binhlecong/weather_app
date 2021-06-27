import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/utils/temperatureconvert.dart';
import 'package:weather_icons/weather_icons.dart';

class DailySummaryView extends StatelessWidget {
  final Weather weather;

  DailySummaryView({Key key, @required this.weather})
      : assert(weather != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final dayOfWeek =
        toBeginningOfSentenceCase(DateFormat('EEE').format(this.weather.date));

    return Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text(dayOfWeek ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w300)),
              Text(
                  "${TemperatureConvert.kelvinToCelsius(this.weather.temp).round().toString()}°",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500)),
            ]),
            Padding(
                padding: EdgeInsets.only(left: 5),
                child: Container(
                    alignment: Alignment.center,
                    child: _mapWeatherConditionToIcon(this.weather.condition, true)))
          ],
        ));
  }

 Widget _mapWeatherConditionToIcon(
      WeatherCondition condition, bool isDayTime) {
    Icon icon;
    switch (condition) {
      case WeatherCondition.thunderstorm:
        icon = Icon(WeatherIcons.day_thunderstorm, size: 30);
        break;
      case WeatherCondition.heavyCloud:
        icon = Icon(WeatherIcons.cloudy, size: 30);
        break;
      case WeatherCondition.lightCloud:
        isDayTime
            ? icon = Icon(WeatherIcons.day_cloudy, size: 30)
            : icon = Icon(WeatherIcons.night_cloudy, size: 30);
        break;
      case WeatherCondition.drizzle:
      case WeatherCondition.mist:
        icon = Icon(WeatherIcons.fog, size: 30);
        break;
      case WeatherCondition.clear:
        isDayTime
            ? icon = Icon(WeatherIcons.day_sunny, size: 30)
            : icon = Icon(WeatherIcons.night_clear, size: 30);
        break;
      case WeatherCondition.fog:
        icon = Icon(WeatherIcons.fog, size: 30);
        break;
      case WeatherCondition.snow:
        icon = Icon(WeatherIcons.snow, size: 30);
        break;
      case WeatherCondition.rain:
        icon = Icon(WeatherIcons.rain, size: 30);
        break;
      case WeatherCondition.atmosphere:
        icon = Icon(WeatherIcons.day_sunny_overcast, size: 30);
        break;

      default:
        icon = Icon(Icons.question_answer_outlined, size: 30);
    }

    return Padding(padding: const EdgeInsets.only(top: 5), child: icon);
  }
}
