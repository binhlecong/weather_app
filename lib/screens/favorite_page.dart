import 'package:flutter/material.dart';
import 'package:weather_app/store/favorite_page_store.dart';
import 'package:weather_app/widgets/weather_summary_card.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final ScrollController _scrollController = ScrollController();
  late FavoritePageStore _favoritePageStore;

  @override
  void initState() {
    super.initState();
    _initStore();
  }

  Future<void> _initStore() async {
    _favoritePageStore = FavoritePageStore();
    _favoritePageStore.getFavoriteCitiesWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(
          color: Colors.white,
          child: Text('Favorite locations'),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Container(
        child: RefreshIndicator(
          onRefresh: _pullRefresh,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: _favoritePageStore.favoriteCitiesWeather.length,
            itemBuilder: (context, index) => WeatherSummaryCard(
              weatherData: _favoritePageStore.favoriteCitiesWeather[index],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _pullRefresh() async {
    Future.delayed(const Duration(seconds: 5));
  }
}
