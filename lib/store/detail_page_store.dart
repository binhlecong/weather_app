import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:weather_app/data/api/weather_api.dart';
import 'package:weather_app/data/models/api/forecast.dart';

part 'detail_page_store.g.dart';

class DetailPageStore = _DetailPageStore with _$DetailPageStore;

abstract class _DetailPageStore with Store {
  static ObservableFuture<Forecast?> emptyForecast =
      ObservableFuture.value(null);

  static String emptyCityName = '_unknown_';

  @observable
  String cityName = emptyCityName;

  @observable
  LatLng position = LatLng(0, 0);

  Forecast? forecast = null;

  @observable
  ObservableFuture<Forecast?> forecastFuture = emptyForecast;

  @computed
  bool get hasResult =>
      forecastFuture != emptyForecast &&
      forecastFuture.status == FutureStatus.fulfilled;

  @action
  void setCityName(String name) {
    cityName = name;
  }

  @action
  void setPosition(LatLng latLng) {
    position = latLng;
  }

  @action
  void setLatLng(double lat, double lng) {
    position = LatLng(lat, lng);
  }

  @action
  Future<void> fetchForecast() async {
    forecast = null;
    final future =
        WeatherAPI.fetchOneCallAPI(position.latitude, position.longitude);
    forecastFuture = ObservableFuture(future);
    forecast = await future;
  }
}
