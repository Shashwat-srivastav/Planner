import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:planner/Controllers/Subject.dart';
import 'package:planner/screens/attendance.dart';
import 'package:planner/screens/summary.dart';

// import 'Controllers/AttendanceList.dart';

void main() async {
  await Hive.initFlutter();
  // Hive.registerAdapter(AttendaceListAdapter());
  Hive.registerAdapter(SubjectAdapter());
  var box = await Hive.openBox('attend');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Scheduler',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          // AttendancePage()
          SummaryPage(),
    );
  }
}
