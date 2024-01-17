import 'package:flutter/material.dart';
import 'package:gynlist_one/dao.dart';
import 'dart:async';
import 'add_exercise_screen.dart';
import 'dao.dart';
import 'dto.dart';

class CheckInScreen extends StatefulWidget {
  final String routineName;

  const CheckInScreen({
    super.key,
    required this.routineName
    });

  @override
  CheckInScreenState createState() => CheckInScreenState();
}

class CheckInScreenState extends State<CheckInScreen> {
  DateTime checkInTime = DateTime.now();
  final Stopwatch stopwatch = Stopwatch();
  final List<String> exercises = []; // Initial exercises
  final Map<String, List<ExerciseDetail>> exercise_with_detail = {};
  Timer? timer;

  String displayTime = '00:00:00';
  double workTime = 0;
  @override
  void initState() {
    super.initState();
    checkInTime = DateTime.now();
  }

  String _formatDuration(Duration duration) {
    return '${duration.inHours.toString().padLeft(2, '0')}:${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
  }

  void _startStopwatch() {
    setState(() {
      stopwatch.start();
      timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
        setState(() {
          displayTime = _formatDuration(stopwatch.elapsed);
        });
      });
    });
  }

  void _stopStopwatch() {
    setState(() {
      stopwatch.stop();
      timer?.cancel();
      displayTime = _formatDuration(stopwatch.elapsed); // Update displayTime with the stopped time
    });
  }

  void _endCheckIn() {
    // Stop the stopwatch and pop the screen
    _stopStopwatch();
    workTime = stopwatch.elapsed.inSeconds / 3600;
    CheckInDAO checkInRepository = CheckInDAO();
    ExerciseInCheckInDAO exerciseInCheckInRepository = ExerciseInCheckInDAO();
    for(String exerciseName in exercises){
      List<ExerciseDetail>? details = exercise_with_detail[exerciseName];
      exerciseInCheckInRepository.createExerciseInCheckIn(exerciseName,
          widget.routineName, checkInTime, details!);
    }
    checkInRepository.createCheckIn(checkInTime, widget.routineName, workTime);
    Navigator.of(context).pop();
  }

  void _addExercise() {
    // Placeholder function to add an exercise
    setState(() {
      exercises.add('New Exercise ${exercises.length + 1}');
    });
  }

  void _navigateToAddExerciseScreen() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddExerciseScreen(routineName: widget.routineName,
          checkInTime: checkInTime,),
      ),
    );
    if (result != null) {
      setState(() {
        exercises.add('${result['exerciseName']}');
        exercise_with_detail['${result['exerciseName']}'] = result['exerciseDetails'];
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check-In'),
        actions: <Widget>[
          IconButton(
            icon: Icon(stopwatch.isRunning ? Icons.pause : Icons.play_arrow),
            onPressed: stopwatch.isRunning ? _stopStopwatch : _startStopwatch,
          ),
          IconButton(
            icon: const Icon(Icons.stop),
            onPressed: _stopStopwatch,
          ),
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _endCheckIn,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: exercises.length + 1, // Plus one for the "Add Exercise" button
              itemBuilder: (BuildContext context, int index) {
                if (index < exercises.length) {
                  var detailText = exercise_with_detail[exercises[index]]?.map((detail) => '${detail.weight}kg ${detail.numberOfSet} x ${detail.numberOfReps}')
                      .join('\n');
                  return ListTile(
                    title: Text(exercises[index]),
                    subtitle: Text(detailText!), // Placeholder for exercise notes
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // waiting to implement the edit exercise functionality
                      },
                    ),
                  );
                } else {
                  // "Add Exercise" button at the end of the list
                  return ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Add Exercise'),
                    onTap: _navigateToAddExerciseScreen,
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              stopwatch.isRunning ? '00:${stopwatch.elapsed.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(stopwatch.elapsed.inSeconds.remainder(60)).toString().padLeft(2, '0')}' : '00:00:00',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ],
      ),
    );
  }
}