
import 'package:bloc_api/application/view/home.dart';
import 'package:bloc_api/data/datasource/postremortdatasource.dart';
import 'package:bloc_api/domain/bloc/todo_bloc.dart';
import 'package:bloc_api/domain/delete_bloc/bloc/delete_bloc.dart';
import 'package:bloc_api/domain/edit_bloc/bloc/edit_bloc.dart';
import 'package:bloc_api/domain/post/bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => EditBloc(HomeRepo())),
        BlocProvider(create: (context) => TodoBloc()),
        BlocProvider(create: (context) => PostBloc(HomeRepo())),
        BlocProvider(create: (context) => DeleteBloc(HomeRepo()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
