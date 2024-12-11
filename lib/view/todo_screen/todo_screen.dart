import 'package:flutter/material.dart';
import 'package:flutter_todotesting/controller/todo_controller.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController nameController = TextEditingController();
//  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    TodoController.initializeDatabase().then((_) {
      TodoController.getData().then((_) {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Todo App',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.deepPurple.shade300,
                title: Text('Enter Your Task'),
                content: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Task name',
                    border: OutlineInputBorder(),
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (nameController.text.isNotEmpty) {
                        await TodoController.addData(name: nameController.text);
                        await TodoController.getData();
                        setState(() {});
                        Navigator.of(context).pop();
                        nameController.clear();
                      }
                    },
                    child: Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 0, left: 14, right: 14),
        child: Column(
          children: [
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: TodoController.tododata.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.deepPurple,
                    elevation: 8.0,
                    child: ListTile(
                      title: Text(
                        TodoController.tododata[index]['name'] ,
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          await TodoController.deleteData(
                            TodoController.tododata[index]['id'],
                          );
                          setState(() {});
                        },
                        icon: const Icon(Icons.delete, color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
