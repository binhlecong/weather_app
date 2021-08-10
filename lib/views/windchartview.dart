import 'package:flutter/material.dart';
import 'package:weather_app/models/onecallapi/weather.dart';
import 'package:weather_app/views/winddirectionview.dart';

class WindChartView extends StatelessWidget {
  final List<HourlyWeather> data;
  WindChartView(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white38,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 20,
        ),
        child: Row(
          children: _itemsBuilder(data),
        ),
      ),
    );
  }

  _itemsBuilder(List<HourlyWeather> data) {
    return data.map((e) {
      String timeStr = e.date.hour.toString() + ':00';

      return Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 80,
              height: 140,
              padding: EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        '${e.speed.toStringAsFixed(1)} m/s',
                        maxLines: 2,
                        softWrap: true,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 45,
                    width: 45,
                    child: WindDirectionView(
                      e.degree.toDouble(),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        e.degree.toStringAsFixed(0) + '\u1d52',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Text(
              timeStr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
