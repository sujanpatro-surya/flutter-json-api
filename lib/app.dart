import 'package:flutter/material.dart';
import 'package:json_and_api/screens/homepage/homepage.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSON And API',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      home: const HomePage(),
    );
  }
}
