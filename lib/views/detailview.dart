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

  DetailView({this.weather});

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  void initState() {
    super.initState();

    onStart();
  }

  Future<void> onStart() async {
    // any init in here ?
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(color: Colors.orange),
      child: Column(
        children: [
          LocationView(
            longitude: widget.weather.longitude,
            latitude: widget.weather.latitude,
          ),
          SizedBox(height: 50),
          WeatherSummary(
              condition: widget.weather.current.condition,
              temp: widget.weather.current.temp,
              feelsLike: widget.weather.current.feelLikeTemp,
              isdayTime: true),
          SizedBox(height: 20),
          WeatherDescriptionView(
              weatherDescription: widget.weather.current.description),
          SizedBox(height: 140),
          buildDailySummary(widget.weather.daily),
          LastUpdatedView(lastUpdatedOn: widget.weather.lastUpdated),
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
}
