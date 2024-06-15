import 'package:bloc/bloc.dart';
import 'package:bloc_api/domain/entities/todo_entity.dart';
import 'package:bloc_api/domain/entities/usecases/todo_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {//constuctr
    on<TodoRequestEvent>((event, emit) async { //ev being prcd //em function usd to emit new state
      emit(TodoStateLoading()); //data fetcg strt
      try {
        final todo = await TodoUseCases().getTodoFromDataSource();
        emit(TodoStateLoaded(todo: todo));
      } catch (e) {
        emit(TodoStateError(massage: e.toString()));
      }
    });
  }
}
