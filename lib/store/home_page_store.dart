import 'package:mobx/mobx.dart';
import 'package:weather_app/data/api/weather_api.dart';
import 'package:weather_app/data/models/api/current_weather.dart';

part 'home_page_store.g.dart';

class HomePageStore = _HomePageStore with _$HomePageStore;

abstract class _HomePageStore with Store {
  static final List<String> majorCities = [
    'hanoi',
    'seattle',
    'New York',
    'london',
    'paris',
    'hongkong',
    'sydney',
    'moscow',
    'berlin',
    'abu dhabi',
    'shanghai',
    'tokyo',
    'dubai',
  ];

  static ObservableFuture<CurrentWeather?> emptyFuture =
      ObservableFuture.value(null);

  static ObservableFuture<List<CurrentWeather?>> emptyFutureList =
      ObservableFuture.value([]);

  CurrentWeather? userLocationWeather = null;

  @observable
  ObservableFuture<CurrentWeather?> userLocationWeatherFuture = emptyFuture;

  List<CurrentWeather?> majorCitiesWeathers = [];

  @observable
  ObservableFuture<List<CurrentWeather?>> majorCitiesWeatherFutures =
      emptyFutureList;

  @computed
  bool get hasGetMajorCitiesWeatherCompleted =>
      majorCitiesWeatherFutures != emptyFutureList &&
      majorCitiesWeatherFutures.status == FutureStatus.fulfilled;

  @action
  Future<void> getUserLocationWeather() async {
    userLocationWeather = null;
    try {
      final future = WeatherAPI.fetchCurrentWeatherByCoor(0, 0);
      userLocationWeatherFuture = ObservableFuture(future);
      userLocationWeather = await future;
    } catch (e) {
      userLocationWeather = null;
    }
  }

  @action
  Future<void> getMajorCitiesWeather() async {
    majorCitiesWeatherFutures =
        ObservableFuture(fetchMultipleWeather(majorCities));
    majorCitiesWeathers = await majorCitiesWeatherFutures;
  }

  Future<List<CurrentWeather?>> fetchMultipleWeather(
      List<String> cityNames) async {
    List<CurrentWeather?> weathers = [];
    for (String city in majorCities) {
      var weather = null;
      try {
        weather = await WeatherAPI.fetchCurrentWeather(city);
      } catch (e) {
        weather = null;
      }
      weathers.add(weather);
    }
    return weathers;
  }
}
