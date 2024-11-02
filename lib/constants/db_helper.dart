import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  Database? _db;

  Future<Database?> get db async {
    _db ??= await initDatabase();
    return _db;
  }

  Future<Database?> initDatabase() async {
    String databasePath = await getDatabasesPath();
    String fullPath = "$databasePath/sqflite.db";
    return openDatabase(
      fullPath,
      version: 1,
      onCreate: (Database db, int version) async {
        db.execute("CREATE TABLE 'todo'('id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 'title' TEXT NOT NULL, 'description' TEXT NOT NULL, 'isDone' INTEGER NOT NULL);");
      },
    );
  }

  Future<List<Map<String, dynamic>>> read(String table) async {
    try {
      Database? myDB = await db;
      List<Map<String, dynamic>> response = await myDB!.query(table);
      return response;
    } catch (error) {
      debugPrint("Error: $error");
      return [];
    }
  }

  Future<int> create(
    String table, {
    required Map<String, dynamic> data,
  }) async {
    try {
      Database? myDB = await db;
      int response = await myDB!.insert(table, data);
      return response;
    } catch (error) {
      debugPrint("Error: $error");
      return -1;
    }
  }

  Future<bool> update(
    String table, {
    required String condition,
    required Map<String, dynamic> data,
  }) async {
    try {
      Database? myDB = await db;
      bool response = await myDB!.update(table, data, where: condition) < 0 ? false : true;
      return response;
    } catch (error) {
      debugPrint("Error: $error");
      return false;
    }
  }

  Future<bool> delete(
    String table, {
    required String condition,
  }) async {
    try {
      Database? myDB = await db;
      bool response = await myDB!.delete(table, where: condition) < 0 ? false : true;
      return response;
    } catch (error) {
      debugPrint("Error: $error");
      return false;
    }
  }

  Future<void> drop() async {
    String databasePath = await getDatabasesPath();
    String fullPath = "$databasePath/sqflite.db";
    await deleteDatabase(fullPath);
  }
}

/// RawInsert
///   - If Success
///     - id
///   - If Fail
///     - -1
/// RawUpdate
///   - If Success
///     - Positive Number => Row Affected Count
///   - If Fail
///     - Negative Number => -1
/// RawDelete
///   - If Success
///     - Positive Number => Row Affected Count
///   - If Fail
///     - Negative Number => -1
