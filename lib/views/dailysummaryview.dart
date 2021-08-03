import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/onecallapi/weather.dart';
import 'package:weather_app/utils/mapping.dart';
import 'package:weather_app/utils/temperatureconvert.dart';
import 'package:weather_icons/weather_icons.dart';

class DailySummaryView extends StatelessWidget {
  final Weather weather;
  final Color textColor;

  DailySummaryView({
    required this.weather,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final dayOfWeek =
        toBeginningOfSentenceCase(DateFormat('EEE').format(this.weather.date));

    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              dayOfWeek ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18, color: textColor, fontWeight: FontWeight.w300),
            ),
            Text(
              "${TempConvert.kelvinToCelsius(this.weather.temp).round().toString()}°",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20, color: textColor, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 7),
          child: Container(
            height: 30,
            alignment: Alignment.center,
            child: FittedBox(
              child: Icon(
                Mapping.mapWeatherConditionToIcondata(
                    this.weather.condition, true),
                color: textColor,
              ),
            ),
          ),
        )
      ],),
    );
  }
}
