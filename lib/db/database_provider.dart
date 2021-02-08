import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';

abstract class TableProvider<T> {
  /// Provider 绑定的表名
  String get table;

  Future<Database> get db async => await DbHelper.instance.db;

  /// [T] 类的属性和数据库表格的映射转化
  Map<String, dynamic> toMap(T t);

  /// [T] 类的属性和数据库表格的映射转化
  T fromMap(Map<String, dynamic> map);

  Future<int> insert(T t,
      {String nullColumnHack, ConflictAlgorithm conflictAlgorithm}) async {
    var _db = await db;
    return _db.insert(table, toMap(t),
        nullColumnHack: nullColumnHack, conflictAlgorithm: conflictAlgorithm);
  }

  insertAll(List<T> list,
      {String nullColumnHack, ConflictAlgorithm conflictAlgorithm}) async {
    var _db = await db;
    var batch = _db.batch();
    list.forEach((t) => batch.insert(table, toMap(t),
        nullColumnHack: nullColumnHack, conflictAlgorithm: conflictAlgorithm));
    return batch.commit();
  }

  /// @return the items found
  Future<List<T>> query(
      {bool distinct,
      List<String> columns,
      String where,
      List<dynamic> whereArgs,
      String groupBy,
      String having,
      String orderBy,
      int limit,
      int offset}) async {
    var _db = await db;
    List<Map<String, dynamic>> result = await _db.query(table,
        distinct: distinct,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        groupBy: groupBy,
        having: having,
        orderBy: orderBy,
        limit: limit,
        offset: offset);

    var list = List<T>();
    result.forEach((map) => list.add(fromMap(map)));

    return list;
  }

  Future<int> update(T t,
      {String where,
      List<dynamic> whereArgs,
      ConflictAlgorithm conflictAlgorithm}) async {
    var _db = await db;
    return _db.update(table, toMap(t),
        where: where,
        whereArgs: whereArgs,
        conflictAlgorithm: conflictAlgorithm);
  }

  updateAll(List<T> list,
      {String where,
      List<dynamic> whereArgs,
      ConflictAlgorithm conflictAlgorithm}) async {
    var _db = await db;
    var batch = _db.batch();
    list.forEach((t) => batch.update(table, toMap(t),
        where: where,
        whereArgs: whereArgs,
        conflictAlgorithm: conflictAlgorithm));
    return batch.commit();
  }

  Future<int> delete({String where, List<dynamic> whereArgs}) async {
    var _db = await db;
    return _db.delete(table, where: where, whereArgs: whereArgs);
  }

  Future<int> deleteAll() async {
    var _db = await db;
    return _db.delete(table);
  }
}
