import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference todolistcollection =
      FirebaseFirestore.instance.collection("TodoList");

  Future addTodo(String _todo, bool isDone) async {
    return await todolistcollection.add({'todo': _todo, 'isDone': isDone});
  }

  Future<void> updateUser(String updateText, String refDoc) async {
    return await todolistcollection.doc(refDoc).update({'todo': updateText});
  }

  Future<void> updateIsDone(bool isDone, String refDoc) async {
    return await todolistcollection.doc(refDoc).update({'isDone': isDone});
  }

  Future<void> deleteUser(String docRef) {
    return todolistcollection.doc(docRef).delete();
  }
}
