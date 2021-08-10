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
            color: Colors.black45,
            size: 15,
          ),
          SizedBox(width: 5),
          Text(
            '${this.longitude.toStringAsFixed(1)}, ${this.latitude.toStringAsFixed(1)}',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}
