import 'package:api_first_app/example_five.dart';
import 'package:api_first_app/example_four.dart';
import 'package:api_first_app/example_three.dart';
import 'package:api_first_app/example_two.dart';
import 'package:api_first_app/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'API Course',
      home: ExampleTwo(),
    );
  }
}


