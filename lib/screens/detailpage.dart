import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/models/onecallapi/forecast.dart';
import 'package:weather_app/views/detailview.dart';
import 'package:weather_app/api/weather_api.dart';

class DetailPage extends StatefulWidget {
  final LatLng position;

  DetailPage({required this.position});
  DetailPage.fromCoor({lat = 0, lon = 0}) : position = LatLng(lat, lon);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<Forecast> weather;

  @override
  void initState() {
    super.initState();
    var lat = widget.position.latitude;
    var lon = widget.position.longitude;
    weather = WeatherAPI.fetchOneCallAPI(lat, lon);
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
              return RefreshIndicator(
                onRefresh: _pullRefresh,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: DetailView(weather: snapshot.data!),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.warning,
                      color: Colors.red,
                      size: 80,
                    ),
                    Text(
                      '${snapshot.error}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Future<void> _pullRefresh() async {
    var lat = widget.position.latitude;
    var lon = widget.position.longitude;
    Future<Forecast> newWeather = WeatherAPI.fetchOneCallAPI(lat, lon);

    setState(() {
      weather = newWeather;
    });
  }
}
