import 'package:sqflite/sqflite.dart';

import '../commponents/task_widget.dart';
import 'database.dart';

class TaskDao {
  static const String _tablename = "task";
  static const String _name = "name";
  static const String _difficulty = "difficulty";
  static const String _image = "image";

  static const String tableSql = "CREATE TABLE $_tablename("
      "$_name TEXT, "
      "$_difficulty INTEGER, "
      "$_image TEXT)";

  save(Task task) async {
    print("Estamos acessando o save");

    final Database database = await getDatabase();
    var exist = await find(task.nome);
    if (exist.isEmpty) {
      print("A tarefa nao existia");
      return await database.insert(_tablename, toMap(task));
    } else {
      print("A tarefa ja existia");
      return await database.update(_tablename, toMap(task),
          where: "$_name = ?", whereArgs: [task.nome]);
    }
  }

  Map<String, dynamic> toMap(Task task) {
    Map<String, dynamic> taskMap = {};
    taskMap[_name] = task.nome;
    taskMap[_difficulty] = task.harded;
    taskMap[_image] = task.photo;
    return taskMap;
  }

  Future<List<Task>> findAll() async {
    print("Estamos acessando o findall");

    final Database database = await getDatabase();
    final List<Map<String, dynamic>> result = await database.query(_tablename);

    var list = toList(result);
    print(
        "Procurando dados no banco de dados... encontrado: ${list.length}");

    return list;
  }

  List<Task> toList(List<Map<String, dynamic>> listOfTasks) {

    final List<Task> tasks = [];

    for (Map<String, dynamic> line in listOfTasks) {
      final Task task = Task(line[_name], line[_image], line[_difficulty]);
      tasks.add(task);
    }

    return tasks;
  }

  Future<List<Task>> find(String taskName) async {
    print("Estamos acessando o find");

    final Database database = await getDatabase();
    final List<Map<String, dynamic>> result = await database
        .query(_tablename, where: "$_name = ?", whereArgs: [taskName]);

    print(
        "Procurando dados no banco de dados... encontrado: ${toList(result)}");

    return toList(result);
  }

  delete(String taskName) async {
    print("Estamos acessando o delete");

    final Database database = await getDatabase();
    List<Task> exist = await find(taskName);
    if (exist.isNotEmpty) {
      database.delete(_tablename, where: "$_name = ?", whereArgs: [taskName]);
      print("Tarefa deletada");
    } else {
      print("tarefa nao existe");
    }
  }
}
