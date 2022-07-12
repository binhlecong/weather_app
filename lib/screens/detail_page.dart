import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:weather_app/data/database/favorite_location_db.dart';
import 'package:weather_app/data/models/api/forecast.dart';
import 'package:weather_app/data/models/database/favorite_location.dart';
import 'package:weather_app/store/detail_page_store.dart';
import 'package:weather_app/widgets/detail_view.dart';
import 'package:weather_app/utils/snackbar.dart';

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
  late DetailPageStore _detailPageStore;

  @override
  void initState() {
    super.initState();
    _detailPageStore = DetailPageStore();

    var lat = widget.position.latitude;
    var lng = widget.position.longitude;
    var cityName = widget.cityName;

    _detailPageStore.setLatLng(lat, lng);
    _detailPageStore.setCityName(cityName);
    _detailPageStore.getForecast();
  }

  @override
  Widget build(BuildContext context) {
    var lat = widget.position.latitude;
    var lng = widget.position.longitude;
    var cityName = widget.cityName;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cityName == "_unknown_"
            ? "Detail weather"
            : widget.cityName.toUpperCase()),
        actions: [
          PopupMenuButton<Text>(
            padding: EdgeInsets.zero,
            itemBuilder: (context) => <PopupMenuEntry<Text>>[
              PopupMenuItem(
                onTap: () {
                  _addToFavorite(cityName, lat, lng);
                },
                padding: EdgeInsets.only(left: 20),
                child: _buildTextButton('Add to favorite'),
              ),
              PopupMenuItem(
                onTap: () {
                  _removeFromFavorite(lat, lng);
                },
                padding: EdgeInsets.only(left: 20),
                child: _buildTextButton('Remove from favorite'),
              ),
            ],
          )
        ],
      ),
      body: Center(
        child: Observer(
          builder: (_) {
            if (_detailPageStore.forecastFuture.status ==
                FutureStatus.pending) {
              return Center(child: CircularProgressIndicator());
            } else {
              return _detailPageStore.forecast == null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.warning,
                            color: Colors.red,
                            size: 80,
                          ),
                          Text(
                            '${_detailPageStore.forecastFuture.error}',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _pullRefresh,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: DetailView(weather: _detailPageStore.forecast!),
                      ),
                    );
            }
          },
        ),
      ),
    );
  }

  Future<void> _pullRefresh() async {
    _detailPageStore.getForecast();
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
    FavoriteLocationDB.db.deleteFavoriteLocation(
      FavoriteLocation.getId(lat, lon),
    );
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
