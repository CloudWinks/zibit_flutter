//import 'package:sqflite/sqflite.dart';
import 'dbl_helper.dart';

class DataSource {
  final dbHelper = DatabaseHelper();

  Future<int> addCategory(String name) async {
    final db = await dbHelper.database;
    final values = {'name': name};
    return await db.insert('Categories', values);
  }

  Future<int> deleteCategory(int id) async {
    final db = await dbHelper.database;
    return await db.delete('Categories', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getAllCategories() async {
    final db = await dbHelper.database;
    return await db.query('Categories');
  }

  Future<int> updateCategory(int id, String newName) async {
    final db = await dbHelper.database;
    final values = {'name': newName};
    return await db.update('Categories', values, where: 'id = ?', whereArgs: [id]);
  }
}
