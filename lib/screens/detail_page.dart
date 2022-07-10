import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/data/database/favorite_location_db.dart';
import 'package:weather_app/data/models/api/forecast.dart';
import 'package:weather_app/data/models/database/favorite_location.dart';
import 'package:weather_app/views/detail_view.dart';
import 'package:weather_app/api/weather_api.dart';
import 'package:weather_app/widgets/snackbar.dart';

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
        title: Text(cityName == "_unknown_"
            ? "Detail weather"
            : cityName.toUpperCase()),
        actions: [
          PopupMenuButton<Text>(
            padding: EdgeInsets.zero,
            itemBuilder: (context) => <PopupMenuEntry<Text>>[
              PopupMenuItem(
                onTap: () {
                  _addToFavorite(cityName, lat, lon);
                },
                padding: EdgeInsets.only(left: 20),
                child: _buildTextButton('Add to favorite'),
              ),
              PopupMenuItem(
                onTap: () {
                  _removeFromFavorite(lat, lon);
                },
                padding: EdgeInsets.only(left: 20),
                child: _buildTextButton('Remove from favorite'),
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

    displaySnackbar(context, "Detail weather reloaded");
  }

  void _addToFavorite(cityName, lat, lon) {
    FavoriteLocationDB.db.newLocation(
      FavoriteLocation(
        cityname: cityName,
        latitude: lat,
        longitude: lon,
      ),
    );
  }

  void _removeFromFavorite(lat, lon) {
    FavoriteLocationDB.db
        .deleteFavoriteLocation(FavoriteLocation.getId(lat, lon));
  }

  Widget _buildTextButton(label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
