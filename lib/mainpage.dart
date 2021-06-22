import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/mappage.dart';
import 'package:weather_app/weather_api.dart';

import 'dart:async';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String lat = '0';
  String lon = '0';
  String weatherdata = 'No data';
  WeatherAPI myAPI = WeatherAPI();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Open Weather API client'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Text(
          weatherdata,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.green,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add_location_alt_outlined,
            size: 32,
          ),
          onPressed: () async {
            final coordinate = await _asyncInputDialog(context);
            final newdata = await myAPI.apiCall(coordinate['lat'], coordinate['lon']);
            setState(() {
              weatherdata = newdata;
            });
          }),
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
              Container(width: 20, height: 10,),
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
                  Navigator.of(context)
                      .pop({'lat': latitude, 'lon': longitude});
                },
                child: Text('GO'))
          ],
        );
      });
}
