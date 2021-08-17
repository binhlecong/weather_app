import 'package:flutter/material.dart';
import 'package:weather_app/screens/mappage.dart';
import 'package:weather_app/screens/settingpage.dart';

import 'package:weather_app/utils/search.dart';
import 'package:weather_app/widgets/currentweatherwidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final List<String> majorCities = [
    'hanoi',
    'seattle',
    'london',
    'paris',
    'hongkong',
    'sydney',
    'moscow',
  ];
  List<CurrentWeatherSummary> scrolledCities = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 4; i++) {
      scrolledCities.add(CurrentWeatherSummary(cityName: majorCities[i]));
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
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MapSample()),
              );
            },
            icon: Icon(Icons.map),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingPage()),
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Container(
        child: RefreshIndicator(
          onRefresh: _pullRefresh,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: scrolledCities.length,
            itemBuilder: (content, index) => scrolledCities[index],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    scrolledCities.clear();
    super.dispose();
  }

  void _getMoreData() {
    int l = scrolledCities.length;
    if (l >= majorCities.length) return;
    scrolledCities.add(
      CurrentWeatherSummary(cityName: majorCities[l]),
    );

    setState(() {});
  }

  Future<void> _pullRefresh() async {
    scrolledCities = [];
    setState(() {});

    return Future.delayed(Duration(milliseconds: 250), () {
      for (var i = 0; i < 3; i++) {
        scrolledCities.add(
          CurrentWeatherSummary(cityName: majorCities[i]),
        );
      }
      setState(() {});
    });
  }
}
