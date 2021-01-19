import 'dart:async';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.getInstance();

  DatabaseHelper.getInstance();

  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDb() as Database;

    return _db;
  }

  Future initDb() async {
    final String databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, 'movpass.db');
    print("db $path");

    final db = await openDatabase(path,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    final String s = await rootBundle.loadString("assets/sql/create.sql");

    final List<String> sqls = s.split(";");

    for (final String sql in sqls) {
      if (sql.trim().isNotEmpty) {
        print("sql: $sql");
        await db.execute(sql);
      }
    }
  }

  Future<FutureOr<void>> _onUpgrade(
      Database db, int oldVersion, int newVersion) async {
    print("_onUpgrade: oldVersion: $oldVersion > newVersion: $newVersion");

//    if(oldVersion == 1 && newVersion == 2){
//      await db.execute("alter table Checklist add column ExtremidadesParaCentro TEXT");
//    }
  }

  Future close() async {
    final dbClient = await db;
    return dbClient.close();
  }
}
