import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserDataBaseHelper {
  static final _databaseName = "user.db";
  static final _databaseVersion = 1;
  UserDataBaseHelper._privateConstructor();
  static final UserDataBaseHelper instance = UserDataBaseHelper._privateConstructor();
  static  Database? _database;  
  
  Future<Database> get database async {
    if (_database != null) return _database!;
      _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
    version: _databaseVersion, onCreate: _onCreate);
  }
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE user (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email VARCHAR NOT NULL,
            nama VARCHAR NOT NULL,
            password VARCHAR NOT NULL
          )
          ''');
  }

  Future<int> insertUser(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('user', row);
  }

  Future<Map<String, dynamic>?> queryUserByEmail(String email) async { 
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.query('user',
      where: 'email = ?', 
      whereArgs: [email]);
    if(results.isNotEmpty) {
      return results.first;
    }
    return null;
  }

}