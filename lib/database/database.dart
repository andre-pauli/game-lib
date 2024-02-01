import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Future<Database> initDatabase() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'game_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE games(id INTEGER PRIMARY KEY, name TEXT, platform TEXT, description TEXT, imageUrl TEXT)',
        );
      },
      version: 1,
    );
    return database;
  }
}
