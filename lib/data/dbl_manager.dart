import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  static const String dbName = "zibit.db";
  static const int dbVersion = 1;

  static final DatabaseManager _instance = DatabaseManager._internal();
  factory DatabaseManager() => _instance;
  DatabaseManager._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, dbName),
      version: dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create tables
    final tableSchemas = {
      "Categories": [
        {"name": "_id", "type": "INTEGER PRIMARY KEY AUTOINCREMENT"},
        {"name": "name", "type": "TEXT NOT NULL"}
      ],
      "Reps": [
        {"name": "_id", "type": "INTEGER PRIMARY KEY AUTOINCREMENT"},
        {"name": "repName", "type": "TEXT NOT NULL"}
      ],
      "Vendors": [
        {"name": "_id", "type": "INTEGER PRIMARY KEY AUTOINCREMENT"},
        {"name": "vendorName", "type": "TEXT NOT NULL"}
      ],
      "Deals": [
        {"name": "_id", "type": "INTEGER PRIMARY KEY AUTOINCREMENT"},
        {"name": "dealName", "type": "TEXT NOT NULL"},
        {"name": "amount", "type": "FLOAT"}
      ],
    };

    for (final tableName in tableSchemas.keys) {
      final columns = tableSchemas[tableName]!
          .map((col) => "${col['name']} ${col['type']}")
          .join(", ");
      await db.execute("CREATE TABLE $tableName ($columns)");
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Drop and recreate tables on upgrade
    final tables = ["Categories", "Reps", "Vendors", "Deals"];
    for (final table in tables) {
      await db.execute("DROP TABLE IF EXISTS $table");
    }
    await _onCreate(db, newVersion);
  }

  Future<void> deleteDatabase(String path) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    await deleteDatabase(path);
  }
}
