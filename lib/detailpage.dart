import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/views/detailview.dart';
import 'package:weather_app/weather_api.dart';

class DetailPage extends StatefulWidget {
  final LatLng position;

  DetailPage({this.position});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Future<Forecast> weather;

  @override
  void initState() {
    super.initState();
    weather = WeatherAPI().apiCall(widget.position.latitude.toString(),
        widget.position.longitude.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail weather"),
      ),
      body: Center(
        child: FutureBuilder<Forecast>(
          future: weather,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return DetailView(weather: snapshot.data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}", style: TextStyle(color: Colors.red),);
            }
            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
