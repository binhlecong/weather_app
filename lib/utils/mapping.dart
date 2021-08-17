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
        condition = WeatherCondition.atmosphere;
        break;
      default:
        condition = WeatherCondition.unknown;
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

  static int mapWeatherConditionToColor(WeatherCondition condition) {
    switch (condition) {
      case WeatherCondition.thunderstorm:
        return 0xffb300b3;
      case WeatherCondition.cloudy:
        return 0xff808080;
      case WeatherCondition.drizzle:
      case WeatherCondition.mist:
        return 0xff00b300;
      case WeatherCondition.clear:
        return 0xff0080ff;
      case WeatherCondition.fog:
        return 0xffb5b5b5;
      case WeatherCondition.snow:
        return 0xfff0f0f0;
      case WeatherCondition.rain:
        return 0xff6082B6;
      case WeatherCondition.atmosphere:
        return 0xff1e90ff;
      default:
        return Colors.white.value;
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

  static Color mapWeatherConditionToTextColor(WeatherCondition condition) {
    Color color;
    switch (condition) {
      case WeatherCondition.thunderstorm:
      case WeatherCondition.cloudy:
      case WeatherCondition.drizzle:
      case WeatherCondition.mist:
      case WeatherCondition.clear:
        color = Colors.white;
        break;

      case WeatherCondition.fog:
      case WeatherCondition.snow:
      case WeatherCondition.rain:
      case WeatherCondition.atmosphere:
        color = Colors.black;
        break;

      default:
        color = Colors.white;
    }

    return color;
  }
}
