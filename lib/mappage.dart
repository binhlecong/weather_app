import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/detailpage.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  LatLng currPos = LatLng(0, 0);
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kLake = CameraPosition(
    bearing: 0,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 45,
  );

  //Set<Marker> markers = const <Marker>{};
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Open weather client'),
        elevation: 10,
      ),
      body: Stack(
        children: [
          GoogleMap(
            markers: Set<Marker>.of(markers.values),
            compassEnabled: true,
            rotateGesturesEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: _kLake,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onTap: (LatLng coor) {
              currPos = coor;
              _addMarker(coor);
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

                  LatLng currPos = LatLng(
                    double.parse(coor['lat']),
                    double.parse(coor['lng']),
                  );

                  _addMarker(currPos);
                  _goToCoordinate(currPos);
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

  Future<void> _goToCoordinate(LatLng coor) async {
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        tilt: 45,
        target: coor,
        zoom: 7,
      ),
    ));
  }

  void _addMarker(LatLng coor) {
    final MarkerId markerId = MarkerId('mk');

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: coor,
      infoWindow: InfoWindow(title: '', snippet: ''),
      onTap: () {
        _onMarkerTapped(coor);
      },
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  void _onMarkerTapped(LatLng pos) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailPage(position: pos)),
    );
  }
}

Future _asyncInputDialog(BuildContext context) async {
  String latitude = '0';
  String longitude = '0';

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
