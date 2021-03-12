import 'package:flutter/material.dart';

class ToDoList extends StatefulWidget {
  ToDoList({Key key}) : super(key: key);

  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  bool iscomplete = false;
  TextEditingController todoController = TextEditingController();

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
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return listTile();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget listTile(  ) {
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
      child: GestureDetector(
        onTap: () {
          setState(() {
            iscomplete = !iscomplete;
          });
        },
        child: ListTile(
          title: Text('One-line with both widgets'),
          leading: CircleAvatar(
            child: Icon(iscomplete ? Icons.check : Icons.error),
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
          controller: todoController,
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
            onPressed: () {
              if(todoController.text.isNotEmpty){
                print(todoController.text);
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
