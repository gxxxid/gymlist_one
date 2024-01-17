import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'dao.dart';
import 'main.dart';

class AddRoutineScreen extends StatefulWidget {
  @override
  _AddRoutineScreenState createState() => _AddRoutineScreenState();
}

class _AddRoutineScreenState extends State<AddRoutineScreen> {
  final _formKey = GlobalKey<FormState>();
  String _routineName = '';
  int _goalHours = 1; // Default to 1 hour

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      RoutineDAO routineRepository = RoutineDAO();
      DateTime now;
      routineRepository.createARoutine(_routineName,now = DateTime.now(), _goalHours);
      // Return the data to the previous screen
      Navigator.of(context).pop({'routineName': _routineName,
        'goalHours': _goalHours, 'startDate': now});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Routine'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Routine Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a routine name';
                }
                return null;
              },
              onSaved: (value) {
                _routineName = value ?? '';
              },
            ),
            NumberPicker(
              value: _goalHours,
              minValue: 0,
              maxValue: 24,
              onChanged: (value) => setState(() => _goalHours = value),
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}