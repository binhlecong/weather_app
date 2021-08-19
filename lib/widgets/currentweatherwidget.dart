import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/api/weather_api.dart';

import 'package:weather_app/models/currentweatherapi/currentweather.dart';
import 'package:weather_app/models/onecallapi/weather.dart';
import 'package:weather_app/providers/speedunit.dart';
import 'package:weather_app/providers/tempunit.dart';
import 'package:weather_app/screens/detailpage.dart';
import 'package:weather_app/utils/mapping.dart';
import 'package:weather_app/utils/myconvertion.dart';
import 'package:weather_app/widgets/crwth_tilelayout.dart';
import 'package:weather_app/widgets/winddisplaywidget.dart';
import 'package:weather_icons/weather_icons.dart';

class CurrentWeatherSummary extends StatefulWidget {
  final String cityName;
  final double lat;
  final double lon;

  CurrentWeatherSummary({required this.cityName})
      : lat = 0,
        lon = 0;

  CurrentWeatherSummary.fromLatLon({required this.lat, required this.lon})
      : this.cityName = '_unknown_';

  @override
  State<CurrentWeatherSummary> createState() => _CurrentWeatherSummaryState();
}

class _CurrentWeatherSummaryState extends State<CurrentWeatherSummary> {
  late final Future<CurrentWeather> currentWeather;

  @override
  void initState() {
    super.initState();

    if (widget.cityName == '_unknown_') {
      currentWeather =
          WeatherAPI.fetchCurrentWeatherByCoor(widget.lat, widget.lon);
    } else {
      currentWeather = WeatherAPI.fetchCurrentWeather(widget.cityName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CurrentWeather>(
      future: currentWeather,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          WeatherCondition condition = Mapping.mapStringToWeatherCondition(
              snapshot.data!.weather[0].main);
          IconData icon =
              Mapping.mapWeatherConditionToIcondata(condition, true);
          Color textColor = Theme.of(context).hintColor;
          var windSpeed = snapshot.data!.wind.speed;

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage.fromCoor(
                    lat: snapshot.data!.lat,
                    lon: snapshot.data!.lon,
                  ),
                ),
              );
            },
            child: CRWThTileLayout(
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                border: Border(
                  top: BorderSide(
                    width: 2,
                    color: Theme.of(context).dividerColor,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    snapshot.data!.name + ', ' + snapshot.data!.sys.country,
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
                      Consumer<TempUnitNotifier>(
                        builder: (context, unit, _) {
                          var minTemp = snapshot.data!.main.tempMin;
                          var maxTemp = snapshot.data!.main.tempMax;
                          var unitSymbol = unit.getTempUnit;

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
                        snapshot.data!.weather[0].description,
                        style: TextStyle(
                          fontSize: 20,
                          color: textColor,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Humidity: ${snapshot.data!.main.humidity}%' +
                            ' Pressure: ${snapshot.data!.main.pressure}hPa',
                        style: TextStyle(color: textColor),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      WindDisplayView(wind: snapshot.data!.wind),
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
                          Consumer<SpeedUnitNotifier>(
                            builder: (context, unit, _) {
                              var u = unit.getSpeedUnit;
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
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return CRWThTileLayout(
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 2,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning,
                  color: Colors.red,
                  size: 80,
                ),
                Text(
                  '${snapshot.error}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }
        return CRWThTileLayout(
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 2,
              ),
            ),
          ),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
