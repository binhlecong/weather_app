import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/weather_api.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String weatherdata = 'No data';
  WeatherAPI myAPI = WeatherAPI(lat: '33', lon: '33');

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
          child: Icon(Icons.refresh_outlined),
          onPressed: () async {
            final newdata = await myAPI.apiCall();
            setState(() {
              weatherdata = newdata;
            });
          }),
    );
  }
}
