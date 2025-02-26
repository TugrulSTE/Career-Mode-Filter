import 'package:careerfilter/player.dart';
import 'package:sqflite/sqflite.dart';

import 'databaseHelper.dart';

class Favoriteservice {
  Future<void> addFavorite(Player item) async {
    final db = await Databasehelper.ins.database; // Veritabanını aç
    await db.insert(
    'favorites', // Tablo adı
    item.toMap(), // Player nesnesini Map'e çeviriyoruz
    conflictAlgorithm: ConflictAlgorithm.replace,
  );// Favoriyi ekle
  }

  // 📌 Favorileri listeleme
  Future<List<Player>> getFavorites() async {
    final db = await Databasehelper.ins.database;
    final List<Map<String, dynamic>> maps = await db.query("favorites");

    return List.generate(maps.length, (i) {
      return Player.fromMap(maps[i]);
    });

    /*

    ALTERNATIVE SOLUTION

    List<Player> playerList = [];
  for (var i = 0; i < maps.length; i++) {
    Player player = Player.fromMap(maps[i]);
    playerList.add(player);
  }
  return playerList;
    */
  }

  // 📌 Favori silme
  Future<int> removeFavorite(String item) async {
    final db = await Databasehelper.ins.database;
    return await db.delete('favorites', where: 'item = ?', whereArgs: [item]);
  }
}
