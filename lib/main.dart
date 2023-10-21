import 'package:flutter/material.dart';
import 'package:my_first_project_flutter/data/task_inherited.dart';
import 'package:my_first_project_flutter/screens/form_screen.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: TaskInherited(child: const MyHome()));
  }
}