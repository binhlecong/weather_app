import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:weather_app/screens/favorite_page.dart';
import 'package:weather_app/screens/map_page.dart';
import 'package:weather_app/screens/setting_page.dart';
import 'package:weather_app/store/home_page_store.dart';
import 'package:weather_app/utils/search.dart';
import 'package:weather_app/widgets/weather_summary_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  late HomePageStore _homePageStore;

  @override
  void initState() {
    super.initState();
    _initLazyLoader();
    _initStore();
  }

  void _initLazyLoader() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _homePageStore.getMajorCitiesWeather();
      }
    });
  }

  void _initStore() {
    _homePageStore = HomePageStore();
    _homePageStore.getUserLocationWeather();
    _homePageStore.getMajorCitiesWeather();
  }

  @override
  Widget build(BuildContext context) {
    final headingStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);

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
          onRefresh: _refreshPage,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                ListTile(
                  dense: true,
                  minLeadingWidth: 8,
                  leading: Icon(Icons.location_searching),
                  title: Text('Your location', style: headingStyle),
                  tileColor: Theme.of(context).dividerColor,
                ),
                Observer(
                  builder: (_) =>
                      _homePageStore.userLocationWeatherFuture.status ==
                              FutureStatus.pending
                          ? _showProgressIndicator()
                          : WeatherSummaryCard(
                              weatherData: _homePageStore.userLocationWeather),
                ),
                ListTile(
                  dense: true,
                  minLeadingWidth: 8,
                  leading: Icon(Icons.location_city),
                  title: Text('Major cities', style: headingStyle),
                  tileColor: Theme.of(context).dividerColor,
                ),
                Observer(
                  builder: (_) =>
                      _homePageStore.hasGetMajorCitiesWeatherCompleted
                          ? _homePageStore.majorCitiesWeathers.isEmpty
                              ? Text('There is no city in the list')
                              : ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      _homePageStore.majorCitiesWeathers.length,
                                  itemBuilder: (context, index) =>
                                      WeatherSummaryCard(
                                    weatherData: _homePageStore
                                        .majorCitiesWeathers[index],
                                  ),
                                )
                          : SizedBox.shrink(),
                ),
                Observer(
                  builder: (_) =>
                      _homePageStore.majorCitiesWeatherFutures.status ==
                              FutureStatus.pending
                          ? _showProgressIndicator()
                          : SizedBox.shrink(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _showProgressIndicator() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 20,
      ),
      height: 220,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<void> _refreshPage() async {
    _homePageStore.resetMajorCitiesWeather();
    _homePageStore.getUserLocationWeather();
    await _homePageStore.getMajorCitiesWeather();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
