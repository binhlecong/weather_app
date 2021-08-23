import 'package:flutter/material.dart';
import 'package:weather_app/models/onecallapi/weather.dart';
import 'package:weather_icons/weather_icons.dart';

class Mapping {
  static WeatherCondition mapStringToWeatherCondition(String input) {
    WeatherCondition condition;
    switch (input) {
      case 'Thunderstorm':
        condition = WeatherCondition.thunderstorm;
        break;
      case 'Drizzle':
        condition = WeatherCondition.drizzle;
        break;
      case 'Rain':
        condition = WeatherCondition.rain;
        break;
      case 'Snow':
        condition = WeatherCondition.snow;
        break;
      case 'Clear':
        condition = WeatherCondition.clear;
        break;
      case 'Clouds':
        condition = WeatherCondition.cloudy;

        break;
      case 'Mist':
        condition = WeatherCondition.mist;
        break;
      case 'Fog':
        condition = WeatherCondition.fog;
        break;
      case 'Smoke':
      case 'Haze':
      case 'Dust':
      case 'Sand':
      case 'Ash':
      case 'Squall':
      case 'Tornado':
      default:
        condition = WeatherCondition.atmosphere;
        break;
    }

    return condition;
  }

  static IconData mapWeatherConditionToIcondata(
      WeatherCondition condition, bool isDayTime) {
    switch (condition) {
      case WeatherCondition.thunderstorm:
        return WeatherIcons.day_thunderstorm;
      case WeatherCondition.cloudy:
        return WeatherIcons.cloudy;

      case WeatherCondition.drizzle:
      case WeatherCondition.mist:
        return WeatherIcons.fog;
      case WeatherCondition.clear:
        return (isDayTime ? WeatherIcons.day_sunny : WeatherIcons.night_clear);

      case WeatherCondition.fog:
        return WeatherIcons.fog;
      case WeatherCondition.snow:
        return WeatherIcons.snow;
      case WeatherCondition.rain:
        return WeatherIcons.rain;
      case WeatherCondition.atmosphere:
        return WeatherIcons.day_sunny_overcast;

      default:
        return Icons.question_answer_outlined;
    }
  }

  static String mapWeatherConditionToBg(WeatherCondition condition) {
    switch (condition) {
      case WeatherCondition.thunderstorm:
        return 'assets/images/weather_conditions/thunderstorm.jpg';
      case WeatherCondition.cloudy:
        return 'assets/images/weather_conditions/cloudy.jpg';
      case WeatherCondition.drizzle:
        return 'assets/images/weather_conditions/drizzle.jpg';
      case WeatherCondition.mist:
        return 'assets/images/weather_conditions/mist.jpg';
      case WeatherCondition.clear:
        return 'assets/images/weather_conditions/clear.jpg';
      case WeatherCondition.fog:
        return 'assets/images/weather_conditions/fog.jpg';
      case WeatherCondition.snow:
        return 'assets/images/weather_conditions/snow.jpg';
      case WeatherCondition.rain:
        return 'assets/images/weather_conditions/rain.jpg';
      case WeatherCondition.atmosphere:
        return 'assets/images/weather_conditions/atmosphere.jpg';
      default:
        return 'assets/images/weather_conditions/unknown.jpg';
    }
  }

  static String mapMainToBG(String main) {
    switch (main) {
      case 'Thunderstorm':
        return 'assets/images/weather_conditions/thunderstorm.jpg';
      case 'Drizzle':
        return 'assets/images/weather_conditions/drizzle.jpg';
      case 'Rain':
        return 'assets/images/weather_conditions/rain.jpg';
      case 'Snow':
        return 'assets/images/weather_conditions/snow.jpg';
      case 'Clear':
        return 'assets/images/weather_conditions/clear.jpg';
      case 'Clouds':
        return 'assets/images/weather_conditions/cloudy.jpg';
      case 'Mist':
        return 'assets/images/weather_conditions/mist.jpg';
      case 'Fog':
        return 'assets/images/weather_conditions/fog.jpg';
      case 'Smoke':
        return 'assets/images/weather_conditions/smoke.jpg';
      case 'Haze':
        return 'assets/images/weather_conditions/haze.jpg';
      case 'Dust':
        return 'assets/images/weather_conditions/dust.jpg';
      case 'Sand':
        return 'assets/images/weather_conditions/sand.jpg';
      case 'Ash':
        return 'assets/images/weather_conditions/ash.jpg';
      case 'Squall':
        return 'assets/images/weather_conditions/squall.jpg';
      case 'Tornado':
        return 'assets/images/weather_conditions/tornado.jpg';
      default:
        return 'assets/images/weather_conditions/clear.jpg';
    }
  }

  static Color mapWeatherConditionToTextColor(WeatherCondition condition) {
    Color color;
    switch (condition) {
      case WeatherCondition.thunderstorm:
      case WeatherCondition.cloudy:
      case WeatherCondition.drizzle:
      case WeatherCondition.clear:
      case WeatherCondition.rain:
        color = Colors.white;
        break;

      case WeatherCondition.fog:
      case WeatherCondition.snow:
      case WeatherCondition.mist:
      case WeatherCondition.atmosphere:
        color = Colors.black;
        break;

      default:
        color = Colors.white;
    }

    return color;
  }

  static IconData mapWindSpeedtoIconData(speed) {
    if (speed < 0.5)
      return WeatherIcons.wind_beaufort_0;
    else if (speed < 1.6)
      return WeatherIcons.wind_beaufort_1;
    else if (speed < 3.4)
      return WeatherIcons.wind_beaufort_2;
    else if (speed < 5.6)
      return WeatherIcons.wind_beaufort_3;
    else if (speed < 8)
      return WeatherIcons.wind_beaufort_4;
    else if (speed < 10.8)
      return WeatherIcons.wind_beaufort_5;
    else if (speed < 13.9)
      return WeatherIcons.wind_beaufort_6;
    else if (speed < 17.2)
      return WeatherIcons.wind_beaufort_7;
    else if (speed < 20.8)
      return WeatherIcons.wind_beaufort_8;
    else if (speed < 24.5)
      return WeatherIcons.wind_beaufort_9;
    else if (speed < 28.5)
      return WeatherIcons.wind_beaufort_10;
    else if (speed < 32.7) return WeatherIcons.wind_beaufort_11;
    return WeatherIcons.wind_beaufort_12;
  }
}
