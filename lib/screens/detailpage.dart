import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/models/database/favoritelocation.dart';
import 'package:weather_app/models/onecallapi/forecast.dart';
import 'package:weather_app/utils/database/favoritelocation_db.dart';
import 'package:weather_app/views/detailview.dart';
import 'package:weather_app/api/weather_api.dart';

class DetailPage extends StatefulWidget {
  final String cityName;
  final LatLng position;

  DetailPage({
    this.cityName = '_unknown_',
    required this.position,
  });

  DetailPage.fromCoor({
    this.cityName = '_unknown_',
    required lat,
    required lon,
  }) : position = LatLng(lat, lon);

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
    var cityName = widget.cityName;
    var lat = widget.position.latitude;
    var lon = widget.position.longitude;

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail weather"),
        actions: [
          PopupMenuButton<Text>(
            itemBuilder: (context) => <PopupMenuEntry<Text>>[
              PopupMenuItem(
                onTap: () {
                  // add to favorite.db
                  FavoriteLocationDB.db.newLocation(
                    FavoriteLocation(
                      cityname: cityName,
                      latitude: lat,
                      longitude: lon,
                    ),
                  );
                },
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Add to favorite',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          )
        ],
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
