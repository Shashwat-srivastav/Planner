import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planner/screens/summary.dart';

void main() {
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
      home: SummaryPage(),
    );
  }
}
