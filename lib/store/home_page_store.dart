import 'package:mobx/mobx.dart';
import 'package:weather_app/data/api/weather_api.dart';
import 'package:weather_app/data/models/api/current_weather.dart';

part 'home_page_store.g.dart';

final List<String> majorCities = [
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

class HomePageStore = _HomePageStore with _$HomePageStore;

abstract class _HomePageStore with Store {
  @observable
  CurrentWeather? userLocationWeather;

  @observable
  ObservableList<CurrentWeather?> majorCitiesWeather =
      ObservableList<CurrentWeather?>();

  @action
  Future<void> getUserLocationWeather() async {
    try {
      userLocationWeather = await WeatherAPI.fetchCurrentWeatherByCoor(1, 2);
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
