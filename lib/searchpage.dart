import 'package:flutter/material.dart';
import 'package:weather_app/api/weather_api.dart';
import 'package:weather_app/models/currentweather/currentweather.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final currentWeather;
    @override
  void initState() {
    super.initState();
    currentWeather = WeatherAPI.fetchCurrentWeather('london');
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<CurrentWeather>(
          future: currentWeather,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.name);
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
    );
  }
}
