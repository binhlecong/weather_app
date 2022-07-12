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

  static ObservableFuture<CurrentWeather?> emptyCurrentWeather =
      ObservableFuture.value(null);

  CurrentWeather? userLocationWeather = null;

  @observable
  ObservableFuture<CurrentWeather?> userLocationWeatherFuture =
      emptyCurrentWeather;

  @observable
  ObservableList<CurrentWeather?> majorCitiesWeather =
      ObservableList<CurrentWeather?>();

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
    for (String city in majorCities) {
      CurrentWeather? weather;
      try {
        weather = await WeatherAPI.fetchCurrentWeather(city);
      } catch (e) {
        weather = null;
      }
      majorCitiesWeather.add(weather);
    }
  }
}
