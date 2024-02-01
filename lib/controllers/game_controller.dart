import 'package:game_lib/database/database.dart';
import 'package:sqflite/sqflite.dart';

import '../models/game.dart';

class GameController {
  final String tableName = 'games';

  Future<int> insertGame(Game game) async {
    final Database db = await DatabaseHelper.initDatabase();
    return await db.insert(tableName, game.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Game>> getAllGames() async {
    final Database db = await DatabaseHelper.initDatabase();
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(maps.length, (i) {
      return Game(
        name: maps[i]['name'],
        platform: maps[i]['platform'],
        description: maps[i]['description'],
        imageUrl: maps[i]['imageUrl'],
      );
    });
  }

  Future<void> deleteGame(Game game) async {
    final Database db = await DatabaseHelper.initDatabase();
    await db.delete(
      tableName,
      where: 'name = ? AND platform = ?',
      whereArgs: [game.name, game.platform],
    );
  }

  Future<List<Game>> filterGames(String name, String platform) async {
    final Database db = await DatabaseHelper.initDatabase();
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'name LIKE ?',
      whereArgs: ['%${name.toLowerCase()}%'],
    );

    return List.generate(maps.length, (i) {
      return Game(
        name: maps[i]['name'],
        platform: maps[i]['platform'],
        description: maps[i]['description'],
        imageUrl: maps[i]['imageUrl'],
      );
    });
  }
}
