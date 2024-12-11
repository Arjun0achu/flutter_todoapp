import 'package:flutter/material.dart';
import 'package:flutter_todotesting/controller/todo_controller.dart';
import 'package:flutter_todotesting/view/todo_screen/todo_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
await  TodoController.initializeDatabase();
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoScreen(),
    );
  }
}
