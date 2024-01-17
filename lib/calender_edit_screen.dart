import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dao.dart';
import 'dto.dart';

class CalendarEditScreen extends StatefulWidget {
  final String routineName;

  CalendarEditScreen({Key? key, required this.routineName}) : super(key: key);

  @override
  _CalendarEditScreenState createState() => _CalendarEditScreenState();
}

class _CalendarEditScreenState extends State<CalendarEditScreen> {
  DateTime? startDate;
  int? goalHour;
  RoutineDAO routineDAO = RoutineDAO();
  CheckInDAO checkInDAO = CheckInDAO();
  ExerciseInCheckInDAO exerciseInCheckInDAO = ExerciseInCheckInDAO();
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  double _opacity = 100; // Default opacity

  @override
  void initState() {
    super.initState();
    _fetchRoutineData();
  }

  void _fetchRoutineData() async {
    var fetchedStartDate = await routineDAO.getRoutineDateByName(widget.routineName);
    var fetchedGoalHour = await routineDAO.getRoutineGoalByName(widget.routineName);

    setState(() {
      startDate = fetchedStartDate ?? DateTime.now();
      goalHour = fetchedGoalHour ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Calendar for ${widget.routineName}'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: startDate ?? DateTime.now(),
            lastDay: DateTime(2100),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                // Change the color or opacity of the selected day here
              });
            },
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
            ),
          ),
          _buildWorkHourRatioWidget(),
          _buildCheckInList(),
          ElevatedButton(
            onPressed: () {
              // Placeholder for edit button functionality
            },
            child: Text('Edit'),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkHourRatioWidget() {
    return FutureBuilder<double>(
      future: checkInDAO.getTotalHourByDate(widget.routineName, _selectedDay),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return Text('No data available');
        } else {
          double workHours = snapshot.data!;
          num goalHours = goalHour ?? 1;
          double ratio = goalHours > 0 ? workHours / goalHours : 0;
          return Text('Work Hour Ratio: ${ratio.toStringAsFixed(2)}');
        }
      },
    );
  }

  Widget _buildCheckInList() {
    return FutureBuilder<List<CheckIn>>(
      future: checkInDAO.getCheckInByRoutineNDate(widget.routineName, _selectedDay),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No check-ins for this day');
        } else {
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                CheckIn checkIn = snapshot.data![index];
                return FutureBuilder<int>(
                  future: exerciseInCheckInDAO.getExerciseCountByDate(widget.routineName, checkIn.checkInTime),
                  builder: (context, exerciseSnapshot) {
                    if (exerciseSnapshot.connectionState == ConnectionState.waiting) {
                      return ListTile(
                        title: Text('Loading...'),
                      );
                    } else if (exerciseSnapshot.hasError) {
                      return ListTile(
                        title: Text('Error: ${exerciseSnapshot.error}'),
                      );
                    } else {
                      return ListTile(
                        title: Text('Check-in on ${checkIn.checkInTime}'),
                        subtitle: Text('Work hours: ${checkIn.workHour}, Exercises: ${exerciseSnapshot.data ?? 0}'),
                      );
                    }
                  },
                );
              },
            ),
          );
        }
      },
    );
  }


  // Future<DateTime?> _findFirstDate() async {
  //   RoutineDAO routineRepository = RoutineDAO();
  //   DateTime? d = await routineRepository.getRoutineDateByName(widget.routineName);
  //   return d;
  // }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}