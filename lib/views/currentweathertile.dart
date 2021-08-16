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
import 'package:weather_app/views/crwth_tilelayout.dart';
import 'package:weather_app/views/winddisplayview.dart';

class CurrentWeatherSummary extends StatefulWidget {
  final String cityName;
  CurrentWeatherSummary({required this.cityName});

  @override
  State<CurrentWeatherSummary> createState() => _CurrentWeatherSummaryState();
}

class _CurrentWeatherSummaryState extends State<CurrentWeatherSummary> {
  late final Future<CurrentWeather> currentWeather;

  @override
  void initState() {
    super.initState();
    currentWeather = WeatherAPI.fetchCurrentWeather(widget.cityName);
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
          int colorCode = Mapping.mapWeatherConditionToColor(condition);
          Color textColor = Mapping.mapWeatherConditionToTextColor(condition);

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
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 4),
                  ),
                ],
                color: Color(colorCode),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 18,
                      ),
                      SizedBox(width: 5),
                      Text(
                        snapshot.data!.name + ', ' + snapshot.data!.sys.country,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                        child: Icon(
                          icon,
                          color: textColor,
                          size: 32,
                        ),
                      ),
                      SizedBox(width: 10),
                      Consumer<TempUnitNotifier>(
                        builder: (context, unit, _) {
                          var minTemp = snapshot.data!.main.tempMin;
                          var maxTemp = snapshot.data!.main.tempMax;
                          var unitSymbol = unit.getTempUnit;

                          if (unitSymbol == 'C') {
                            minTemp = MyConvertion.kelvinToCelsius(minTemp);
                            maxTemp = MyConvertion.kelvinToCelsius(maxTemp);
                          } else if (unit.getTempUnit == 'F') {
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
                          color: textColor,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Humidity: ${snapshot.data!.main.humidity}%' +
                            ' Pressure: ${snapshot.data!.main.pressure}hPa',
                        style: TextStyle(color: textColor),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      WindDisplayView(wind: snapshot.data!.wind),
                      SizedBox(width: 7),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Wind speed:',
                            style: TextStyle(color: textColor),
                          ),
                          Consumer<SpeedUnitNotifier>(
                            builder: (context, unit, _) {
                              var u = unit.getSpeedUnit;
                              var spd = snapshot.data!.wind.speed;

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
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return CRWThTileLayout(
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
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
