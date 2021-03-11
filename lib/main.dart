import 'package:flutter/material.dart';
import './todo_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nihongo Learn',
        theme: ThemeData(
          primaryColor: Colors.blue[300],
          backgroundColor: Colors.white,
          accentColor: Colors.black,
        ),
        home: ToDoList());
  }
}
