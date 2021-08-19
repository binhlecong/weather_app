import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/currentweatherapi/currentweather.dart';
import 'package:weather_app/widgets/winddirectionwidget.dart';
import 'package:weather_icons/weather_icons.dart';

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
          WindDirectionView(
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
