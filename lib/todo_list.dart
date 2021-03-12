import 'package:flutter/material.dart';
import 'package:todolist/services/database_services.dart';

import 'loading.dart';
import 'model/todo.dart';

class ToDoList extends StatefulWidget {
  ToDoList({Key key}) : super(key: key);

  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  bool iscomplete = false;
  TextEditingController todoTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todo List',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return dialog();
            },
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
      ),
      body: bodyPage(),
    );
  }

  Widget bodyPage() {
    return SafeArea(
      child: StreamBuilder<List<Todo>>(
        stream: DatabaseService().listTodos(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          }

          List<Todo> todos = snapshot.data;
          return Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    return listTile(todos[index]);
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget listTile(Todo todo) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) async {
        await DatabaseService().removeTodo(todo.uuid);
      },
      child: GestureDetector(
        onTap: () async {
          await DatabaseService().completTask(todo.uuid, todo.isComplete);
        },
        child: ListTile(
          title: Text(todo.title),
          leading: CircleAvatar(
            child: Icon(todo.isComplete ? Icons.check : Icons.error),
          ),
        ),
      ),
    );
  }

  Widget dialog() {
    return SimpleDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Row(
        children: [
          Text(
            "Add Todo",
            style: TextStyle(fontSize: 18),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.cancel,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      children: [
        //Divider(),
        TextFormField(
          controller: todoTitleController,
          autofocus: true,
          style: TextStyle(
            fontSize: 18,
            height: 1.5,
          ),
          decoration: InputDecoration(
            hintText: "Title",
            border: InputBorder.none,
          ),
        ),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: TextButton(
            onPressed: () async {
              if (todoTitleController.text.isNotEmpty) {
                await DatabaseService()
                    .createNewTodo(todoTitleController.text.trim());
                todoTitleController.text = '';
                Navigator.pop(context);
              }
            },
            child: Text(
              "ADD",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
