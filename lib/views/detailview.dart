import 'package:flutter/material.dart';
import 'package:weather_app/models/onecallapi/forecast.dart';
import 'package:weather_app/models/onecallapi/weather.dart';
import 'package:weather_app/utils/mapping.dart';
import 'package:weather_app/utils/parallaxflowdelegate.dart';
import 'package:weather_app/widgets/dailysummwidget.dart';
import 'package:weather_app/views/datetimeview.dart';
import 'package:weather_app/views/hourlychartview.dart';
import 'package:weather_app/views/lastupdatedview.dart';
import 'package:weather_app/views/locationview.dart';
import 'package:weather_app/views/weatherdescriptionview.dart';
import 'package:weather_app/widgets/weathersummwidget.dart';

class DetailView extends StatefulWidget {
  final Forecast weather;

  DetailView({required this.weather});

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  final GlobalKey _backgroundImageKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WeatherCondition condition = widget.weather.current.condition;
    Color textColor = Mapping.mapWeatherConditionToTextColor(condition);
    String imagePath = Mapping.mapMainToBG(widget.weather.current.main);
    double viewHeight = MediaQuery.of(context).size.height + 150;

    return Container(
      height: viewHeight,
      child: Stack(
        children: [
          Flow(
            delegate: ParallaxFlowDelegate(
              scrollable: Scrollable.of(context)!,
              listItemContext: context,
              backgroundImageKey: _backgroundImageKey,
            ),
            children: [
              Image(
                height: viewHeight + 180,
                key: _backgroundImageKey,
                fit: BoxFit.cover,
                image: AssetImage(imagePath),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 20),
              LocationView(
                longitude: widget.weather.longitude,
                latitude: widget.weather.latitude,
                color: textColor,
              ),
              SizedBox(height: 5),
              DatetimeView(
                datetime: widget.weather.current.date,
                color: textColor,
              ),
              SizedBox(height: 32),
              WeatherSummary(
                condition: widget.weather.current.condition,
                temp: widget.weather.current.temp,
                isDayTime: true,
                textColor: textColor,
              ),
              SizedBox(height: 48),
              WeatherDescriptionView(
                weatherDescription: widget.weather.current.description,
                textColor: textColor,
              ),
              SizedBox(height: 32),
              HourlyChartView(hourlyWeather: widget.weather.hourly),
              SizedBox(height: 32),
              Expanded(
                child: Center(
                  child: _buildDailySummary(widget.weather.daily, textColor),
                ),
              ),
              SizedBox(height: 40),
              LastUpdatedView(
                lastUpdatedOn: widget.weather.lastUpdated,
                color: textColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDailySummary(List<DailyWeather> dailyForecast, Color textColor) {
    return SizedBox(
      height: 120,
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
}
