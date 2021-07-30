import 'package:flutter/material.dart';
import 'package:weather_app/api/weather_api.dart';
import 'package:weather_app/mappage.dart';
import 'package:weather_app/models/currentweatherapi/currentweather.dart';
import 'package:weather_app/views/currentweathertile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final currentWeathers = <Future<CurrentWeather>>[];
  ScrollController _scrollController = ScrollController();
  final List<String> majorCities = [
    'hanoi',
    'seattle',
    'london',
    'paris',
    'hongkong',
    'sydney',
    'moscow',
  ];
  int id = 0;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 3; i++) {
      currentWeathers.add(WeatherAPI.fetchCurrentWeather(majorCities[i]));
      id += 1;
    }
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Title(
            color: Colors.white,
            child: Text('Weather app'),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapSample(),
                  ),
                );
              },
              icon: Icon(
                Icons.map,
              ),
            ),
          ]),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xd6d6d6),
        ),
        child: ListView.builder(
            controller: _scrollController,
            itemCount: currentWeathers.length,
            itemBuilder: (content, index) {
              return FutureBuilder<CurrentWeather>(
                future: currentWeathers[index],
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CurrentWeatherSummary(
                      w: snapshot.data!,
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      "${snapshot.error}",
                      style: TextStyle(color: Colors.red),
                    );
                  }
                  return Container(
                    height: 220,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }

  _getMoreData() {
    if (currentWeathers.length >= majorCities.length) return;
    for (var i = id; i < majorCities.length; i++) {
      currentWeathers.add(WeatherAPI.fetchCurrentWeather(majorCities[i]));
    }
    setState(() {});
  }
}
