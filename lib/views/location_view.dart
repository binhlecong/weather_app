import 'package:flutter/material.dart';

class LocationView extends StatelessWidget {
  final double longitude;
  final double latitude;
  final color;

  LocationView({
    required this.longitude,
    required this.latitude,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    var lon = this.longitude;
    var lat = this.latitude;
    var lonDisplay =
        '${lon.abs().toStringAsFixed(1)}\u1d52 ' + (lon >= 0 ? 'N' : 'S');
    var latDisplay =
        '${lat.abs().toStringAsFixed(1)}\u1d52 ' + (lat >= 0 ? 'W' : 'E');

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 10),
          Icon(
            Icons.location_on_sharp,
            color: color,
            size: 15,
          ),
          SizedBox(width: 5),
          Text(
            '$lonDisplay, $latDisplay',
            style: TextStyle(
              fontSize: 15,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
