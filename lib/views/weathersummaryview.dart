import 'package:flutter/material.dart';
import 'package:weather_app/models/onecallapi/weather.dart';
import 'package:weather_app/utils/mapping.dart';
import 'package:weather_app/utils/temperatureconvert.dart';

class WeatherSummary extends StatelessWidget {
  final WeatherCondition condition;
  final double temp;
  final double feelsLike;
  final bool isDayTime;
  final Color textColor;

  WeatherSummary({
    required this.condition,
    required this.temp,
    required this.feelsLike,
    required this.isDayTime,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    IconData icon = Mapping.mapWeatherConditionToIcondata(condition, true);

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
                  fontSize: 90,
                  color: textColor,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                'Feels like ${_formatTemperature(this.feelsLike)}°ᶜ',
                style: TextStyle(
                  fontSize: 24,
                  color: textColor,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          SizedBox(width: 15),
          SizedBox(
            height: 95,
            child: FittedBox(
              child: Icon(
                icon,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTemperature(double t) {
    var temp = TempConvert.kelvinToCelsius(t).round().toString();
    return temp;
  }
}
