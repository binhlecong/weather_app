import 'package:flutter/material.dart';
import 'package:weather_app/api/weather_api.dart';
import 'package:weather_app/models/currentweatherapi/currentweather.dart';
import 'package:weather_app/views/currentweathertile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final currentWeather;
  @override
  void initState() {
    super.initState();
    currentWeather = WeatherAPI.fetchCurrentWeather('seattle');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(
          color: Colors.white,
          child: Text('Weather app'),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xd6d6d6),
        ),
        child: FutureBuilder<CurrentWeather>(
          future: currentWeather,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CurrentWeatherSummary(
                w: snapshot.data!,
              );
            } else if (snapshot.hasError) {
              return Text(
                "${snapshot.error}",
                style: TextStyle(color: Colors.red),
              );
            }
            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
