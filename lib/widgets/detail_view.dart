import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/data/models/api/forecast.dart';
import 'package:weather_app/data/models/api/weather.dart';
import 'package:weather_app/providers/tempunit.dart';
import 'package:weather_app/utils/convertion.dart';
import 'package:weather_app/utils/mapping.dart';
import 'package:weather_app/utils/parallax_flow_delegate.dart';
import 'package:weather_app/widgets/daily_chart_view.dart';
import 'package:weather_app/widgets/hourly_chart_view.dart';

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
              _buildLocationView(
                  longitude: widget.weather.longitude,
                  latitude: widget.weather.latitude,
                  color: textColor),
              SizedBox(height: 5),
              _buildDatetimeView(
                  datetime: widget.weather.current.date, color: textColor),
              SizedBox(height: 32),
              _buildWeatherSummary(
                  condition: widget.weather.current.condition,
                  temp: widget.weather.current.temp,
                  isDayTime: true,
                  textColor: textColor),
              SizedBox(height: 48),
              _buildWeatherDescriptionView(
                  weatherDescription: widget.weather.current.description,
                  textColor: textColor),
              SizedBox(height: 32),
              HourlyChartView(hourlyWeather: widget.weather.hourly),
              SizedBox(height: 32),
              DailyChartView(
                  dailyForecast: widget.weather.daily, textColor: textColor),
              SizedBox(height: 40),
              _buildLastUpdatedView(
                timeUpdated: TimeOfDay.fromDateTime(widget.weather.lastUpdated)
                    .format(context),
                color: textColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildLocationView({
    required longitude,
    required latitude,
    required color,
  }) {
    var lon = longitude;
    var lat = latitude;
    var lonDisplay =
        '${lon.abs().toStringAsFixed(1)}\u1d52 ' + (lon >= 0 ? 'N' : 'S');
    var latDisplay =
        '${lat.abs().toStringAsFixed(1)}\u1d52 ' + (lat >= 0 ? 'W' : 'E');

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 10),
          Icon(
            Icons.location_on_sharp,
            color: color,
            size: 15,
          ),
          SizedBox(width: 5),
          Text(
            '$lonDisplay, $latDisplay',
            style: TextStyle(
              fontSize: 15,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  _buildDatetimeView({required datetime, color}) {
    String day = toBeginningOfSentenceCase(
            DateFormat('EEE, MMM d, y').format(datetime)) ??
        '__:__:__';

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 10),
          Icon(
            Icons.calendar_today,
            color: color,
            size: 15,
          ),
          SizedBox(width: 5),
          Text(
            day,
            style: TextStyle(
              fontSize: 15,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  _buildWeatherSummary(
      {required condition,
      required temp,
      required isDayTime,
      required textColor}) {
    IconData icon = Mapping.mapWeatherConditionToIcondata(condition, true);
    final unitSymbol = TempUnit.celsius;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Builder(builder: (_) {
            var t = temp;
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

  _buildWeatherDescriptionView(
      {required weatherDescription, required textColor}) {
    return Center(
      child: Text(
        weatherDescription,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w300,
          color: textColor,
        ),
      ),
    );
  }

  _buildLastUpdatedView({required timeUpdated, required color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.access_time,
            color: color,
            size: 15,
          ),
          SizedBox(width: 10),
          Text(
            'Last updated at $timeUpdated',
            style: TextStyle(
              fontSize: 16,
              color: color,
            ),
          )
        ],
      ),
    );
  }
}
