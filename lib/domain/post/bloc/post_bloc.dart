import 'package:bloc/bloc.dart';
import 'package:bloc_api/data/datasource/postremortdatasource.dart';
import 'package:equatable/equatable.dart';


part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  HomeRepo rep;
  PostBloc(this.rep) : super(PostInitial()) {
    on<TodoPostEvent>((event, emit) {
      rep.postApi(event.title, event.description);
    });
  }
}
