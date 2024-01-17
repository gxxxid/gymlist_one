import 'package:hive/hive.dart';

part 'dto.g.dart';

@HiveType(typeId: 0)
class Routine extends HiveObject {
  @HiveField(0)
  String routineName;

  @HiveField(1)
  DateTime startDate;

  @HiveField(2)
  int goalHour;

  Routine({required this.routineName,
    required this.startDate, required this.goalHour});

}

@HiveType(typeId: 1)
class CheckIn extends HiveObject {
  @HiveField(0)
  DateTime checkInTime;

  @HiveField(1)
  String routineName;

  @HiveField(2)
  double workHour;

  CheckIn({required this.checkInTime,
    required this.routineName,
    required this.workHour});
}

@HiveType(typeId: 2)
class Exercise extends HiveObject {
  @HiveField(0)
  String exerciseName;

  @HiveField(1)
  String routineName;

  Exercise({required this.exerciseName, required this.routineName});
}

@HiveType(typeId: 3)
class ExerciseInCheckIn extends HiveObject {
  @HiveField(0)
  String exerciseName;

  @HiveField(1)
  String routineName;

  @HiveField(2)
  DateTime checkInTime;


  ExerciseInCheckIn({
    required this.exerciseName,
    required this.routineName,
    required this.checkInTime,
  });
}

@HiveType(typeId: 4)
class BodyReport extends HiveObject {
  @HiveField(0)
  String reportId;

  @HiveField(1)
  double weight;

  @HiveField(2)
  double wrist;

  @HiveField(3)
  double bust;

  @HiveField(4)
  double fatRatio;

  BodyReport({
    required this.reportId,
    required this.weight,
    required this.wrist,
    required this.bust,
    required this.fatRatio,
  });

}

@HiveType(typeId: 5)
class ExerciseDetail extends HiveObject {
  @HiveField(0)
  String exerciseName;

  @HiveField(1)
  String routineName;

  @HiveField(2)
  DateTime checkInTime;

  @HiveField(3)
  int numberOfSet;

  @HiveField(4)
  int numberOfReps;

  @HiveField(5)
  int weight;

  ExerciseDetail({
    required this.exerciseName,
    required this.routineName,
    required this.checkInTime,
    required this.numberOfSet,
    required this.numberOfReps,
    required this.weight,
  });
}

