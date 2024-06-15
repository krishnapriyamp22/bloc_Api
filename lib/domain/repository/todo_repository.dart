import 'package:bloc_api/domain/entities/todo_entity.dart';


abstract class TodoRepo {
  Future<List<TodoEntity>> getTodoformDataSource();
}
