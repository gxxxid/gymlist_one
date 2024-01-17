import 'package:flutter/material.dart';
import 'check_in_screen.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'dao.dart';
import 'dto.dart';
import 'add_routine_screen.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(RoutineAdapter());
  await Hive.openBox<Routine>('routineBox');
  Hive.registerAdapter(CheckInAdapter());
  await Hive.openBox<CheckIn>('CheckInBox');
  Hive.registerAdapter(ExerciseInCheckInAdapter());
  await Hive.openBox<ExerciseInCheckIn>('ExerciseInCheckInBox');
  Hive.registerAdapter(ExerciseDetailAdapter());
  await Hive.openBox<ExerciseDetail>('ExerciseDetailBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // This map keeps track of which RoutineTiles are expanded.
  RoutineDAO routineDAO = RoutineDAO();
  Map<String, bool> routineExpanded = {};
  //List<String> routines = [];
  List<Routine> routines = [];

  @override
  void initState() {
    super.initState();
    _fetchRoutines();
  }

  void _fetchRoutines() async {
    final allRoutines = await routineDAO.getAllRoutines();
    setState(() {
      routines = allRoutines;
    });
  }

  void _addRoutine() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddRoutineScreen(),
      ),
    );
    if(result != null)  _fetchRoutines();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Routines'),
      ),
      body: FutureBuilder<List<Routine>>(
        future: routineDAO.getAllRoutines(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show a loading indicator while waiting
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No routines added yet');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length + 1, // Plus one for the "Add a Routine" button
              itemBuilder: (BuildContext context, int index) {
                if (index < snapshot.data!.length) {
                  // Routine tiles
                  return RoutineTile(
                    routineName: snapshot.data![index].routineName,
                    onExpandToggle: () {
                      setState(() {
                        routineExpanded[snapshot.data![index].routineName] =
                        !(routineExpanded[snapshot.data![index].routineName] ?? false);
                      });
                    },
                  );
                } else {
                  // This is the "Add a Routine" button
                  return ListTile(
                      leading: const Icon(Icons.add),
                title: const Text('Add aRoutine'),
                onTap: _addRoutine,
                );
              }
              },
            );
          }
        },
      )
    );
  }
}

class RoutineTile extends StatefulWidget {
  final String routineName;
  final VoidCallback onExpandToggle;

  const RoutineTile({
    Key? key,
    required this.routineName,
    required this.onExpandToggle,
  }) : super(key: key);

  @override
  _RoutineTileState createState() => _RoutineTileState();
}

class _RoutineTileState extends State<RoutineTile> {
  bool isExpanded = false;

  void _navigateToCheckInScreen() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CheckInScreen(routineName: widget.routineName),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return isExpanded
        ? Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      color: Colors.white, // Change as needed for your design
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ElevatedButton(
            child: Text('Return'),
            onPressed: () {
              setState(() {
                isExpanded = false;
              });
              widget.onExpandToggle();
            },
          ),
          ElevatedButton(
            child: Text('Edit'),
            onPressed: () {
              // Implement edit functionality
            },
          ),
          ElevatedButton(
            child: Text('Check-in'),
            onPressed: _navigateToCheckInScreen,
          ),
        ],
      ),
    )
        : ListTile(
      title: Text(widget.routineName),
      onTap: () {
        setState(() {
          isExpanded = true;
        });
      },
      trailing: Icon(Icons.more_vert),
    );
  }
}