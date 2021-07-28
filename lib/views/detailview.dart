import 'package:flutter/material.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/models/weather.dart';

import 'package:weather_app/views/dailysummaryview.dart';
import 'package:weather_app/views/lastupdatedview.dart';
import 'package:weather_app/views/locationview.dart';

import 'package:weather_app/views/weatherdescriptionview.dart';
import 'package:weather_app/views/weathersummaryview.dart';

class DetailView extends StatefulWidget {
  final Forecast weather;

  DetailView({required this.weather});

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(color: Colors.orangeAccent),
      child: Column(
        children: [
          LocationView(
            longitude: widget.weather.longitude,
            latitude: widget.weather.latitude,
          ),
          SizedBox(height: 100),
          WeatherSummary(
              condition: widget.weather.current.condition,
              temp: widget.weather.current.temp,
              feelsLike: widget.weather.current.feelLikeTemp,
              isDayTime: true),
          SizedBox(height: 20),
          WeatherDescriptionView(
              weatherDescription: widget.weather.current.description),
          SizedBox(height: 100),
          buildDailySummary(widget.weather.daily),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: LastUpdatedView(lastUpdatedOn: widget.weather.lastUpdated),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDailySummary(List<Weather> dailyForecast) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: dailyForecast
            .map((item) => new DailySummaryView(
                  weather: item,
                ))
            .toList());
  }

  Color _mapWeatherConditionToColor(WeatherCondition condition) {
    int code;
    switch (condition) {
      case WeatherCondition.thunderstorm:
        code = 0xb300b3;
        break;
      case WeatherCondition.heavyCloud:
        code = 0x808080;
        break;
      case WeatherCondition.lightCloud:
        code = 0xa6a6a6;
        break;
      case WeatherCondition.drizzle:
      case WeatherCondition.mist:
        code = 0x00b300;
        break;
      case WeatherCondition.clear:
        code = 0x0080ff;
        break;
      case WeatherCondition.fog:
        code = 0xb5b5b5;
        break;
      case WeatherCondition.snow:
        code = 0xf0f0f0;
        break;
      case WeatherCondition.rain:
        code = 0x1e90ff;
        break;
      case WeatherCondition.atmosphere:
        code = 0x1e90ff;
        break;

      default:
        code = Colors.orangeAccent.value;
    }

    return Color(code);
  }
}
