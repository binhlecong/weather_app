import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/currentweatherapi/currentweather.dart';
import 'package:weather_app/views/winddirectionview.dart';

class WindDisplayView extends StatelessWidget {
  final Wind wind;
  WindDisplayView({required this.wind});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      height: 40,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          WindDirectionView(
            wind.degree.toDouble(),
          ),
          Text(
            wind.degree.toString() + '\u1d52',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
