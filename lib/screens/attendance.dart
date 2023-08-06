import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:planner/Controllers/todo.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Controllers/Subject.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final Subjects l = new Subjects();
  final _myBox = Hive.box('attend');

  @override
  void initState() {
    // l.loadData();
    if (_myBox.get('Attend') == null) {
      // l.sl.add(new Subject('hello', RxInt(0), RxInt(0)));
      l.first();
    } else {
      l.loadData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var days = ['Mon', 'Tue', 'Wed', 'Thr', 'Fri', 'Sat', 'Sun'];
    DateTime dt = DateTime.now();
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            var name = ' ';
            int c = (1);
            int t = (1);
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    insetPadding:
                        EdgeInsets.symmetric(vertical: 100, horizontal: 100),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    scrollable: true,
                    shadowColor: Colors.blueGrey[300],
                    backgroundColor: Colors.grey[600],
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(20)),
                    clipBehavior: Clip.antiAlias,
                    content: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.height * 0.8,
                      color: Colors.transparent,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  fillColor: Color.fromARGB(255, 140, 141, 142),
                                  label: "Subject Name".text.white.make(),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                              onChanged: (v) {
                                name = v;
                              },
                            ),
                            TextField(
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 140, 141, 142),
                                  label: "Current".text.white.make(),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                c = (int.parse(v));
                              },
                            ),
                            TextField(
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 140, 141, 142),
                                  label: "Total".text.white.make(),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                t = (int.parse(v));
                              },
                            ),
                            TextButton(
                                onPressed: () {
                                  var x =
                                      new Subject(name: name, curr: c, tot: t);
                                  l.sl.add(x);
                                  setState(() {});
                                  l.updateData();
                                  Get.back();
                                },
                                child: "ADD"
                                    .text
                                    .headline5(context)
                                    .green400
                                    .make())
                          ]),
                    ),
                  );
                });

            // Get.defaultDialog(
            //   title: 'Add subject',
            //   content: Container(
            //     decoration: BoxDecoration(
            //         color: Colors.black12,
            //         border: Border.all(color: Colors.white, width: 2),
            //         borderRadius: BorderRadius.circular(20)),
            //     child: Column(
            //       children: [
            //         TextField(
            //           decoration:
            //               InputDecoration(label: "Subject Name".text.make()),
            //           onChanged: (v) {
            //             name = v;
            //           },
            //         ),
            //         TextField(
            //           decoration: InputDecoration(label: "Current".text.make()),
            //           keyboardType: TextInputType.number,
            //           onChanged: (v) {
            //             c = RxInt(int.parse(v));
            //           },
            //         ),
            //         TextField(
            //           decoration: InputDecoration(label: "Total".text.make()),
            //           keyboardType: TextInputType.number,
            //           onChanged: (v) {
            //             t = RxInt(int.parse(v));
            //           },
            //         ),
            //       ],
            //     ),
            //   ),
            //   onConfirm: () {
            //     var x = new Subject(name, c, t);
            //     l.sl.add(x);
            //   },
            // );
          },
          backgroundColor: Color.fromARGB(255, 140, 141, 142),
          child: Icon(CupertinoIcons.calendar_badge_plus, color: Colors.black),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            color: Color.fromARGB(255, 178, 222, 232).withOpacity(0.3),
            child: Column(
              children: [
                Stack(
                  children: [
                    Text('Attendance',
                            textScaleFactor: 2,
                            style: GoogleFonts.sacramento(fontSize: 40))
                        .pLTRB(
                            MediaQuery.of(context).size.height * 0.035,
                            MediaQuery.of(context).size.height * 0.06,
                            MediaQuery.of(context).size.height * 0.02,
                            0),
                    Row(
                      children: [
                        days[dt.weekday - 1]
                            .text
                            .headline5(context)
                            .make()
                            .p(10),
                        (dt.day.toString() +
                                '-' +
                                dt.month.toString() +
                                '-' +
                                dt.year.toString())
                            .text
                            .headline5(context)
                            .make()
                      ],
                    ).pLTRB(
                        MediaQuery.of(context).size.height * 0.13,
                        MediaQuery.of(context).size.height * 0.2,
                        MediaQuery.of(context).size.height * 0.13,
                        0),

                    ///---------------------------------------------main body of the page--------------------------------
                    Container(
                      height: MediaQuery.of(context).size.height * 0.85,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                              colors: [
                                //-----------------main body color-------------------------------------
                                Color.fromARGB(255, 118, 119, 119),
                                Colors.black,

                                // Color.fromARGB(255, 54, 54, 54).withOpacity(0.4)
                              ],
                              end: Alignment.topLeft,
                              begin: Alignment.bottomRight),
                          color: Colors.white),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            ///------------------------subjects------------------------------------
                            ///
                            ///

                            ListView.builder(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: l.sl.length,
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border:
                                                Border.all(color: Colors.white),
                                            gradient: LinearGradient(
                                                colors: (l.sl[index].curr /
                                                            l.sl[index].tot) >
                                                        0.5
                                                    ? [
                                                        Color.fromARGB(255, 85,
                                                                231, 119)
                                                            .withOpacity(0.2),
                                                        Color.fromARGB(255, 194,
                                                                234, 206)
                                                            .withOpacity(0.2),
                                                      ]
                                                    : [
                                                        Color.fromARGB(255, 243,
                                                                68, 59)
                                                            .withOpacity(0.2),
                                                        Color.fromARGB(255, 240,
                                                                193, 167)
                                                            .withOpacity(0.2),
                                                      ],
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft)),
                                        child: ListTile(
                                          // onTap: () {
                                          //   var x = l.classneeded(index);
                                          //   Get.snackbar(
                                          //       'classes needed to attend',
                                          //       x.toString());
                                          // },
                                          onTap: () {
                                            int t = l.sl[index].tot;
                                            int c = l.sl[index].curr;

//------------------------------------------------

                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    insetPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 100,
                                                            horizontal: 100),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 10),
                                                    scrollable: true,
                                                    shadowColor:
                                                        Colors.blueGrey[300],
                                                    backgroundColor:
                                                        Colors.grey[600],
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            side: BorderSide(
                                                                color: Colors
                                                                    .white,
                                                                width: 2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    content: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.28,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.8,
                                                      color: Colors.transparent,
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            TextField(
                                                              decoration:
                                                                  InputDecoration(
                                                                      focusedBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(color: Colors.white),
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                      ),
                                                                      enabledBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(color: Colors.white),
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                      ),
                                                                      filled:
                                                                          true,
                                                                      fillColor: Color.fromARGB(
                                                                          255,
                                                                          140,
                                                                          141,
                                                                          142),
                                                                      label: "Current"
                                                                          .text
                                                                          .white
                                                                          .make(),
                                                                      border:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                      )),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              onChanged: (v) {
                                                                c = (int.parse(
                                                                    v));
                                                              },
                                                            ),
                                                            TextField(
                                                              decoration:
                                                                  InputDecoration(
                                                                      focusedBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(color: Colors.white),
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                      ),
                                                                      enabledBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(color: Colors.white),
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                      ),
                                                                      filled:
                                                                          true,
                                                                      fillColor: Color.fromARGB(
                                                                          255,
                                                                          140,
                                                                          141,
                                                                          142),
                                                                      label: "Total"
                                                                          .text
                                                                          .white
                                                                          .make(),
                                                                      border:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                      )),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              onChanged: (v) {
                                                                t = (int.parse(
                                                                    v));
                                                              },
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                IconButton(
                                                                    icon: Icon(
                                                                      CupertinoIcons
                                                                          .settings_solid,
                                                                      // size: 50,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          217,
                                                                          164,
                                                                          242),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      l.reset(
                                                                          index);
                                                                      l.updateData();
                                                                      setState(
                                                                          () {});
                                                                      Get.back();
                                                                    }),
                                                                IconButton(
                                                                    icon: Icon(
                                                                      CupertinoIcons
                                                                          .bin_xmark,
                                                                      // size: 50,
                                                                      color: Colors
                                                                              .red[
                                                                          900],
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      l.delete(
                                                                          index);
                                                                      l.updateData();
                                                                      setState(
                                                                          () {});
                                                                      Get.back();
                                                                    }),
                                                                IconButton(
                                                                    icon: Icon(
                                                                      CupertinoIcons
                                                                          .arrow_counterclockwise_circle,
                                                                      // size: 50,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          37,
                                                                          177,
                                                                          220),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      l.undo(
                                                                          index);
                                                                      l.updateData();
                                                                      setState(
                                                                          () {});
                                                                      Get.back();
                                                                    }),
                                                              ],
                                                            ),
                                                            TextButton(
                                                                onPressed: () {
                                                                  l.sl[index]
                                                                      .curr = c;
                                                                  l.sl[index]
                                                                      .tot = t;
                                                                  setState(
                                                                      () {});
                                                                  l.updateData();
                                                                  Get.back();
                                                                },
                                                                child: "Change"
                                                                    .text
                                                                    .red800
                                                                    .headline5(
                                                                        context)
                                                                    .make())
                                                          ]),
                                                    ),
                                                  );
                                                });
//-----------------------------------------------

                                            // Get.defaultDialog(
                                            //     title: "Edit",
                                            //     onConfirm: () {
                                            //       l.sl[index].tot = t;
                                            //       l.sl[index].curr = c;
                                            //       l.updateData();
                                            //       setState(() {});
                                            //     },
                                            //     content: Column(
                                            //       children: [
                                            //         TextField(
                                            //           decoration: InputDecoration(
                                            //               label: "Current"
                                            //                   .text
                                            //                   .make()),
                                            //           keyboardType:
                                            //               TextInputType.number,
                                            //           onChanged: (v) {
                                            //             c = RxInt(int.parse(v));
                                            //           },
                                            //         ),
                                            //         TextField(
                                            //           decoration: InputDecoration(
                                            //               label: "Total"
                                            //                   .text
                                            //                   .make()),
                                            //           keyboardType:
                                            //               TextInputType.number,
                                            //           onChanged: (v) {
                                            //             t = RxInt(int.parse(v));
                                            //           },
                                            //         ),
                                            //         Row(
                                            //           children: [
                                            //             IconButton(
                                            //                 icon: Icon(
                                            //                   CupertinoIcons
                                            //                       .restart,
                                            //                   // size: 50,
                                            //                   color:
                                            //                       Color.fromARGB(
                                            //                           255,
                                            //                           217,
                                            //                           164,
                                            //                           242),
                                            //                 ),
                                            //                 onPressed: () {
                                            //                   l.reset(index);
                                            //                   l.updateData();
                                            //                 }),
                                            //             IconButton(
                                            //                 icon: Icon(
                                            //                   CupertinoIcons
                                            //                       .bin_xmark,
                                            //                   // size: 50,
                                            //                   color:
                                            //                       Colors.red[300],
                                            //                 ),
                                            //                 onPressed: () {
                                            //                   l.delete(index);
                                            //                   l.updateData();
                                            //                 }),
                                            //           ],
                                            //         )
                                            //       ],
                                            //     ));

                                            //-----------------end--------------
                                          },
                                          leading: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            child: PieChart(PieChartData(
                                                centerSpaceRadius: 20,
                                                sections: [
                                                  PieChartSectionData(
                                                      title: " ",
                                                      radius: 10,
                                                      value: l.sl[index].curr
                                                          .toDouble(),

                                                      ///----current value-------
                                                      color: (l.sl[index].curr /
                                                                  l.sl[index]
                                                                      .tot) >
                                                              0.5
                                                          ? Color.fromARGB(
                                                              255, 88, 235, 130)
                                                          : Colors.deepOrange),
                                                  PieChartSectionData(
                                                      title: "",
                                                      radius: 10,
                                                      value: (l.sl[index].tot
                                                              .toDouble() -
                                                          l.sl[index].curr
                                                              .toDouble()), ////------------(100-current value)---------------
                                                      color: Colors.transparent)
                                                ])),
                                          ),
                                          title: GlowText(
                                            glowColor: (l.sl[index].curr /
                                                        l.sl[index].tot) >
                                                    0.5
                                                ? Color.fromARGB(
                                                    255, 193, 231, 204)
                                                : Color.fromARGB(
                                                    255, 234, 198, 188),
                                            l.sl[index].name.capitalized,
                                            textScaleFactor: 2,
                                            style: GoogleFonts.hahmlet(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          subtitle: SizedBox(
                                            height: 50,
                                            child: Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      //-----------increase curr---------
                                                      l.inccurrent(index);
                                                      l.sl[index].tot++;
                                                      setState(() {});
                                                      l.updateData();

                                                      print(l.sl[index].curr);
                                                    },
                                                    icon: Icon(
                                                      CupertinoIcons.check_mark,
                                                      color: Colors.green[900],
                                                    )),
                                                '/'
                                                    .text
                                                    .headline5(context)
                                                    .make(),
                                                IconButton(
                                                    onPressed: () {
                                                      //-----------increase tot---------
                                                      l.sl[index].tot++;
                                                      setState(() {});
                                                      l.updateData();
                                                    },
                                                    icon: Icon(
                                                      CupertinoIcons.xmark,
                                                      color: Colors.red[900],
                                                    )),
                                              ],
                                            ).pLTRB(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0,
                                                0,
                                                0,
                                                0),
                                          ),
                                          trailing: SizedBox(
                                            width: 100,
                                            height: 50,
                                            child: Column(
                                              children: [
                                                GlowText(
                                                  '${l.sl[index].curr}/${l.sl[index].tot}',
                                                  glowColor: Color.fromARGB(
                                                      255, 45, 196, 213),
                                                  textScaleFactor: 1.5,
                                                  style: GoogleFonts.sacramento(
                                                    color: Colors.white,
                                                  ),
                                                ).p(5),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ).p(10),

                                      //--------------------percentage--------------------------------
                                      GlowText(
                                        '${((l.sl[index].curr / l.sl[index].tot) * 100).round()}% ',
                                        glowColor:
                                            Color.fromARGB(255, 45, 196, 213),
                                        textScaleFactor: 0.96,
                                        style: GoogleFonts.sacramento(
                                          color: Colors.white,
                                        ),
                                      ).pLTRB(
                                          MediaQuery.of(context).size.height *
                                              0.062,
                                          MediaQuery.of(context).size.height *
                                              0.051,
                                          0,
                                          0),

                                      //---------------------attend classes-------------
                                      Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.05,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  1.3,
                                              child: GlowText(
                                                (l.sl[index].curr /
                                                            l.sl[index].tot) >
                                                        0.5
                                                    ? 'You can leave ${l.classneeded(index).round().toString()} classes '
                                                    : 'You need to attend ${l.classneeded(index).round().toString()} classes',
                                                softWrap: true,
                                                glowColor: Color.fromARGB(
                                                    255, 45, 196, 213),
                                                textScaleFactor: 1.1,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ))
                                          .pLTRB(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.26,
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.0715,
                                              0,
                                              0),
                                      //------------------------------------------
                                    ],
                                  );
                                }),

                            ///-----------------------------------------------
                            // Container(
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(20),
                            //       border: Border.all(color: Colors.white),
                            //       gradient: LinearGradient(
                            //           colors: [
                            //             Color.fromARGB(255, 172, 203, 227),
                            //             Color.fromARGB(255, 224, 217, 243)
                            //           ],
                            //           begin: Alignment.topLeft,
                            //           end: Alignment.bottomRight)),
                            //   child: ListTile(
                            //     leading: Container(
                            //       width: MediaQuery.of(context).size.width * 0.2,
                            //       child: PieChart(PieChartData(
                            //           centerSpaceRadius: 20,
                            //           sections: [
                            //             PieChartSectionData(
                            //                 title: " ",
                            //                 radius: 10,
                            //                 value: 70,

                            //                 ///----current value-------
                            //                 color: Colors.greenAccent),
                            //             PieChartSectionData(
                            //                 title: "",
                            //                 radius: 10,
                            //                 value:
                            //                     30, ////------------(100-current value)---------------
                            //                 color: Colors.transparent)
                            //           ])),
                            //     ),
                            //     title: Text(
                            //       'Subject',
                            //       textScaleFactor: 2,
                            //       style: GoogleFonts.sacramento(),
                            //     ),
                            //     subtitle: SizedBox(
                            //       height: 50,
                            //       child: Row(
                            //         children: [
                            //           IconButton(
                            //               onPressed: () {
                            //                 //-----------increase curr---------
                            //               },
                            //               icon: Icon(CupertinoIcons.check_mark)),
                            //           '/'.text.headline5(context).make(),
                            //           IconButton(
                            //               onPressed: () {
                            //                 //-----------increase tot---------
                            //               },
                            //               icon: Icon(CupertinoIcons.xmark)),
                            //         ],
                            //       ).pLTRB(MediaQuery.of(context).size.width * 0, 0,
                            //           0, 0),
                            //     ),
                            //     trailing: SizedBox(
                            //       width: 100,
                            //       height: 50,
                            //       child: Text(
                            //         'curr/tot',
                            //         textScaleFactor: 2,
                            //         style: GoogleFonts.sacramento(),
                            //       ).p(10),
                            //     ),
                            //   ),
                            // ).p(10)
                          ],
                        ),
                      ),
                    ).pLTRB(0, MediaQuery.of(context).size.height * 0.25, 0, 0)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
