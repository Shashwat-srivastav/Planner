import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planner/Controllers/todo.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:velocity_x/velocity_x.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final Subjects l = Get.put(Subjects());

  @override
  Widget build(BuildContext context) {
    var days = ['Mon', 'Tue', 'Wed', 'Thr', 'Fri', 'Sat', 'Sun'];
    DateTime dt = DateTime.now();
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            var name = '';
            RxInt c = RxInt(0);
            RxInt t = RxInt(0);
            Get.defaultDialog(
              title: 'Add subject',
              content: Column(
                children: [
                  TextField(
                    onChanged: (v) {
                      name = v;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(label: "Current".text.make()),
                    keyboardType: TextInputType.number,
                    onChanged: (v) {
                      c = RxInt(int.parse(v));
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(label: "Total".text.make()),
                    keyboardType: TextInputType.number,
                    onChanged: (v) {
                      t = RxInt(int.parse(v));
                    },
                  ),
                ],
              ),
              onConfirm: () {
                var x = new Subject(name, c, t);
                l.sl.add(x);
              },
            );
          },
          backgroundColor: Color.fromARGB(255, 164, 218, 230),
          child: Icon(CupertinoIcons.calendar_badge_plus),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                      days[dt.weekday - 1].text.headline5(context).make().p(10),
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
                    height: MediaQuery.of(context).size.height * 3,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 238, 246, 217),
                              Color.fromARGB(255, 215, 232, 215)
                            ],
                            end: Alignment.topLeft,
                            begin: Alignment.bottomRight),
                        color: Colors.white),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    color: Color.fromARGB(255, 164, 218, 230)
                                        .withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(20)
                                    // gradient: LinearGradient(colors: [])
                                    ),
                                child: ListTile(
                                  horizontalTitleGap: 2,
                                  leading: Container(
                                    height: 15,
                                    width: 15,
                                    child: PieChart(PieChartData(
                                        centerSpaceRadius: 20,
                                        sections: [
                                          PieChartSectionData(
                                              title: " ",
                                              radius: 10,
                                              value: 70,
                                              // badgeWidget: "yes".text.make(),
                                              // badgePositionPercentageOffset: 0.6,
                                              color: Colors.greenAccent),
                                          PieChartSectionData(
                                              title: "",
                                              radius: 10,
                                              value: 30,
                                              // badgePositionPercentageOffset: 0.2,
                                              color: Colors.transparent)
                                        ])),
                                  ).pLTRB(
                                      MediaQuery.of(context).size.width * 0.05,
                                      MediaQuery.of(context).size.width * 0.05,
                                      MediaQuery.of(context).size.width * 0.4,
                                      0),
                                  title: Container(
                                    alignment: Alignment.center,
                                    height: 500,
                                    width: 100,
                                    child: Column(
                                      children: [
                                        GradientText(
                                          "Goal",
                                          textScaleFactor: 1.5,
                                          colors: [
                                            Colors.deepOrange,
                                            Colors.deepPurple
                                          ],
                                          style: GoogleFonts.dancingScript(),
                                        ),
                                        // .text.make(),
                                        GradientText(
                                          "Current",
                                          textScaleFactor: 1.5,
                                          colors: [
                                            Colors.deepOrange,
                                            Colors.deepPurple
                                          ],
                                          style: GoogleFonts.dancingScript(),
                                        ),
                                      ],
                                    ).p(10),
                                  ),
                                ),
                              ),
                            ),
                          ).p(10),
                          //------------------------top attendance part----------------------------
                          ///------------------------subjects------------------------------------
                          ///
                          ///

                          Obx(
                            () => ListView.builder(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: l.sl.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Colors.white),
                                        gradient: LinearGradient(
                                            colors: (l.sl[index].curr.value /
                                                        l.sl[index].tot.value) >
                                                    0.5
                                                ? [
                                                    Color.fromARGB(
                                                        255, 167, 209, 240),
                                                    Color.fromARGB(
                                                        255, 178, 214, 238)
                                                  ]
                                                : [
                                                    Color.fromARGB(
                                                        255, 240, 193, 167),
                                                    Color.fromARGB(
                                                        255, 239, 105, 98)
                                                  ],
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft)),
                                    child: ListTile(
                                      onLongPress: () {
                                        RxInt t = l.sl[index].tot;
                                        RxInt c = l.sl[index].curr;
                                        Get.defaultDialog(
                                            onConfirm: () {
                                              l.sl[index].tot = t;
                                              l.sl[index].curr = c;
                                              setState(() {});
                                            },
                                            content: Column(
                                              children: [
                                                TextField(
                                                  decoration: InputDecoration(
                                                      label: "Current"
                                                          .text
                                                          .make()),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onChanged: (v) {
                                                    c = RxInt(int.parse(v));
                                                  },
                                                ),
                                                TextField(
                                                  decoration: InputDecoration(
                                                      label:
                                                          "Total".text.make()),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onChanged: (v) {
                                                    t = RxInt(int.parse(v));
                                                  },
                                                ),
                                              ],
                                            ));
                                      },
                                      leading: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: PieChart(PieChartData(
                                            centerSpaceRadius: 20,
                                            sections: [
                                              PieChartSectionData(
                                                  title: " ",
                                                  radius: 10,
                                                  value: l.sl[index].curr.value
                                                      .toDouble(),

                                                  ///----current value-------
                                                  color:
                                                      (l.sl[index].curr.value /
                                                                  l
                                                                      .sl[index]
                                                                      .tot
                                                                      .value) >
                                                              0.5
                                                          ? Color.fromARGB(
                                                              255, 88, 235, 130)
                                                          : Colors.deepOrange),
                                              PieChartSectionData(
                                                  title: "",
                                                  radius: 10,
                                                  value: (l.sl[index].tot.value
                                                          .toDouble() -
                                                      l.sl[index].curr.value
                                                          .toDouble()), ////------------(100-current value)---------------
                                                  color: Colors.transparent)
                                            ])),
                                      ),
                                      title: Text(
                                        l.sl[index].name.capitalized,
                                        textScaleFactor: 2,
                                        style: GoogleFonts.sacramento(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: SizedBox(
                                        height: 50,
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  //-----------increase curr---------
                                                  l.inccurrent(index);
                                                  l.sl[index].tot.value++;
                                                  setState(() {});
                                                  print(l.sl[index].curr);
                                                },
                                                icon: Icon(
                                                    CupertinoIcons.check_mark)),
                                            '/'.text.headline5(context).make(),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {});
                                                  //-----------increase tot---------
                                                  l.sl[index].tot.value++;
                                                },
                                                icon:
                                                    Icon(CupertinoIcons.xmark)),
                                          ],
                                        ).pLTRB(
                                            MediaQuery.of(context).size.width *
                                                0,
                                            0,
                                            0,
                                            0),
                                      ),
                                      trailing: SizedBox(
                                        width: 100,
                                        height: 50,
                                        child: Text(
                                          '${l.sl[index].curr.value}/${l.sl[index].tot.value}',
                                          textScaleFactor: 1.5,
                                          style: GoogleFonts.sacramento(),
                                        ).p(10),
                                      ),
                                    ),
                                  ).p(10);
                                }),
                          ),

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
    );
  }
}
