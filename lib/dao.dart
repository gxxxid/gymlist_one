import 'package:hive/hive.dart';
import 'dto.dart';

class RoutineDAO{
  //Box<Routine> routineBox;
  Box<Routine> routineBox = Hive.box<Routine>('routineBox');

  //RoutineDAO(this.routineBox);

  Future<List<Routine>> getAllRoutines() async {
    return routineBox.values.toList();
  }

  Future<void> createARoutine(String routineName, DateTime startDate, int goalHour) async {
    final routine = Routine(routineName: routineName, startDate: startDate, goalHour: goalHour);
    await routineBox.put(routineName, routine);
  }

  Future<void> deleteRoutine(String routineName) async {
    await routineBox.delete(routineName);
  }
}

class CheckInDAO{
  Box<CheckIn> get checkInBox => Hive.box<CheckIn>('checkInBox');

  Future<void> createCheckIn(DateTime checkInTime,String routineName, double workHour) async {
    final checkIn = CheckIn(
      checkInTime: checkInTime,
      routineName: routineName,
      workHour: workHour,
    );
    await checkInBox.add(checkIn);
  }

  Future<List<CheckIn>> getAllCheckInByRoutine(String routineName) async {
    return checkInBox.values.where((checkIn) => checkIn.routineName == routineName).toList();
  }
  Future<List<CheckIn>> getCheckInByRoutineNDate(String routineName, DateTime checkInDate) async {
    return checkInBox.values
        .where((checkIn) =>
    checkIn.routineName == routineName &&
        isSameDay(checkIn.checkInTime, checkInDate))
        .toList();
  }
  //helper function
  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}

class ExerciseDAO{
  Box<Exercise> get exerciseBox => Hive.box<Exercise>('exerciseBox');

  Future<void> createExercise(String exerciseName, String routineName) async {
    final exercise = Exercise(exerciseName: exerciseName, routineName: routineName);
    await exerciseBox.add(exercise);
  }


}

class ExerciseInCheckInDAO {
  Box<ExerciseInCheckIn> exerciseInCheckInBox = Hive.box<ExerciseInCheckIn>('exerciseInCheckInBox');
  Box<ExerciseDetail> exerciseDetailBox = Hive.box<ExerciseDetail>('exerciseDetailBox');

  Future<void> createExerciseInCheckIn(
      String exerciseName,
      String routineName,
      DateTime checkInTime,
      List<ExerciseDetail> exerciseDetails) async {
    // Find or create an ExerciseInCheckIn instance
    ExerciseInCheckIn? checkIn = exerciseInCheckInBox.values.firstWhere(
          (ci) => ci.checkInTime == checkInTime && ci.routineName == routineName,
      orElse: () => ExerciseInCheckIn(
        exerciseName: exerciseName,
        routineName: routineName,
        checkInTime: checkInTime,
      ),
    );

    //checkIn.exerciseDetails ??= HiveList(exerciseDetailBox);

    for (var detail in exerciseDetails) {
      await exerciseDetailBox.add(detail);
    }

    await checkIn.save();
  }

  Future<void> updateExerciseInCheckIn(
      String exerciseName,
      String routineName,
      DateTime checkInTime,
      DateTime checkInDate,
      List<ExerciseDetail> updatedDetails) async {
    // Find the ExerciseInCheckIn object
    final checkInIndex = exerciseInCheckInBox.values.toList().indexWhere(
          (ci) => ci.exerciseName == exerciseName &&
          ci.routineName == routineName &&
          ci.checkInTime == checkInTime
    );

    if (checkInIndex != -1) {
      // Get the ExerciseInCheckIn object
      final checkIn = exerciseInCheckInBox.getAt(checkInIndex);

      if (checkIn != null) {
        for (var detail in updatedDetails) {
          exerciseDetailBox.add(detail); // Add updated details
        }
      }
    }
  }

  Future<void> deleteExerciseInCheckIn(String exerciseName, String routineName, DateTime checkInTime, DateTime checkInDate) async {
    // First, delete all associated ExerciseDetail objects
    final detailsToDelete = exerciseDetailBox.values.where(
            (detail) => detail.exerciseName == exerciseName &&
            detail.checkInTime == checkInTime
    ).toList();

    for (var detail in detailsToDelete) {
      await exerciseDetailBox.delete(detail.key); // Delete each detail from its box
    }

    // Then, delete the ExerciseInCheckIn object
    final checkInKey = exerciseInCheckInBox.values.firstWhere(
            (ci) => ci.exerciseName == exerciseName &&
            ci.routineName == routineName &&
            ci.checkInTime == checkInTime
        //orElse: () => null
    )?.key;

    if (checkInKey != null) {
      await exerciseInCheckInBox.delete(checkInKey);
    } else {
      // Handle the case where the ExerciseInCheckIn is not found
      print("ExerciseInCheckIn not found and could not be deleted.");
    }
  }

}

