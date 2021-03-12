import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/todo.dart';

class DatabaseService{
  CollectionReference todosCollection = FirebaseFirestore.instance.collection('Todos');

  Future createNewTodo(String title) async{
    return await todosCollection.add({
      "title":title,
      "isComplete": false,
    });
  }

  Future completTask(String uuid, bool isComplete) async{
    return await todosCollection.doc(uuid).update({"isComplete": !isComplete});
  }

  Future removeTodo(String uuid) async {
    await todosCollection.doc(uuid).delete();
  }

  List<Todo> todoFromFirestore(QuerySnapshot snapshot){
    if(snapshot != null){
      return snapshot.docs.map((e){
        return Todo(
          isComplete: e.data()['isComplete'],
          title: e.data()['title'],
          uuid: e.id,
        );
      }).toList();
    }else{
      return null;
    }
  }

  Stream<List<Todo>> listTodos(){
    return todosCollection.snapshots().map(todoFromFirestore);
  }
}