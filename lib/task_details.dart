import 'package:flutter/material.dart';

class TaskDetailsPage extends StatelessWidget {
  final Map<String, dynamic> task;

  const TaskDetailsPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task['title'] ?? 'Détails de la tâche'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Titre: ${task['title']}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Description: ${task['description']}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Text('Date de début: ${task['startDate']}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Date de fin: ${task['endDate']}',
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
