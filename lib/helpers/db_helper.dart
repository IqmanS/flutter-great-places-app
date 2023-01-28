import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> openDB() async {
    final dbPath = await sql.getDatabasesPath();

    return sql.openDatabase(
      path.join(dbPath, 'places.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE user_places(id STRING PRIMARY KEY,title STRING ,image TEXT)");
      },
    );
  }

  static Future<void> insertToDB(
      {required String table, required Map<String, Object> data}) async {
    final sqlDB = await openDB();
    sqlDB.insert(
      table,
      data, //data needs to be a map
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> fetchFromDB(String table) async {
    final sqlDB = await openDB();
    return sqlDB.query(table);
  }
}
