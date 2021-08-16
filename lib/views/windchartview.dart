import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/onecallapi/weather.dart';
import 'package:weather_app/providers/speedunit.dart';
import 'package:weather_app/utils/myconvertion.dart';
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

  List<Widget> _itemsBuilder(List<HourlyWeather> data) {
    return data.map((e) {
      String timeStr = e.date.hour.toString() + ':00';

      return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 100,
              height: 140,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Center(
                      child: Consumer<SpeedUnitNotifier>(
                        builder: (context, unit, _) {
                          var u = unit.getSpeedUnit;
                          var spd = e.speed;

                          if (u == SpeedUnit.imperial) {
                            spd = MyConvertion.mpsToMiph(spd);
                          } else {
                            spd = MyConvertion.mpsToKmph(spd);
                          }

                          return Text(
                            '${spd.toStringAsFixed(2)} $u',
                            maxLines: 2,
                            softWrap: true,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          );
                        },
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
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
              child: Text(
                timeStr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
