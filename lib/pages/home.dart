import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do/data/database.dart';
import 'package:to_do/util/dialog_box.dart';
import 'package:to_do/util/todo_tile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Reference the hive box
  final _myBox = Hive.box('myBox');

  //text Controller
  final _textController = TextEditingController();

  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // if it is the first time ever opening the app, Load the default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // Data already exists
      db.loadData();
    }
    super.initState();
  }

  // check if checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

  //Save new Task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_textController.text, false]);
      _textController.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  // creating new tasks
  void createNewTask() {
    showDialog(context: context, builder: (context) {
      return DialogBox(
        controller: _textController,
          onSave: saveNewTask,
        onCancel: () => Navigator.of(context).pop(),
      );
    });
  }
  // Delete tasks
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text('To Do'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
