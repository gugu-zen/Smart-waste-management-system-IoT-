import 'dart:async';
import 'package:path/path.dart';
import 'package:smart_waste_management_system/model/bin_data.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();
  
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'bin_data.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE binData (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        garbageLevel DOUBLE,
        timestamp TEXT
      )
    ''');
  }

  Future<void> insertBinData(BinData binData) async {
    final db = await database;
    await db.insert(
      'binData',
      binData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<BinData>> getBinData() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('binData');
    return List.generate(maps.length, (i) {
      return BinData(
        garbageLevel: maps[i]['garbageLevel'],
        timestamp: DateTime.parse(maps[i]['timestamp']),
      );
    });
  }
}

