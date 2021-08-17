import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/onecallapi/weather.dart';
import 'package:weather_app/providers/tempunit.dart';
import 'package:weather_app/utils/mapping.dart';
import 'package:weather_app/utils/myconvertion.dart';

class DailySummaryView extends StatelessWidget {
  final DailyWeather weather;
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
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Container(
        width: 130,
        decoration: BoxDecoration(
          color: Colors.white30,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dayOfWeek ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      color: textColor,
                      fontWeight: FontWeight.w300),
                ),
                Consumer<TempUnitNotifier>(builder: (context, unit, _) {
                  var t = this.weather.temp;
                  var unitSymbol = unit.getTempUnit;

                  if (unitSymbol == 'C') {
                    t = MyConvertion.kelvinToCelsius(t);
                  } else if (unit.getTempUnit == 'F') {
                    t = MyConvertion.kelvinToFahrenheit(t);
                  }

                  return Text(
                    "${t.toStringAsFixed(0)}\u1d52$unitSymbol",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: textColor,
                        fontWeight: FontWeight.w500),
                  );
                }),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 7),
              child: FittedBox(
                child: Icon(
                  Mapping.mapWeatherConditionToIcondata(
                      this.weather.condition, true),
                  color: textColor,
                  size: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
