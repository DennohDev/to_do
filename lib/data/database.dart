import 'package:hive/hive.dart';

class ToDoDataBase {
  List toDoList = [];

  // Reference the created box
  final _myBox = Hive.box('myBox');

  // Run This method if its the first time opening the app
  void createInitialData () {
    toDoList = [
      ["Tap to cancel, when done", false],
      ["Slide to the left to delete", false]
    ];
  }

  // Load the Data from the Database
  void loadData () {
    toDoList = _myBox.get("TODOLIST");
  }

  //Update the Database
  void updateData() {
    _myBox.put("TODOLIST", toDoList);
  }

}