import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:flutter_tv_show_app/model/favorite_model.dart';

final String TableName = 'tv_favorite';

class DBHelper {
  DBHelper._();
  static final DBHelper _db = DBHelper._();
  factory DBHelper() => _db;

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await openDatabase(
      join(await getDatabasesPath(), "favomemo.db"),
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE $TableName(id INTEGER PRIMARY KEY, img_url TEXT, overview TEXT, name TEXT)");
      },
      version: 1,
    );
    ;
    return _database;
  }

  //Create
  Future<void> insertData(FavoriteShow show) async {
    final db = await database;
    await db.rawInsert('INSERT INTO $TableName(id, img_url, overview, name) VALUES(?, ?, ?, ?)',
        [show.id, show.img_url, show.overview, show.name]);
  }

  //Read
  Future<FavoriteShow> getData(int id) async {
    final db = await database;
    var res = await db.rawQuery('SELECT * FROM $TableName WHERE id = ?', [id]);
    return res.isNotEmpty
        ? FavoriteShow(id: res.first['id'], img_url: res.first['img_url'], overview: res.first['overview'], name: res.first['name'])
        : null;
  }

  //Read All
  Future<List<FavoriteShow>> getAllFavorites() async {
    final db = await database;
    var res = await db
        .rawQuery('SELECT * FROM $TableName');
    List<FavoriteShow> list = res.isNotEmpty
        ? res
            .map((c) => FavoriteShow(
                id: c['id'], img_url: c['img_url'], overview: c['overview'], name: c['name']))
            .toList()
        : [];

    return list;
  }

  //Delete
  Future<void> deleteData(int id) async {
    final db = await database;
    await db.rawDelete('DELETE FROM $TableName WHERE id = ?', [id]);
  }

  //Delete All
  Future<void> deleteAllData() async {
    final db = await database;
    db.rawDelete('DELETE FROM $TableName');
  }

  Future<void> dropTable() async {
    final db = await database;
    db.rawQuery('DROP TABLE $TableName');
  }
}
