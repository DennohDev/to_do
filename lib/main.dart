import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do/pages/home.dart';

void main() async {
  // Initialize the Hive
  await Hive.initFlutter();

  // Open a box 
  var box = await Hive.openBox('myBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do',
      home: const Home(),
      theme: ThemeData(primarySwatch: Colors.yellow),
    );
  }
}
