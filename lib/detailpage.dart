import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/models/onecallapi/forecast.dart';
import 'package:weather_app/models/onecallapi/weather.dart';
import 'package:weather_app/views/detailview.dart';
import 'package:weather_app/api/weather_api.dart';

class DetailPage extends StatefulWidget {
  final LatLng position;

  DetailPage({required this.position});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late final Future<Forecast> weather;

  @override
  void initState() {
    super.initState();
    String lat = widget.position.latitude.toString();
    String lng = widget.position.longitude.toString();
    weather = WeatherAPI.fetchOneCallAPI(lat, lng);
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
              return DetailView(weather: snapshot.data!);
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
