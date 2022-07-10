import 'package:mobx/mobx.dart';
import 'package:weather_app/data/api/weather_api.dart';
import 'package:weather_app/data/database/favorite_location_db.dart';
import 'package:weather_app/data/models/api/current_weather.dart';
import 'package:weather_app/data/models/database/favorite_location.dart';

part 'favorite_page_store.g.dart';

class FavoritePageStore = _FavoritePageStore with _$FavoritePageStore;

abstract class _FavoritePageStore with Store {
  @observable
  ObservableList<CurrentWeather?> favoriteCitiesWeather =
      ObservableList<CurrentWeather?>();

  @action
  Future<void> getFavoriteCitiesWeather() async {
    late Future<List<FavoriteLocation>> favLocations =
        FavoriteLocationDB.db.getAllFavoriteLocations();
    favLocations.then((values) async {
      for (FavoriteLocation value in values) {
        CurrentWeather? weather;
        if (value.cityname == '_unknown_') {
          try {
            weather = await WeatherAPI.fetchCurrentWeatherByCoor(
                value.latitude, value.longitude);
          } catch (e) {
            weather = null;
          }
        } else {
          try {
            weather = await WeatherAPI.fetchCurrentWeather(value.cityname);
          } catch (e) {
            weather = null;
          }
        }
        favoriteCitiesWeather.add(weather);
      }
    });
  }
}
