import 'package:flutter/material.dart';
import 'package:weather_app/data/models/api/weather.dart';
import 'package:weather_app/providers/tempunit.dart';
import 'package:weather_app/utils/mapping.dart';
import 'package:weather_app/utils/convertion.dart';

class WeatherSummary extends StatelessWidget {
  final WeatherCondition condition;
  final double temp;
  final bool isDayTime;
  final Color textColor;

  WeatherSummary({
    required this.condition,
    required this.temp,
    required this.isDayTime,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    IconData icon = Mapping.mapWeatherConditionToIcondata(condition, true);
    final unitSymbol = TempUnit.celsius;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Builder(builder: (_) {
            var t = this.temp;
            if (unitSymbol == TempUnit.celsius) {
              t = MyConvertion.kelvinToCelsius(temp);
            } else if (unitSymbol == TempUnit.fahrenheit) {
              t = MyConvertion.kelvinToFahrenheit(temp);
            }

            return Text(
              '${t.toStringAsFixed(0)} \u1d52$unitSymbol',
              style: TextStyle(
                fontSize: 64,
                color: textColor,
                fontWeight: FontWeight.w300,
              ),
            );
          }),
          SizedBox(
            height: 80,
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
}
