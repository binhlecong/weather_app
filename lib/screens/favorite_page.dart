import 'package:flutter/material.dart';
import 'package:weather_app/data/database/favorite_location_db.dart';
import 'package:weather_app/data/models/database/favorite_location.dart';
import 'package:weather_app/widgets/crwth_tilelayout.dart';
import 'package:weather_app/widgets/current_weather_widget.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final ScrollController _scrollController = ScrollController();
  List<CurrentWeatherSummary> scrolledCities = [];
  late Future<List<FavoriteLocation>> favLocations;

  @override
  void initState() {
    super.initState();
    // load saved location from database
    favLocations = FavoriteLocationDB.db.getAllFavoriteLocations();
    favLocations.then((values) {
      for (FavoriteLocation value in values) {
        if (value.cityname == '_unknown_') {
          scrolledCities.add(
            CurrentWeatherSummary.fromLatLon(
              lat: value.latitude,
              lon: value.longitude,
            ),
          );
        } else {
          scrolledCities.add(
            CurrentWeatherSummary(cityName: value.cityname),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(
          color: Colors.white,
          child: Text('Favorite locations'),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Container(
        child: RefreshIndicator(
          onRefresh: _pullRefresh,
          child: FutureBuilder<List<FavoriteLocation>>(
            future: favLocations,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: scrolledCities.length,
                  itemBuilder: (context, index) => scrolledCities[index],
                );
              } else {
                Center(child: Text('Please enable device location'));
              }
              return CRWThTileLayout(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).dividerColor,
                      width: 2,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    scrolledCities.clear();
    super.dispose();
  }

  Future<void> _pullRefresh() async {
    scrolledCities = [];
    setState(() {});

    return Future.delayed(Duration(milliseconds: 100), () {
      favLocations.then((values) {
        for (FavoriteLocation value in values) {
          if (value.cityname == '_unknown_') {
            scrolledCities.add(
              CurrentWeatherSummary.fromLatLon(
                lat: value.latitude,
                lon: value.longitude,
              ),
            );
          } else {
            scrolledCities.add(
              CurrentWeatherSummary(cityName: value.cityname),
            );
          }
        }
      });

      setState(() {});
    });
  }
}
