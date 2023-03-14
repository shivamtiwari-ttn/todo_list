import 'package:flutter/material.dart';
import 'package:todo_list/cubit/todo_cubit.dart';
import 'package:todo_list/screens/TaskListScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TODOCubit(),
        child: MaterialApp(
        home: TaskListScreen(),
    ),
    );
  }
}

