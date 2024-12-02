import 'package:flutter/material.dart';
import 'task_form.dart';
import 'task_details.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  List<Map<String, dynamic>> tasks = [];

  void _addTask(Map<String, dynamic> newTask) {
    setState(() {
      tasks.add(newTask);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Tâches'),
      ),
      body: tasks.isEmpty
          ? const Center(
              child: Text('Aucune tâche à afficher. Ajoutez-en une!'),
            )
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 4,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(
                      'Titre : ${task['title']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Description : ${task['description']}',
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDetailsPage(task: task),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskFormPage()),
          );

          if (result != null) {
            _addTask(result);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
