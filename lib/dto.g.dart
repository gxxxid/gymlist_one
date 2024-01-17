// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoutineAdapter extends TypeAdapter<Routine> {
  @override
  final int typeId = 0;

  @override
  Routine read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Routine(
      routineName: fields[0] as String,
      startDate: fields[1] as DateTime,
      goalHour: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Routine obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.routineName)
      ..writeByte(1)
      ..write(obj.startDate)
      ..writeByte(2)
      ..write(obj.goalHour);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoutineAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CheckInAdapter extends TypeAdapter<CheckIn> {
  @override
  final int typeId = 1;

  @override
  CheckIn read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CheckIn(
      checkInTime: fields[0] as DateTime,
      routineName: fields[1] as String,
      workHour: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CheckIn obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.checkInTime)
      ..writeByte(1)
      ..write(obj.routineName)
      ..writeByte(2)
      ..write(obj.workHour);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckInAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExerciseAdapter extends TypeAdapter<Exercise> {
  @override
  final int typeId = 2;

  @override
  Exercise read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Exercise(
      exerciseName: fields[0] as String,
      routineName: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Exercise obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.exerciseName)
      ..writeByte(1)
      ..write(obj.routineName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExerciseInCheckInAdapter extends TypeAdapter<ExerciseInCheckIn> {
  @override
  final int typeId = 3;

  @override
  ExerciseInCheckIn read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExerciseInCheckIn(
      exerciseName: fields[0] as String,
      routineName: fields[1] as String,
      checkInTime: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ExerciseInCheckIn obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.exerciseName)
      ..writeByte(1)
      ..write(obj.routineName)
      ..writeByte(2)
      ..write(obj.checkInTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseInCheckInAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BodyReportAdapter extends TypeAdapter<BodyReport> {
  @override
  final int typeId = 4;

  @override
  BodyReport read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BodyReport(
      reportId: fields[0] as String,
      weight: fields[1] as double,
      wrist: fields[2] as double,
      bust: fields[3] as double,
      fatRatio: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, BodyReport obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.reportId)
      ..writeByte(1)
      ..write(obj.weight)
      ..writeByte(2)
      ..write(obj.wrist)
      ..writeByte(3)
      ..write(obj.bust)
      ..writeByte(4)
      ..write(obj.fatRatio);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BodyReportAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExerciseDetailAdapter extends TypeAdapter<ExerciseDetail> {
  @override
  final int typeId = 5;

  @override
  ExerciseDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExerciseDetail(
      exerciseName: fields[0] as String,
      routineName: fields[1] as String,
      checkInTime: fields[2] as DateTime,
      numberOfSet: fields[3] as int,
      numberOfReps: fields[4] as int,
      weight: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ExerciseDetail obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.exerciseName)
      ..writeByte(1)
      ..write(obj.routineName)
      ..writeByte(2)
      ..write(obj.checkInTime)
      ..writeByte(3)
      ..write(obj.numberOfSet)
      ..writeByte(4)
      ..write(obj.numberOfReps)
      ..writeByte(5)
      ..write(obj.weight);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
