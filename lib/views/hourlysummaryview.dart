import 'package:flutter/material.dart';
import 'package:weather_app/models/onecallapi/weather.dart';
import 'package:weather_app/utils/mapping.dart';

class HourlySummaryView extends StatelessWidget {
  final HourlyWeather weather;
  final Color textColor;

  HourlySummaryView({
    required this.weather,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: Colors.white30,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.all(10),
        child: Icon(
          Mapping.mapWeatherConditionToIcondata(this.weather.condition, true),
          color: textColor,
          size: 30,
        ),
      ),
    );
  }
}
