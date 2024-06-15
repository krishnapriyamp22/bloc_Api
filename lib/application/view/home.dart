// ignore_for_file: prefer_const_constructors

import 'package:advanced_navigator/advanced_navigator.dart';
import 'package:bloc_api/application/view/add_todo.dart';
import 'package:bloc_api/domain/bloc/todo_bloc.dart';
import 'package:bloc_api/domain/delete_bloc/bloc/delete_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(microseconds: 1), () {
      BlocProvider.of<TodoBloc>(context).add(TodoRequestEvent());
    });
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 12),
        child: FloatingActionButton.extended(
          backgroundColor:Color(0xFF83C5BE),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (addtodo) => AddTodo(
                          isEdit: false,
                        )));
         
          },
          icon: Icon(
            Icons.add,
            size: 30,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
          label: Text(
            "Add New",
          ),
        ),
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        //centerTitle: true,
        title: Center(
          child: Text(
            'Notes',
            style: TextStyle(
                color: Color(0xFF83C5BE), fontWeight: FontWeight.w600, fontSize: 35),
          ),
        ),
      ),
      body: Align(
        alignment: Alignment.center,
        child: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
          if (state is TodoInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TodoStateLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TodoStateLoaded) {
            return SizedBox(
              height: 1000,
              child: ListView.builder(
                  itemCount: state.todo.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      trailing: PopupMenuButton(
                          iconColor: Colors.white,
                          onSelected: (value) {
                            if (value == 'delete') {
                              context.read<DeleteBloc>().add(TodoDeleteEvent(
                                  id: state.todo[index].sId.toString()));
                              BlocProvider.of<TodoBloc>(context)
                                  .add(TodoRequestEvent());
                            } else if (value == 'edit') {
                              Navigator.push(
                                  context,
                                  (MaterialPageRoute(
                                      builder: (edit) => AddTodo(
                                            model: state.todo[index],
                                            isEdit: true,
                                            id: state.todo[index].sId,
                                          ))));
                            }
                          },
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                child: Text('Delete'),
                                value: 'delete',
                              ),
                              PopupMenuItem(
                                child: Text('Edit'),
                                value: 'edit',
                              )
                            ];
                          }),
                      leading: Text('${index + 1}',
                          style: TextStyle(color: Colors.white, fontSize: 15)),
                      title: Text(
                        '${state.todo[index].title}',
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text('${state.todo[index].description}',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 196, 189, 189))),
                    );
                  }),
            );
          } else if (state is TodoStateError) {
            return Center(
              child: Text(
                state.massage,
                style: TextStyle(color: Colors.amber),
              ),
            );
          } else {
            Center(
              child: Text('some error is there!!!'),
            );
          }
          return Center(
            child: Text('Empty...'
            ),
          );
        }),
      ),
    );
  }
}
