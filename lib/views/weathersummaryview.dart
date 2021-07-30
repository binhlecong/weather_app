import 'package:flutter/material.dart';
import 'package:weather_app/models/onecallapi/weather.dart';
import 'package:weather_app/utils/mapping.dart';
import 'package:weather_app/utils/temperatureconvert.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherSummary extends StatelessWidget {
  final WeatherCondition condition;
  final double temp;
  final double feelsLike;
  final bool isDayTime;

  WeatherSummary(
      {required this.condition,
      required this.temp,
      required this.feelsLike,
      required this.isDayTime});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${_formatTemperature(this.temp)}°ᶜ',
                  style: TextStyle(
                    fontSize: 70,
                    color:
                        Mapping.mapWeatherConditionToTextColor(this.condition),
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  'Feels like ${_formatTemperature(this.feelsLike)}°ᶜ',
                  style: TextStyle(
                    fontSize: 18,
                    color:
                        Mapping.mapWeatherConditionToTextColor(this.condition),
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            SizedBox(width: 30),
            FittedBox(
              child: Icon(
                Mapping.mapWeatherConditionToIcondata(
                    this.condition, this.isDayTime),
              ),
            ),
          ]),
    );
  }

  String _formatTemperature(double t) {
    var temp = TemperatureConvert.kelvinToCelsius(t).round().toString();
    return temp;
  }
}
