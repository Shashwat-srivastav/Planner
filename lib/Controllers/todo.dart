// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'Subject.dart';
// import 'package:planner/Controllers/AttendanceList.dart';

class Todo extends GetxController {
  RxList<String> list = <String>[].obs;
  List<String> l = [];

  final _myBOX = Hive.box('attend');

  loadTask() {
    l = _myBOX.get('TODO').cast<String>();
    list = RxList(l);
  }

  updateTodoList() {
    _myBOX.put("TODO", l);
  }

  void add(String el) {
    list.add(el);
  }
}

List<Productivetime> pt = <Productivetime>[
  Productivetime(time: 1, day: 'mon'),
  Productivetime(time: 2, day: 'tue'),
  Productivetime(time: 3, day: 'wed'),
  Productivetime(time: 1, day: 'thr'),
  Productivetime(time: 4, day: 'fri'),
  Productivetime(time: 6, day: 'sat'),
  Productivetime(time: 2, day: 'sun')
];

class Productivetime {
  int time;
  String day;
  Productivetime({
    required this.time,
    required this.day,
  });
}

class Toggle extends GetxController {
  bool week = false;
  bool month = false;
  RxList<bool> t = <bool>[].obs;

  updateweek() {
    this.week = true;
    this.month = false;
  }

  updatemonth() {
    this.week = false;
    this.month = true;
  }
}

// class attendance {
//   RxList<Subject> sl = <Subject>[].obs;
//   attendance()
//   {

//   }
// }

class Subjects {
  List<Subject> sl = <Subject>[];

  final _myBox = Hive.box('attend');

  first() {
    // Subject x = new  Subject('subject', 0, 0);
    Subject x = new Subject(name: 'subject', curr: 1, tot: 1);
    sl.add(x);
    _myBox.put("Attend", sl);
  }

  loadData() {
    sl = (_myBox.get('Attend').cast<Subject>());
  }

  updateData() {
    _myBox.put("Attend", sl);
  }

  addSubject(name, curr, tot) {
    Subject x = new Subject(name: name, curr: curr, tot: tot);
    sl.add(x);
  }

  inccurrent(i) {
    sl[i].curr++;
  }

  undo(i) {
    sl[i].curr--;
    sl[i].tot--;
  }

  delete(i) {
    sl.removeAt(i);
  }

  reset(i) {
    sl[i].curr = 1;
    sl[i].tot = 1;
  }

  classneeded(i) {
    var num = sl[i].curr - (0.5 * sl[i].tot);
    var det = (0.5);

    return num / det > 0 ? (num / det) : (num / det) * -1 + 1;
  }

  removeSubject(i) {
    sl.removeAt(i);
  }
}

// class Subject {
//   String name = '';

//   int curr ;

//   int tot = 1;

//   Subject();
// }

