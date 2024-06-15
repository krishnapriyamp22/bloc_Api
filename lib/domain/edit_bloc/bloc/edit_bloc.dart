import 'package:bloc/bloc.dart';
import 'package:bloc_api/data/datasource/postremortdatasource.dart';
import 'package:equatable/equatable.dart';


part 'edit_event.dart';
part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  HomeRepo rep;
  EditBloc(this.rep) : super(EditInitial()) {
    on<TodoEditEvent>((event, emit) {
      rep.editValue(event.id, event.title, event.description);
    });
  }
}
