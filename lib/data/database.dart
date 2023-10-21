import 'package:my_first_project_flutter/data/task_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), "task.db");
  return await openDatabase(path, version: 1, onCreate: _onCreate);
}

Future _onCreate(Database db, int version) async {
  await db.execute(TaskDao.tableSql);
}
