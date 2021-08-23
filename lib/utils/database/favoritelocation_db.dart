import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather_app/models/database/favoritelocation.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteLocationDB {
  static const tablename = "FavoriteLocation";

  FavoriteLocationDB._();

  static final FavoriteLocationDB db = FavoriteLocationDB._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "favoritelocation.db");
    return await openDatabase(
      path,
      version: 3,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''CREATE TABLE $tablename (
          id INTEGER PRIMARY KEY,
          cityname TEXT,
          latitude REAL,
          longitude REAL
          )''');
      },
    );
  }

  newLocation(FavoriteLocation newLocation) async {
    final db = await database;

    int nextId =
        FavoriteLocation.getId(newLocation.latitude, newLocation.longitude);

    newLocation.id = await db
        .insert(
          'FavoriteLocation',
          {
            'id': nextId,
            'cityname': newLocation.cityname,
            'latitude': newLocation.latitude,
            'longitude': newLocation.longitude,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        )
        .then((value) => newLocation.id = value);
    return newLocation.id;
  }

  updateFavoriteLocation(FavoriteLocation newFavoriteLocation) async {
    final db = await database;
    var res = await db.update(tablename, newFavoriteLocation.toMap(),
        where: "id = ?", whereArgs: [newFavoriteLocation.id]);
    return res;
  }

  getFavoriteLocation(int id) async {
    final db = await database;
    var res = await db.query(tablename, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? FavoriteLocation.fromMap(res.first) : null;
  }

  Future<List<FavoriteLocation>> getAllFavoriteLocations() async {
    final db = await database;
    var res = await db.query(tablename);
    List<FavoriteLocation> list = res.isNotEmpty
        ? res.map((c) => FavoriteLocation.fromMap(c)).toList()
        : [];
    return list;
  }

  deleteFavoriteLocation(int id) async {
    final db = await database;
    return db.delete(tablename, where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from $tablename");
  }
}
