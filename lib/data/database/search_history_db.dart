import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather_app/data/models/database/recent_search.dart';

class SearchHistoryDB {
  SearchHistoryDB._();

  static final SearchHistoryDB db = SearchHistoryDB._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "recentsearch.db");
    return await openDatabase(
      path,
      version: 3,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''CREATE TABLE RecentSearch (
          id INTEGER PRIMARY KEY,
          cityname TEXT
          )''');
      },
    );
  }

  newSearch(RecentSearch newSearch) async {
    final db = await database;

    var table = await db.rawQuery("SELECT * FROM RecentSearch");
    int nextId = table.length;
    if (nextId >= 20) nextId = 20;

    newSearch.id = await db
        .insert(
          'RecentSearch',
          {'id': nextId, 'cityname': newSearch.cityname},
          conflictAlgorithm: ConflictAlgorithm.replace,
        )
        .then((value) => newSearch.id = value);
    return newSearch.id;
  }

  updateRecentSearch(RecentSearch newRecentSearch) async {
    final db = await database;
    var res = await db.update("RecentSearch", newRecentSearch.toMap(),
        where: "id = ?", whereArgs: [newRecentSearch.id]);
    return res;
  }

  getRecentSearch(int id) async {
    final db = await database;
    var res = await db.query("RecentSearch", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? RecentSearch.fromMap(res.first) : null;
  }

  Future<List<RecentSearch>> getAllRecentSearchs() async {
    final db = await database;
    var res = await db.query("RecentSearch");
    List<RecentSearch> list =
        res.isNotEmpty ? res.map((c) => RecentSearch.fromMap(c)).toList() : [];
    return list;
  }

  deleteRecentSearch(int id) async {
    final db = await database;
    return db.delete("RecentSearch", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from RecentSearch");
  }
}
