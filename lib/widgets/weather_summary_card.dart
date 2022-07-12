import 'package:flutter/material.dart';
import 'package:weather_app/data/models/api/current_weather.dart';
import 'package:weather_app/data/models/api/weather.dart';
import 'package:weather_app/providers/speedunit.dart';
import 'package:weather_app/providers/tempunit.dart';
import 'package:weather_app/screens/detail_page.dart';
import 'package:weather_app/utils/mapping.dart';
import 'package:weather_app/utils/convertion.dart';
import 'package:weather_app/widgets/wind_direction_arrow.dart';

class WeatherSummaryCard extends StatelessWidget {
  final CurrentWeather? weatherData;

  WeatherSummaryCard({this.weatherData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailPage.fromCoor(
              cityName: weatherData!.name,
              lat: weatherData!.lat,
              lon: weatherData!.lon,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          border: Border(
            top: BorderSide(
              width: 2,
              color: Theme.of(context).dividerColor,
            ),
            bottom: BorderSide(
              width: 2,
              color: Theme.of(context).dividerColor,
            ),
          ),
        ),
        height: 220,
        child: Builder(
          builder: (_) {
            if (weatherData != null) {
              WeatherCondition condition = Mapping.mapStringToWeatherCondition(
                  weatherData!.weather[0].main);
              IconData icon =
                  Mapping.mapWeatherConditionToIcondata(condition, true);
              Color textColor = Theme.of(context).hintColor;
              var windSpeed = weatherData!.wind.speed;
              var localCityName =
                  weatherData!.name + ', ' + weatherData!.sys.country;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    localCityName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                        child: Icon(
                          icon,
                          size: 32,
                          color: textColor,
                        ),
                      ),
                      SizedBox(width: 20),
                      Builder(
                        builder: (_) {
                          var minTemp = weatherData!.main.tempMin;
                          var maxTemp = weatherData!.main.tempMax;
                          var unitSymbol = TempUnit.celsius;

                          if (unitSymbol == TempUnit.celsius) {
                            minTemp = MyConvertion.kelvinToCelsius(minTemp);
                            maxTemp = MyConvertion.kelvinToCelsius(maxTemp);
                          } else if (unitSymbol == TempUnit.fahrenheit) {
                            minTemp = MyConvertion.kelvinToFahrenheit(minTemp);
                            maxTemp = MyConvertion.kelvinToFahrenheit(maxTemp);
                          }

                          return Text(
                            '${minTemp.toStringAsFixed(0)}' +
                                ' - ' +
                                '${maxTemp.toStringAsFixed(0)} \u1d52$unitSymbol',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        weatherData!.weather[0].description,
                        style: TextStyle(
                          fontSize: 20,
                          color: textColor,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Humidity: ${weatherData!.main.humidity}%' +
                            ' Pressure: ${weatherData!.main.pressure}hPa',
                        style: TextStyle(color: textColor),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      WindDisplayView(wind: weatherData!.wind),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Wind speed',
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          Builder(
                            builder: (_) {
                              var u = SpeedUnit.imperial;
                              var spd = windSpeed;

                              if (u == SpeedUnit.imperial) {
                                spd = MyConvertion.mpsToMiph(spd);
                              } else {
                                spd = MyConvertion.mpsToKmph(spd);
                              }

                              return Text(
                                '${spd.toStringAsFixed(2)} $u',
                                style: TextStyle(color: textColor),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Mapping.mapWindSpeedtoIconData(windSpeed),
                        color: textColor,
                        size: 32,
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.warning,
                    color: Colors.red,
                    size: 80,
                  ),
                  Text(
                    'Not available',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class WindDisplayView extends StatelessWidget {
  final Wind wind;

  WindDisplayView({required this.wind});
  WindDisplayView.fromSD(speed, degree) : wind = Wind(speed, degree);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      height: 40,
      width: 85,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(21),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WindDirectionArrow(
            wind.degree.toDouble(),
          ),
          Expanded(
            child: Center(
              child: Text(
                wind.degree.toStringAsFixed(0) + '\u1d52',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
