// add_exercise_screen.dart
import 'package:flutter/material.dart';
import 'exercise_detail_screen.dart';
import 'dto.dart';

class Detail {
  int weight;
  int sets;
  int reps;

  Detail({required this.weight, required this.sets, required this.reps});
}

class AddExerciseScreen extends StatefulWidget {
  final String routineName;
  final DateTime checkInTime;

  const AddExerciseScreen({
    super.key,
    required this.routineName,
    required this.checkInTime
  });

  @override
  _AddExerciseScreenState createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends State<AddExerciseScreen> {
  final _formKey = GlobalKey<FormState>();
  String _exerciseName = '';
  List<ExerciseDetail> _exerciseDetails = [];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Here you would handle the logic to create the exercise in your database or state management solution
      Navigator.of(context).pop({
        'exerciseName': _exerciseName,
        'exerciseDetails': _exerciseDetails,
      });
    }
  }

  void _navigateToAddExerciseDetail() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ExerciseDetailScreen(),
      ),
    );

    if (result != null) {
      setState(() {
        //_exerciseDetails.add(Detail(weight: result['weight'], sets: result['sets'], reps: result['reps']));
        _exerciseDetails.add(ExerciseDetail(
          exerciseName: _exerciseName,
          routineName: widget.routineName,
          checkInTime: widget.checkInTime,
          numberOfSet: result['sets'],
          numberOfReps: result['reps'],
          weight: result['weight'],
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Exercise'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Exercise Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the exercise name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _exerciseName = value ?? '';
                    },
                  ),
                  ..._exerciseDetails.map((detail) =>
                      ListTile(
                        title: Text(
                            '${detail.weight}kg ${detail.numberOfSet} x ${detail
                                .numberOfReps}'),
                      )),
                  TextButton(
                    onPressed: _navigateToAddExerciseDetail,
                    child: Icon(Icons.add),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Confirm'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }

}