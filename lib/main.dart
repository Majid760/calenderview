import 'package:calendar_view/calendar_view.dart';
import 'package:calenderview/calender_screen.dart';
import 'package:flutter/material.dart';

DateTime get _now => DateTime.now();

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DateTime get _now => DateTime.now();

  List<CalendarEventData>? events;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: EventController()..addAll(_events),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: CalenderScreen(),
      ),
    );
  }
}

List<CalendarEventData> _events = [
  CalendarEventData(
    date: _now,
    event: "Joe's Birthday",
    title: "Team meeting ",
    description: "Today is project meeting.",
    color: Colors.red,
    startTime: DateTime(_now.year, _now.month, _now.day, 5),
    endTime: DateTime(_now.year, _now.month, _now.day, 8),
  ),
  CalendarEventData(
    date: _now,
    event: "Joe's Birthday",
    title: "Scrum meeting",
    description: "Today is project meeting.",
    color: Colors.red,
    startTime: DateTime(_now.year, _now.month, _now.day, 2, 30),
    endTime: DateTime(_now.year, _now.month, _now.day, 2, 45),
  ),
  CalendarEventData(
    date: _now.add(const Duration(days: 1)),
    startTime: DateTime(_now.year, _now.month, _now.day, 2),
    endTime: DateTime(_now.year, _now.month, _now.day, 8),
    event: "Wedding anniversary",
    color: Colors.amber,
    title: "Wedding anniversary",
    description: "Attend uncle's wedding anniversary.",
  ),
  CalendarEventData(
    date: _now.add(const Duration(days: 2)),
    startTime: DateTime(
        _now.add(const Duration(days: 3)).year,
        _now.add(const Duration(days: 3)).month,
        _now.add(const Duration(days: 3)).day,
        9),
    endTime: DateTime(
        _now.add(const Duration(days: 3)).year,
        _now.add(const Duration(days: 3)).month,
        _now.add(const Duration(days: 3)).day,
        12),
    color: Colors.yellow,
    title: "Football Tournament",
    description: "Go to football tournament.",
  ),
  CalendarEventData(
    date: DateTime(2022, 2, 18),
    endDate: DateTime(2022, 2, 25),
    title: 'Events ',
    event: "Event 1",
    color: Colors.green,
    description: "Go to football tournament.",
    startTime: DateTime(_now.year, _now.month, _now.day, 2),
    endTime: DateTime(_now.year, _now.month, _now.day, 4),
  )
];
