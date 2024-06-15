// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:bloc_api/application/view/home.dart';
import 'package:bloc_api/domain/edit_bloc/bloc/edit_bloc.dart';
import 'package:bloc_api/domain/entities/todo_entity.dart';
import 'package:bloc_api/domain/post/bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTodo extends StatelessWidget {
  bool isEdit = false;
  String? id;
  TodoEntity? model;
  AddTodo({
    this.model,
    this.id,
    required this.isEdit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (isEdit) {
      titleController.text = model!.title.toString();
      descriptionController.text = model!.description.toString();
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          isEdit ? 'Edit Todo' : 'Add Todo',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            TextFormField(
              style: TextStyle(color: Colors.white),
              controller: titleController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                  hintText: 'Add title',
                  hintStyle: TextStyle(color: Colors.white)),
            ),
            SizedBox(
              width: 10,
            ),
            TextFormField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  hintText: 'Description',
                  hintStyle: TextStyle(color: Colors.white)),
              maxLines: 5,
              controller: descriptionController,
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () => isEdit ? edit(context) : submit(context),
              child: Container(
                width: 230,
                height: 40,
                child: Align(
                    alignment: Alignment.center,
                    child: Text(isEdit ? 'Edit' : 'Submit',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 16))),
                decoration: BoxDecoration(
                    color: Color(0xFF83C5BE),
                    borderRadius: BorderRadius.circular(20)),
              ),
            )
          ],
        ),
      ),
    );
  }

  void edit(BuildContext context) {
    BlocProvider.of<EditBloc>(context).add(TodoEditEvent(
        id: id ?? '1',
        description: descriptionController.text,
        title: titleController.text));
    titleController.clear();
    descriptionController.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
      (route) => false,
    );
  }

  void submit(BuildContext context) {
    BlocProvider.of<PostBloc>(context).add(TodoPostEvent(
        title: titleController.text, description: descriptionController.text));
    titleController.clear();
    descriptionController.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
      (route) => false,
    );
    // Navigator.pop(context);
  }
}

TextEditingController titleController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
