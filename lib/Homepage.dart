import 'package:flutter/material.dart';
import 'package:todoapp/database.dart';
import 'package:todoapp/widget/todolist.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myController = TextEditingController();
  int docId = 0;
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Text(
          "TO DO App",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 24.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: 250.0,
                  child: Material(
                    elevation: 8.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: TextField(
                      controller: myController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          hintText: "Type Something here...",
                          hintStyle: TextStyle(color: Colors.black),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                CircleAvatar(
                    backgroundColor: Colors.green,
                    child: IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        String todo = myController.text;
                        bool isDone = false;
                        await DatabaseService().addTodo(todo, isDone);
                        myController.clear();
                        //await DatabaseService().getData();
                      },
                    ))
              ],
            ),
            SizedBox(height: 24.0),
            TodoList(),
          ],
        ),
      ),
    );
  }
}
