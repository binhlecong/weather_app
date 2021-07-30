import 'package:flutter/material.dart';
import 'package:weather_app/detailpage.dart';
import 'package:weather_app/models/currentweatherapi/currentweather.dart';
import 'package:weather_app/models/onecallapi/weather.dart';
import 'package:weather_app/utils/mapping.dart';
import 'package:weather_app/utils/temperatureconvert.dart';
import 'package:weather_app/views/winddisplayview.dart';

class CurrentWeatherSummary extends StatelessWidget {
  final CurrentWeather w;
  CurrentWeatherSummary({required this.w});
  @override
  Widget build(BuildContext context) {
    WeatherCondition condition =
        Mapping.mapStringToWeatherCondition(w.weather[0].main);
    IconData icon = Mapping.mapWeatherConditionToIcondata(condition, true);
    int colorCode = Mapping.mapWeatherConditionToColor(condition);
    Color textColor = Mapping.mapWeatherConditionToTextColor(condition);

    return Padding(
      padding: EdgeInsets.all(15),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage.fromCoor(lat: w.lat, lon: w.lon),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 10),
              ),
            ],
            color: Color(colorCode),
            borderRadius: BorderRadius.circular(20),
          ),
          height: 220,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 18,
                  ),
                  SizedBox(width: 5),
                  Text(
                    w.name + ', ' + w.sys.country,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(
                    height: 50,
                    child: Icon(
                      icon,
                      color: textColor,
                      size: 32,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '${TempConvert.kelvinToCelsius(w.main.tempMin)}' +
                        '\u1d52' +
                        ' - ' +
                        '${TempConvert.kelvinToCelsius(w.main.tempMax)}' +
                        '\u1d52',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ]),
                Column(children: [
                  Text(
                    w.weather[0].description,
                    style: TextStyle(color: textColor),
                  ),
                  Text(
                    'Humidity: ${w.main.humidity}% - Pressure: ${w.main.pressure}hPa',
                    style: TextStyle(color: textColor),
                  ),
                ]),
                Row(children: [
                  WindDisplayView(wind: w.wind),
                  SizedBox(width: 7),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Wind speed:',
                        style: TextStyle(color: textColor),
                      ),
                      Text(
                        '${w.wind.speed} m/s',
                        style: TextStyle(color: textColor),
                      ),
                    ],
                  )
                ]),
              ]),
        ),
      ),
    );
  }
}
