import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), 'my_vlog.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
            CREATE TABLE todo (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT NOT NULL,
              content TEXT,
              done INTEGER NOT NULL DEFAULT 0
            )
        ''');
      },
    );
  }

  // 插入
    Future<int> insertTodo(Map<String, dynamic> todo) async {
      var dbClient = await db;
      // 默认未完成
      if (!todo.containsKey('done')) {
        todo['done'] = 0;
      }
      return await dbClient.insert('todo', todo);
  }

  // 查询全部
    Future<List<Map<String, dynamic>>> getTodos() async {
      var dbClient = await db;
      return await dbClient.query('todo');
  }

  // 更新
    Future<int> updateTodo(int id, Map<String, dynamic> todo) async {
      var dbClient = await db;
      return await dbClient.update('todo', todo, where: 'id = ?', whereArgs: [id]);
    }

    // 更新完成状态
    Future<int> updateTodoDone(int id, bool done) async {
      var dbClient = await db;
      return await dbClient.update('todo', {'done': done ? 1 : 0}, where: 'id = ?', whereArgs: [id]);
  }

  // 删除
  Future<int> deleteTodo(int id) async {
    var dbClient = await db;
    return await dbClient.delete('todo', where: 'id = ?', whereArgs: [id]);
  }
}
