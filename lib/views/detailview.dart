import 'package:flutter/material.dart';
import 'package:weather_app/models/onecallapi/forecast.dart';
import 'package:weather_app/models/onecallapi/weather.dart';
import 'package:weather_app/utils/mapping.dart';

import 'package:weather_app/views/dailysummaryview.dart';
import 'package:weather_app/views/hourlysummaryview.dart';
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
    WeatherCondition condition = widget.weather.current.condition;

    int colorCode = Mapping.mapWeatherConditionToColor(condition);
    Color textColor = Mapping.mapWeatherConditionToTextColor(condition);

    return Container(
      padding: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Color(colorCode),
      ),
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
            isDayTime: true,
            textColor: textColor,
          ),
          SizedBox(height: 20),
          WeatherDescriptionView(
            weatherDescription: widget.weather.current.description,
            textColor: textColor,
          ),
          SizedBox(height: 100),
          buildDailySummary(widget.weather.daily, textColor),
          SizedBox(height: 20),
          buildHourlySummary(widget.weather.hourly, textColor),
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

  Widget buildDailySummary(List<DailyWeather> dailyForecast, Color textColor) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dailyForecast.length,
        itemBuilder: (context, index) {
          return DailySummaryView(
            weather: dailyForecast[index],
            textColor: textColor,
          );
        },
      ),
    );
  }

  buildHourlySummary(List<HourlyWeather> hourlyForecast, Color textColor) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hourlyForecast.length,
        itemBuilder: (context, index) {
          return HourlySummaryView(
            weather: hourlyForecast[index],
            textColor: textColor,
          );
        },
      ),
    );
  }
}
