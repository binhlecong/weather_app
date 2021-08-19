import 'package:flutter/material.dart';
import 'package:weather_app/screens/mappage.dart';
import 'package:weather_app/screens/settingpage.dart';

import 'package:weather_app/utils/search.dart';
import 'package:weather_app/widgets/crwth_tilelayout.dart';
import 'package:weather_app/widgets/currentweatherwidget.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Location location = Location();
  final ScrollController _scrollController = ScrollController();
  late Future<CurrentWeatherSummary> userCity;
  List<CurrentWeatherSummary> scrolledCities = [];
  final List<String> majorCities = [
    'hanoi',
    'seattle',
    'New York',
    'london',
    'paris',
    'hongkong',
    'sydney',
    'moscow',
    'berlin',
    'abu dhabi',
    'shanghai',
    'tokyo',
    'dubai',
  ];

  @override
  void initState() {
    super.initState();
    // user's location
    userCity = _getUserCityWeather();
    // weather at major cities
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
    TextStyle sectionTextStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    );

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
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                ListTile(
                  dense: true,
                  leading: Icon(Icons.location_searching),
                  title: Text('Your location', style: sectionTextStyle),
                  tileColor: Theme.of(context).dividerColor,
                  trailing: IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {
                      // Set location manually or use GPS
                    },
                  ),
                ),
                FutureBuilder<CurrentWeatherSummary>(
                  future: userCity,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!;
                    } else {
                      Center(child: Text('Please enable device location'));
                    }
                    return CRWThTileLayout(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        border: Border(
                          bottom: BorderSide(
                            color: Theme.of(context).dividerColor,
                            width: 2,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  dense: true,
                  leading: Icon(Icons.location_city),
                  title: Text('Major cities', style: sectionTextStyle),
                  tileColor: Theme.of(context).dividerColor,
                  trailing: IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {
                      // Add new cities
                    },
                  ),
                ),
                ...scrolledCities,
              ],
            ),
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

    return Future.delayed(Duration(milliseconds: 100), () {
      userCity = _getUserCityWeather();
      for (var i = 0; i < 4; i++) {
        scrolledCities.add(
          CurrentWeatherSummary(cityName: majorCities[i]),
        );
      }
      setState(() {});
    });
  }

  Future<CurrentWeatherSummary> _getUserCityWeather() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        throw Exception('Location service disable');
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        throw Exception('Location permission denied');
      }
    }

    LocationData _location = await location.getLocation();
    return CurrentWeatherSummary.fromLatLon(
      lat: _location.latitude!,
      lon: _location.longitude!,
    );
  }
}
