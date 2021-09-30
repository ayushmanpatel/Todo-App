import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/database.dart';
import 'package:todoapp/widget/edit_todo.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  bool isdone = false;
  final Stream<QuerySnapshot> _todoStream =
      FirebaseFirestore.instance.collection("TodoList").snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _todoStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Center(child: Text('Something went wrong')),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return ListBody(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

              return Padding(
                padding:
                    const EdgeInsets.only(bottom: 14.0, left: 6.0, right: 6.0),
                child: Container(
                  height: 73.0,
                  child: Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: data['isDone'],
                              onChanged: (bool value) async {
                                String currentTodo = data['todo'];
                                var documentID;
                                var collection = FirebaseFirestore.instance
                                    .collection('TodoList');
                                var querySnapshots = await collection
                                    .where('todo', isEqualTo: currentTodo)
                                    .get();
                                for (var snapshot in querySnapshots.docs) {
                                  documentID = snapshot.id;
                                }
                                setState(() {
                                  DatabaseService()
                                      .updateIsDone(value, documentID);
                                });
                                //print(data['isDone'].toString());
                              },
                            ),
                            Container(
                              width: 100.0,
                              child: Text(
                                data['todo'],
                                softWrap: true,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                    onPressed: () async {
                                      String currentTodo = data['todo'];
                                      var documentID;
                                      var collection = FirebaseFirestore
                                          .instance
                                          .collection('TodoList');
                                      var querySnapshots = await collection
                                          .where('todo', isEqualTo: currentTodo)
                                          .get();
                                      for (var snapshot
                                          in querySnapshots.docs) {
                                        documentID = snapshot.id;
                                      }
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            EditTodo(oldtext: documentID),
                                        barrierDismissible: false,
                                      );
                                    },
                                  )),
                              SizedBox(
                                width: 14.0,
                              ),
                              CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    onPressed: () async {
                                      var documentID1;
                                      String currentTodo = data['todo'];
                                      var collection = FirebaseFirestore
                                          .instance
                                          .collection('TodoList');
                                      var querySnapshots = await collection
                                          .where('todo', isEqualTo: currentTodo)
                                          .get();
                                      for (var snapshot
                                          in querySnapshots.docs) {
                                        documentID1 =
                                            snapshot.id; // <-- Document ID

                                      }
                                      await DatabaseService()
                                          .deleteUser(documentID1);
                                    },
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        });
  }
}


// ListView.builder(itemBuilder: (context, index) {
//       return Container(
//         height: 73.0,
//         child: Material(
//           elevation: 8.0,
//           borderRadius: BorderRadius.circular(10.0),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Row(
//                   children: <Widget>[
//                     Checkbox(
//                       value: isdone,
//                       onChanged: (bool value) {
//                         setState(() {
//                           isdone = value;
//                         });
//                       },
//                     ),
//                     SizedBox(
//                       width: 6.0,
//                     ),
//                     Text("To-Do Task here"),
//                   ],
//                 ),
//                 Row(
//                   children: <Widget>[
//                     Icon(Icons.edit),
//                     SizedBox(
//                       width: 16.0,
//                     ),
//                     Icon(Icons.delete),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       );
//     });