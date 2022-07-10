import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/data/database/search_history_db.dart';
import 'package:weather_app/data/models/database/recent_search.dart';

import 'package:weather_app/widgets/current_weather_widget.dart';

class Search extends SearchDelegate {
  late String selectedResult;
  late Future<List<String>> searchData;
  late Future<List<String>> recentSearch;
  late Future<List<String>> currentSearchData;

  Search() {
    recentSearch = _loadRecentSearch();
    searchData = _loadSearchData();
    currentSearchData = recentSearch;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    SearchHistoryDB.db.newSearch(
      RecentSearch(id: 0, cityname: selectedResult),
    );

    return Container(
      padding: EdgeInsets.all(16),
      child: Center(
        child: CurrentWeatherSummary(weatherData: null),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: getSuggestionList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index]),
                onTap: () {
                  selectedResult = snapshot.data![index];
                  showResults(context);
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<List<String>> getSuggestionList() async {
    if (query.isEmpty) {
      query = '';
      return recentSearch;
    } else {
      return searchData.then(
        (value) => compute(searchQuery, [value, query]),
      );
    }
  }

  static List<String> searchQuery(List<dynamic> args) {
    List<String> suggestionList = [];
    suggestionList.addAll(
      args[0].where(
        (element) => (element as String).contains(args[1] as String),
      ),
    );
    return suggestionList;
  }

  Future<List<String>> _loadSearchData() async {
    String s = await rootBundle.loadString('assets/locations/city.list.json');
    List<dynamic> listOfJson = jsonDecode(s);
    return List<String>.from(listOfJson.map((e) => e['name']).toList());
  }

  Future<List<String>> _loadRecentSearch() async {
    List<RecentSearch> listOfRecentSearch =
        await SearchHistoryDB.db.getAllRecentSearchs();
    return listOfRecentSearch.map((e) => e.cityname).toList();
  }
}
