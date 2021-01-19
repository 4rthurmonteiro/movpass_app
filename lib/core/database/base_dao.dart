import 'package:movpass_app/core/utils/entity.dart';
import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';

abstract class BaseDao<T extends Entity> {
  Future<Database> get db => DatabaseHelper.getInstance().db;

  String get tableName;

  T fromJson(Map<String, dynamic> map);

  Future<int> save(T entity) async {
    final dbClient = await db;
    final id = await dbClient.insert(tableName, entity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<T>> query(String sql, [List<dynamic> arguments]) async {
    final dbClient = await db;

    final list = await dbClient.rawQuery(sql, arguments);

    return list.map<T>((json) => fromJson(json)).toList();
  }

  Future<List<T>> findAll() {
    return query('select * from $tableName');
  }

  Future<T> findById(int id) async {
    final List<T> list =
        await query('select * from $tableName where Id = ?', [id]);

    return list.isNotEmpty ? list.first : null;
  }

  Future<bool> exists(int id) async {
    T c = await findById(id);
    final exists = c != null;
    return exists;
  }

  Future<int> count() async {
    final dbClient = await db;
    final list = await dbClient.rawQuery('select count(*) from $tableName');
    return Sqflite.firstIntValue(list);
  }

  Future<int> delete(int id) async {
    final dbClient = await db;
    final delete =
        await dbClient.rawDelete('delete from $tableName where Id = ?', [id]);
    return delete;
  }

  Future<int> deleteAll() async {
    final dbClient = await db;
    final deleteAll = await dbClient.rawDelete('delete from $tableName');
    return deleteAll;
  }
}
