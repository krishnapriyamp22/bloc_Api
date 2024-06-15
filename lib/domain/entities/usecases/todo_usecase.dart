

import 'package:bloc_api/data/repository/todo_fech.dart';
import 'package:bloc_api/domain/entities/todo_entity.dart';
import 'package:bloc_api/domain/repository/todo_repository.dart';

class TodoUseCases {
  TodoRepo todoRepo = TodoRepoImpl();
  Future<List<TodoEntity>> getTodoFromDataSource() async {
    final todo = await todoRepo.getTodoformDataSource();
    print('dsfsf');
    print(todo);
    return todo;
  }
}
