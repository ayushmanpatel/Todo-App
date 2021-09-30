import 'package:flutter/material.dart';
import 'package:todoapp/Homepage.dart';
import 'package:todoapp/database.dart';

class EditTodo extends StatefulWidget {
  final String oldtext;

  const EditTodo({Key key, this.oldtext}) : super(key: key);
  @override
  _EditTodoState createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  final newController = TextEditingController();

  @override
  void dispose() {
    newController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        //key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Edit',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Material(
              elevation: 0.0,
              borderRadius: BorderRadius.circular(10.0),
              child: TextField(
                controller: newController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                  hintStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  child: Text(
                    "Edit",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () async {
                    String newtodo = newController.text;
                    await DatabaseService().updateUser(newtodo, widget.oldtext);
                    newController.clear();
                    await Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
                SizedBox(
                  width: 20.0,
                ),
                GestureDetector(
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
