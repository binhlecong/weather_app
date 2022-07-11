import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
    _initStore();
  }

  Future<void> _initStore() async {
    _homePageStore = HomePageStore();
    _homePageStore.getUserLocationWeather();
    _homePageStore.getMajorCitiesWeather();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle sectionTextStyle =
        TextStyle(fontSize: 18, fontWeight: FontWeight.w500);

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
                  title: Text('Your location', style: sectionTextStyle),
                  tileColor: Theme.of(context).dividerColor,
                ),
                Observer(
                  builder: (_) => WeatherSummaryCard(
                    weatherData: _homePageStore.userLocationWeather,
                  ),
                ),
                ListTile(
                  dense: true,
                  minLeadingWidth: 8,
                  leading: Icon(Icons.location_city),
                  title: Text('Major cities', style: sectionTextStyle),
                  tileColor: Theme.of(context).dividerColor,
                ),
                Observer(
                  builder: (_) => ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _homePageStore.majorCitiesWeather.length,
                    itemBuilder: (context, index) {
                      return WeatherSummaryCard(
                        weatherData: _homePageStore.majorCitiesWeather[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _refreshPage() async {
    _homePageStore.getUserLocationWeather();
    _homePageStore.getMajorCitiesWeather();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
