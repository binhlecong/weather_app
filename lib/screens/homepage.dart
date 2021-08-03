import 'package:flutter/material.dart';
import 'package:weather_app/screens/mappage.dart';

import 'package:weather_app/utils/search.dart';
import 'package:weather_app/views/currentweathertile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  final List<String> scrolledCities = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 3; i++) {
      scrolledCities.add(majorCities[i]);
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
              onPressed: () {
                showSearch(context: context, delegate: Search());
              },
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
            itemCount: majorCities.length,
            itemBuilder: (content, index) {
              return CurrentWeatherSummary(
                cityName: majorCities[index],
              );
            }),
      ),
    );
  }

  _getMoreData() {
    int l = scrolledCities.length;
    if (l >= majorCities.length) return;
    
    scrolledCities.add(majorCities[l]);
    setState(() {});
  }
}
