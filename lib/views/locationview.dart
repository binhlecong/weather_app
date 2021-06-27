import 'package:flutter/material.dart';

class LocationView extends StatelessWidget {
  final double longitude;
  final double latitude;

  LocationView({
    Key key,
    @required this.longitude,
    @required this.latitude,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.location_on, color: Colors.white, size: 15),
          SizedBox(width: 10),
          Text(this.longitude.toString(),
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              )),
          Text(' , ',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              )),
          Text(this.latitude.toString(),
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}
