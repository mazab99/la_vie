import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteHelper {
  static const _dbName = 'myCart.db';
  static const _dbVersion = 1;
  static const _tableName = 'Cart';
  static const _columnProductId = 'productId';
  static const _columnUserId = 'userId';
  static const _columnName = 'name';
  static const _columnImageUrl = 'imageUrl';
  static const _columnPrice = 'price';
  static const _columnCount = 'count';

  SQLiteHelper._();

  static final SQLiteHelper instance = SQLiteHelper._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initializeDatabase();
    return _database!;
  }

  initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();

    String path = join(directory.path, _dbName);
    _database = await openDatabase(path, version: _dbVersion,
        onCreate: (Database db, int version) async {
      await db.execute('''
CREATE TABLE $_tableName(
  $_columnProductId TEXT,
  $_columnUserId TEXT,
  $_columnName TEXT NOT NULL,
  $_columnImageUrl TEXT NOT NULL,
  $_columnPrice INTEGER NOT NULL,
  $_columnCount INTEGER NOT NULL,
  PRIMARY KEY ($_columnProductId, $_columnUserId)
)
''');
    });
  }

  Future<List<Map<String, dynamic>>> getAll(String userId) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> _allProducts = await db.rawQuery('''
            Select * 
            From $_tableName
            WHERE $_columnUserId = "$userId"
    ''');
    return _allProducts;
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.update(_tableName, row,
        where: '$_columnProductId = ? And $_columnUserId = ?',
        whereArgs: [row[_columnProductId], row[_columnUserId]]);
  }

  Future<int> delete(String productId, String userId) async {
    Database db = await instance.database;
    return await db.delete(_tableName,
        where: '$_columnProductId = ? And $_columnUserId = ?',
        whereArgs: [productId, userId]);
  }

  Future<int> deleteByUserId(String userId) async {
    Database db = await instance.database;
    return await db
        .delete(_tableName, where: '$_columnUserId = ?', whereArgs: [userId]);
  }

  // Future<List<Map<String, dynamic>>> getAll() async {
  //   Database db = await instance.database;
  //   return await db.query(_tableName);
  // }

  // Future<Map<String, dynamic>> getById(int id) async {
  //   Database db = await instance.database;
  //   List<Map<String, dynamic>> singleElement = await db.query(_tableName);
  //   final returenedElement = singleElement.reduce((value, element) {
  //     if (value['_productId'] == id) {
  //       return value;
  //     } else {
  //       return element;
  //     }
  //   });
  //   return returenedElement;
  // }
}
