import 'package:flutter/material.dart';
import 'package:weather_app/screens/home_page.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open Weather App',
      theme: ThemeData.light(),
      home: SafeArea(
        child: HomePage(),
      ),
    );
  }
}
