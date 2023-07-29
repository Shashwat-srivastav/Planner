// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'package:get/get.dart';

class Todo extends GetxController {
  RxList<String> list = <String>[].obs;

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

class Subjects extends GetxController {
  RxList<Subject> sl = <Subject>[].obs;

  addSubject(name, curr, tot) {
    Subject x = new Subject(name, curr, tot);
    sl.add(x);
  }

  inccurrent(i) {
    sl[i].curr.value++;
  }

  delete(i) {
    sl.removeAt(i);
  }

  reset(i) {
    sl[i].curr.value = 0;
    sl[i].tot.value = 0;
  }

  classneeded(i) {
    var num = sl[i].curr.value - (0.5 * sl[i].tot.value);
    var det = (0.5);

    return num / det > 0 ? 'good' : (num / det) * -1 + 1;
  }

  removeSubject(i) {
    sl.removeAt(i);
  }
}

class Subject extends GetxController {
  late String name;
  // String sum;
  late RxInt curr;
  late RxInt tot;
  Subject(
    name,
    // this.sum,
    curr,
    tot,
  ) {
    this.name = name;
    // this.sum = sum;
    this.curr = curr;
    this.tot = tot;
  }
}
