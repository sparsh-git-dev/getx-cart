// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/product_model.dart';

class LocalDBHelper {
  LocalDBHelper._privateConstructor();
  static final LocalDBHelper instance = LocalDBHelper._privateConstructor();
  static const _databaseName = "getx_cart.db";
  static const _databaseVersion = 1;
  static const table = 'products_in_cart';
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnPrice = 'price';
  static const columnQuantity = 'quantity';
  static const columnImageUrl = 'featured_image';
  static const columnSlug = 'slug';
  static const columnDescription = 'description';
  static const columnStatus = 'status';
  static const columnCreatedAt = 'created_at';

  static Database? _database;
  Future<Database> get database async {
    return _database ?? await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY ,
            $columnTitle TEXT ,
            $columnPrice INTEGER ,
            $columnQuantity INTEGER ,
            $columnImageUrl TEXT  ,
            $columnSlug TEXT  ,
            $columnDescription TEXT  ,
            $columnStatus TEXT  ,
            $columnCreatedAt TEXT  
          )
          ''');
  }

  Future<int> insert(Datum data) async {
    final Database db = await instance.database;
    return await db.insert(
      table,
      {
        'id': data.id,
        'title': data.title,
        'price': data.price,
        'quantity': data.quantity,
        'featured_image': data.featuredImage,
        "slug": data.slug,
        "description": data.description,
        "status": data.status,
        "created_at": data.createdAt.toIso8601String(),
      },
    );
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    final Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryRows(
      String columnName, dynamic value) async {
    final Database db = await instance.database;
    return await db.query(
      table,
      where: "$columnName LIKE '%$value%'",
    );
  }

  Future<int> updateQuantity(int id) async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> product = await queryRows(columnId, id);
    final quantity = product[0][columnQuantity] + 1;

    return await db.rawUpdate(
      'UPDATE $table SET quantity = ? WHERE id = ?',
      [
        quantity,
        id,
      ],
    );
  }
}
