import 'package:restaurant_app/data/model/restaurant_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static DatabaseService? _instance;
  static Database? _database;

  DatabaseService._internal() {
    _instance = this;
  }

  factory DatabaseService() => _instance ?? DatabaseService._internal();

  final String tableName = 'restaurantFavorite';

  Future<Database?> get database async => _database ??= await _initializeDb();

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();

    var db = openDatabase(
      '$path/restaurantApp.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $tableName (
             id TEXT PRIMARY KEY,
             name TEXT,
             description TEXT,
             pictureId TEXT,
             city TEXT,
             rating FLOAT
           )     
        ''');
      },
      version: 1,
    );

    return db;
  }

  Future<int> insertRestaurantFavorite(RestaurantModel restaurantModel) async {
    final db = await database;
    return await db!.insert(tableName, restaurantModel.toJson());
  }

  Future<List<RestaurantModel>> getRestaurantList() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(tableName);

    return results.map((res) => RestaurantModel.fromJson(res)).toList();
  }

  Future<bool> getRestaurantById(String id) async {
    final db = await database;
    final result = await db!.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty;
  }

  Future<int> removeRestaurantFavorite(RestaurantModel restaurantModel) async {
    final db = await database;

    return await db!.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [restaurantModel.id],
    );
  }
}
