import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/utils/storagemanager.dart';
import 'package:weather_app/views/currentweathertile.dart';

class Search extends SearchDelegate {
  late String selectedResult;
  late List<String> searchData;
  late List<String> recentSearch;
  final String filename = '';

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
    recentSearch.insert(0, selectedResult);
    recentSearch.take(20);
    var distinctSearch = recentSearch.toSet().toList();
    StorageManager.saveData('recent', distinctSearch.join(','));

    return Container(
      child: Center(
        child: CurrentWeatherSummary(
          cityName: selectedResult.toLowerCase(),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: getSuggestionList(context),
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

  Future<List<String>> getSuggestionList(BuildContext context) async {
    final results = await Future.wait([
      StorageManager.readData('recent'),
      loadData(context),
    ]);

    recentSearch = ((results[0] ?? '') as String).split(',');
    searchData = List<String>.from(results[1].map((e) => e['name']).toList());

    List<String> suggestionList = [];
    if (query.isEmpty) {
      suggestionList = recentSearch;
    } else {
      suggestionList.addAll(
        searchData.where((element) => element.contains(query)),
      );
    }

    return suggestionList;
  }

  Future<List<dynamic>> loadData(BuildContext context) async {
    String s = await rootBundle.loadString('assets/locations/city.list.json');
    List<dynamic> listOfJson = jsonDecode(s);
    return listOfJson;
  }
}
