// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'Subject.g.dart';

@HiveType(typeId: 0)
class Subject {
  @HiveField(0)
  String name;
  // String sum;
  @HiveField(1)
  int curr;
  @HiveField(2)
  int tot;
  Subject({
    required this.name,
    required this.curr,
    required this.tot,
  });
}
