import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:gynlist_one/dao.dart';
import 'package:gynlist_one/dto.dart';

class MockBox extends Mock implements Box<Routine> {}

void main() {
  group('RoutineRepository Tests', () {
    //late MockBox mockBox;
    late RoutineDAO routineRepository;

    setUp(() {
      //mockBox = MockBox();
      //routineRepository = RoutineDAO(mockBox);
    });

    test('Add a Routine', () async {
      final mockBox = MockBox();
      final dao = RoutineDAO(mockBox);
      //final routine = Routine(routineName: 'TestRoutine', startDate: DateTime.now(), goalHour: 1);
     //when(mockBox.put(any, routine)).thenAnswer((_) async => Future<void>);


      await dao.createARoutine('TestRoutine', DateTime.now(), 1);

      //verify(mockBox.put(any, routine)).called(1);
    });

    tearDown(() {
      // Any cleanup code if needed
    });
  });
}
