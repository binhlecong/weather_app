import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/onecallapi/weather.dart';
import 'package:weather_app/providers/tempunit.dart';
import 'package:weather_app/utils/mapping.dart';
import 'package:weather_app/utils/myconvertion.dart';

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
          Consumer<TempUnitNotifier>(
            builder: (context, unit, _) {
              var t = this.temp;
              var feelLikeTemp = this.feelsLike;
              var unitSymbol = unit.getTempUnit;

              if (unitSymbol == 'C') {
                t = MyConvertion.kelvinToCelsius(temp);
                feelLikeTemp = MyConvertion.kelvinToCelsius(feelLikeTemp);
              } else if (unit.getTempUnit == 'F') {
                t = MyConvertion.kelvinToFahrenheit(temp);
                feelLikeTemp = MyConvertion.kelvinToFahrenheit(feelLikeTemp);
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${t.toStringAsFixed(0)} \u1d52$unitSymbol',
                    style: TextStyle(
                      fontSize: 64,
                      color: textColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Feels like ${feelLikeTemp.toStringAsFixed(0)} \u1d52$unitSymbol',
                    style: TextStyle(
                      fontSize: 24,
                      color: textColor,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(width: 15),
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
