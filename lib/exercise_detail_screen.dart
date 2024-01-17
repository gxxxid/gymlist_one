import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class ExerciseDetailScreen extends StatefulWidget {
  @override
  _ExerciseDetailScreenState createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  int _weight = 30; // Default starting weight
  int _sets = 4;    // Default starting sets
  int _reps = 8;   // Default starting reps

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Exercise Detail'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NumberPicker(
                value: _weight,
                minValue: 0,
                maxValue: 1000,
                onChanged: (value) => setState(() => _weight = value),
              ),
              const Text('KG'),
              NumberPicker(
                value: _sets,
                minValue: 0,
                maxValue: 100,
                onChanged: (value) => setState(() => _sets = value),
              ),
              const Text('x'),
              NumberPicker(
                value: _reps,
                minValue: 0,
                maxValue: 100,
                onChanged: (value) => setState(() => _reps = value),
              ),
              const Text('Reps'),
            ],
          ),

          ElevatedButton(
            onPressed: () {
              // Return the values when confirmed
              Navigator.of(context).pop({'weight': _weight, 'sets': _sets, 'reps': _reps});
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}