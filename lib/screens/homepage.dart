import 'package:flutter/material.dart';
import 'package:weather_app/screens/favoritepage.dart';
import 'package:weather_app/screens/mappage.dart';
import 'package:weather_app/screens/settingpage.dart';

import 'package:weather_app/utils/search.dart';
import 'package:weather_app/widgets/crwth_tilelayout.dart';
import 'package:weather_app/widgets/currentweatherwidget.dart';
import 'package:location/location.dart';
import 'package:weather_app/widgets/feedBackItem.dart';

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
  List<Widget> dragAndDrogItems = [];

  @override
  void initState() {
    super.initState();
    // user's location
    userCity = _getUserCityWeather();
    // weather at major cities
    for (var i = 0; i < 4; i++) {
      scrolledCities.add(CurrentWeatherSummary(
        key: UniqueKey(),
        cityName: majorCities[i],
      ));
    }
    _mixDraggableAndDragTarget();

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
          child: Text('Weather'),
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
                MaterialPageRoute(builder: (context) => FavoritePage()),
              );
            },
            icon: Icon(Icons.star),
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
                  minLeadingWidth: 8,
                  leading: Icon(Icons.location_searching),
                  title: Text('Your location', style: sectionTextStyle),
                  tileColor: Theme.of(context).dividerColor,
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
                  minLeadingWidth: 8,
                  leading: Icon(Icons.location_city),
                  title: Text('Major cities', style: sectionTextStyle),
                  tileColor: Theme.of(context).dividerColor,
                ),
                ...dragAndDrogItems,
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
    scrolledCities.add(CurrentWeatherSummary(
      key: UniqueKey(),
      cityName: majorCities[l],
    ));

    _mixDraggableAndDragTarget();
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

      _mixDraggableAndDragTarget();
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

  void _mixDraggableAndDragTarget() {
    List<Widget> list = [];
    int i = 0;
    for (i = 0; i < scrolledCities.length; i++) {
      list.add(_buildDropZone(i));
      list.add(_buildDraggableTile(scrolledCities[i], i));
    }

    list.add(_buildDropZone(i));

    setState(() {
      dragAndDrogItems = list;
    });
  }

  void _rearrange(int indexBefore, int indexAfter) {
    if (indexBefore == indexAfter || indexBefore == indexAfter - 1) return;

    scrolledCities.insert(indexAfter, scrolledCities.elementAt(indexBefore));
    if (indexBefore < indexAfter) {
      scrolledCities.removeAt(indexBefore);
    } else {
      scrolledCities.removeAt(indexBefore + 1);
    }

    _mixDraggableAndDragTarget();
  }

  Widget _buildDropZone(int dropIndex) {
    return DragTarget<int>(builder: (context, data, rejects) {
      return Container(
        height: 20,
      );
    }, onAccept: (item) {
      _rearrange(item, dropIndex);
    });
  }

  Widget _buildDraggableTile(CurrentWeatherSummary item, int itemIndex) {
    return LongPressDraggable(
      data: itemIndex,
      dragAnchorStrategy: (object, context, offset) {
        return Offset(120, 60);
      },
      feedback: FeedBackItem(),
      child: item,
    );
  }
}
