import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  static CameraPosition newPos = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(0, 0),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414,
    );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            compassEnabled: true,
            rotateGesturesEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: _kLake,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
            right: 5,
            bottom: 110,
            child: SizedBox(
              width: 50,
              height: 50,
              child: FloatingActionButton(
                onPressed: () async {
                  final coor = await _asyncInputDialog(context);
                  // error cannot change location
                  setState(() {
                    newPos = CameraPosition(
                          bearing: 180,
                          target: LatLng(double.parse(coor['lat']), double.parse(coor['lng'])),
                          tilt: 60,
                          zoom: 20,
                        );
                  });
                  _goToCoordinate();
                },
                child: Icon(
                  Icons.add_location_alt_outlined,
                  size: 32,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToCoordinate() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(newPos));
  }
}

Future _asyncInputDialog(BuildContext context) async {
  String latitude = '1';
  String longitude = '1';

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Enter coordinate'),
        content: Row(
          children: [
            Expanded(
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(labelText: 'Latitude'),
                onChanged: (value) {
                  latitude = value;
                },
              ),
            ),
            Container(
              width: 20,
              height: 10,
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(labelText: 'Longitude'),
                onChanged: (value) {
                  longitude = value;
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop({'lat': latitude, 'lng': longitude});
              },
              child: Text('GO'))
        ],
      );
    },
  );
}
