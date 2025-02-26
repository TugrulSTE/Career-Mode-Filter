import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Databasehelper {

  static Database? _database;
  static final Databasehelper ins = Databasehelper._init();

  Databasehelper._init();

  Future<Database> get database async {
    if (_database!= null) {
      return _database!;
    }
    _database= await _initDB();
    return _database!;

  }

  Future<Database> _initDB() async{
    String path= join(await getDatabasesPath(), 'favorites.db');
    return await openDatabase(path, version: 1, onCreate: _createDB,);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorites (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            age INTEGER,
            potential INTEGER,
            overall INTEGER,
            value REAL,
            club TEXT
      )
    ''');
  }
 }