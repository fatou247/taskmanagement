import 'package:flutter/material.dart';

class TaskFormPage extends StatefulWidget {
  const TaskFormPage({super.key});

  @override
  _TaskFormPageState createState() => _TaskFormPageState();
}

class _TaskFormPageState extends State<TaskFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    DateTime initialDate = isStartDate ? _startDate : _endDate;
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = selectedDate;
        } else {
          _endDate = selectedDate;
        }
      });
    }
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pop(context, {
        'title': _title,
        'description': _description,
        'startDate': _startDate.toLocal().toString().split(' ')[0],
        'endDate': _endDate.toLocal().toString().split(' ')[0],
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une Tâche'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Titre'),
                onSaved: (value) => _title = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un titre';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une description';
                  }
                  return null;
                },
              ),
              TextFormField(
                readOnly: true,
                controller: TextEditingController(
                    text: _startDate.toLocal().toString().split(' ')[0]),
                decoration: const InputDecoration(labelText: 'Date de début'),
                onTap: () => _selectDate(context, true),
              ),
              TextFormField(
                readOnly: true,
                controller: TextEditingController(
                    text: _endDate.toLocal().toString().split(' ')[0]),
                decoration: const InputDecoration(labelText: 'Date de fin'),
                onTap: () => _selectDate(context, false),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: _saveTask,
                  child: const Text('Enregistrer'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
