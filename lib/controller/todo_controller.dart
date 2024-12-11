import 'package:sqflite/sqflite.dart';

class TodoController {
  static late Database database;
  static List<Map> tododata = [];

  
  static Future<void> initializeDatabase() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE todo (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL
          )
        ''');
      },
    );
  }

  static Future<void> addData({required String name}) async {
    await database.rawInsert('INSERT INTO todo(name) VALUES(?)', [name]);
    await getData();
  }

  static Future<void> getData() async {
    tododata = await database.rawQuery('SELECT * FROM todo');
  }
   static Future<void> deleteData(int id) async {
    await database.rawDelete('DELETE FROM todo WHERE id = ?', [id]);
    await getData();
  }
  
}
