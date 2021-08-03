import 'package:flutter/material.dart';

class LocationView extends StatelessWidget {
  final double longitude;
  final double latitude;

  LocationView({
    required this.longitude,
    required this.latitude,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 10),
          Icon(
            Icons.location_on_sharp,
            color: Colors.red.shade900,
            size: 20,
          ),
          SizedBox(width: 5),
          Text(
            '${this.longitude.toString()}, ${this.latitude.toString()}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
