import 'dao.dart';
import 'dto.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(RoutineAdapter());
  await Hive.openBox<Routine>('routineBox');
  RoutineDAO routineRepository = RoutineDAO();
  //await routineRepository.createARoutine("routineName", DateTime.now(), 1);
  print(1);
  List<Routine> l = await routineRepository.getAllRoutines();
  for(var r in l){
    print(r.routineName);
  }
  print(2);

}