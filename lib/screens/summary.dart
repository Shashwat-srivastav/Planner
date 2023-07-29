import 'dart:convert';
import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planner/screens/attendance.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

import '../Controllers/todo.dart';
// import 'package:video_player/video_player.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({super.key});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  String q = '';
  String img = '';
  bool week = true;
  bool month = false;
  final Todo task = Get.put(Todo());
  final Toggle tog = Get.put(Toggle());
  String t = '';
  Future getQuote() async {
    var response = await http.get(Uri.https('zenquotes.io', '/api/today'));
    var jsondata = jsonDecode(response.body);
    var quote = jsondata[0];
    // print(quote['q']);
    q = quote['q'];
  }

  Future getVideo() async {
    var response = await http.get(Uri.https('pixabay.com', '/api/', {
      'key': '38410259-dd17e9d992a78c79995bae65a',
      'q': 'clear sky',
      'image_type': 'photo'
    }));
    var jsondata = jsonDecode(response.body);
    var video = jsondata['hits'];
    var imageurl = video[0];
    print(imageurl);
    img = imageurl['largeImageURL'];
    // q = quote['q'];
  }

  //ab58Ejn-TmO5zrHqws3G1eAJU27bs33QaCP5XV1q84A  //ak
  //yosoh5jSVpFAPH2BZ5gf6zm7Nn_YywfUoQVXO7Lg39Q  //sk

  @override
  Widget build(BuildContext context) {
    var days = ['Mon', 'Tue', 'Wed', 'Thr', 'Fri', 'Sat', 'Sun'];
    DateTime dt = DateTime.now();
    print(dt.day);
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(children: [
        Stack(
          children: [
            Stack(
              children: [
                FutureBuilder(
                    future: getVideo(),
                    builder: ((context, snapshot) {
                      return Container(
                        // height: 500,
                        // width: 300,
                        child: ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Image.network(
                            img,

                            // scale: 0.5,
                            // height: 300,
                          ),
                        ),
                      );
                    })),
                Stack(
                  children: [
                    "Summary".text.headline2(context).make().pLTRB(
                        MediaQuery.of(context).size.height * 0.1, 0, 0, 0),
                    FutureBuilder(
                            future: getQuote(),
                            builder: ((context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return GradientText(
                                  q,
                                  colors: [
                                    Color.fromARGB(255, 213, 85, 46),
                                    Color.fromARGB(255, 81, 47, 138),
                                    Color.fromARGB(255, 130, 9, 51)
                                  ],
                                  style: GoogleFonts.sacramento(
                                      fontSize: 36,
                                      fontWeight: FontWeight.w500),
                                );
                              } else {
                                return CircularProgressIndicator();
                              }
                            }))
                        .pLTRB(MediaQuery.of(context).size.height * 0.01,
                            MediaQuery.of(context).size.height * 0.07, 0, 0),
                    Row(
                      children: [
                        days[dt.weekday - 1]
                            .text
                            .white
                            .headline5(context)
                            .make()
                            .p(10),
                        (dt.day.toString() +
                                '-' +
                                dt.month.toString() +
                                '-' +
                                dt.year.toString())
                            .text
                            .white
                            .headline5(context)
                            .make()
                      ],
                    ).pLTRB(
                        MediaQuery.of(context).size.height * 0.13,
                        MediaQuery.of(context).size.height * 0.25,
                        MediaQuery.of(context).size.height * 0.13,
                        0),
                  ],
                ),
              ],
            ),
            //------------------------------------------------------------------------------------

            Container(
              height: MediaQuery.of(context).size.height * 2.5,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 238, 246, 217),
                    Color.fromARGB(255, 215, 232, 215)
                  ], end: Alignment.topLeft, begin: Alignment.bottomRight),
                  color: Colors.white),
              child: Column(children: [
                //---------------top nav bar------------------------------------------
                Container(
                  height: 50,
                  width: 200,
                  child: Stack(
                    children: [
                      Container(
                        child: TextButton(
                          onPressed: () {
                            week = true;
                            month = false;
                            setState(() {});

                            print('week :' + week.toString());
                          },
                          child: Text(
                            'WEEKLY',
                            textScaleFactor: 0.8,
                            style: GoogleFonts.sacramento(
                                fontWeight: FontWeight.bold),
                          ).centered(),
                        ),
                        height: 50,
                        width: 100,
                        decoration: week
                            ? BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                color: Color.fromARGB(255, 157, 205, 242),
                                borderRadius: BorderRadius.circular(30))
                            : BoxDecoration(),
                      ),
                      //-----------month
                      Container(
                        child: TextButton(
                          onPressed: () {
                            week = false;
                            month = true;
                            setState(() {});
                          },
                          child: Text(
                            'MONTHLY',
                            textScaleFactor: 0.8,
                            style: GoogleFonts.sacramento(
                                fontWeight: FontWeight.bold),
                          ).centered(),
                        ),
                        height: 50,
                        width: 100,
                        decoration: month
                            ? BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                color: Color.fromARGB(255, 157, 205, 242),
                                borderRadius: BorderRadius.circular(30))
                            : BoxDecoration(),
                      ).pLTRB(100, 0, 0, 0),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 208, 206, 206),
                      borderRadius: BorderRadius.circular(30)),
                ).p(10),
                // Row(
                //   children: [
                //     GridTile(
                //         child: ClipRRect(
                //       borderRadius: BorderRadius.circular(20),
                //       child: BackdropFilter(
                //         filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                //         child: Container(
                //           height: 180,
                //           width: 180,
                //           decoration: BoxDecoration(
                //             border: Border.all(
                //               color: Colors.white70,
                //               width: 2,
                //             ),
                //             gradient: LinearGradient(
                //                 colors: [
                //                   Color.fromARGB(255, 231, 199, 189),
                //                   Color.fromARGB(255, 196, 176, 231),
                //                   Color.fromARGB(255, 168, 231, 224)
                //                 ],
                //                 begin: Alignment.topCenter,
                //                 end: Alignment.bottomRight),
                //             borderRadius: BorderRadius.circular(20),
                //             // color: Colors.amber,
                //           ),
                //           // child: "money".text.make(),
                //         ),
                //       ),
                //     )).p(10),
                //     GridTile(
                //         child: ClipRRect(
                //       borderRadius: BorderRadius.circular(20),
                //       child: BackdropFilter(
                //         filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                //         child: Container(
                //           height: 180,
                //           width: 180,
                //           decoration: BoxDecoration(
                //             border: Border.all(
                //               color: Colors.white70,
                //               width: 2,
                //             ),
                //             gradient: LinearGradient(
                //                 colors: [
                //                   Color.fromARGB(255, 231, 199, 189),
                //                   Color.fromARGB(255, 196, 176, 231),
                //                   Color.fromARGB(255, 168, 231, 224)
                //                 ],
                //                 begin: Alignment.topCenter,
                //                 end: Alignment.bottomRight),
                //             borderRadius: BorderRadius.circular(20),
                //             // color: Colors.amber,
                //           ),
                //           // child: "money".text.make(),
                //         ),
                //       ),
                //     )).p(10),
                //   ],
                // ),
                Row(
                  children: [
                    GridTile(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: InkWell(
                          onTap: () {
                            Get.to(AttendancePage());
                          },
                          child: Container(
                            height: 180,
                            width: 180,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white70,
                                width: 2,
                              ),
                              gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 231, 199, 189),
                                    Color.fromARGB(255, 196, 176, 231),
                                    Color.fromARGB(255, 168, 231, 224)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomRight),
                              borderRadius: BorderRadius.circular(20),
                              // color: Colors.amber,
                            ),
                            // child: "money".text.make(),
                          ),
                        ),
                      ),
                    )).p(10),
                    GridTile(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          height: 180,
                          width: 180,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white70,
                              width: 2,
                            ),
                            gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 231, 199, 189),
                                  Color.fromARGB(255, 196, 176, 231),
                                  Color.fromARGB(255, 168, 231, 224)
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomRight),
                            borderRadius: BorderRadius.circular(20),
                            // color: Colors.amber,
                          ),
                          // child: "money".text.make(),
                        ),
                      ),
                    )).p(10),
                  ],
                ).pLTRB(10, 0, 0, 0),
                Row(
                  children: [
                    GradientText(
                      "TODO's",
                      textScaleFactor: 4.5,
                      gradientType: GradientType.linear,
                      // radius: 200,
                      colors: [
                        Color.fromARGB(255, 213, 85, 46),
                        Color.fromARGB(255, 81, 47, 138),
                        Color.fromARGB(255, 105, 208, 198)
                      ],
                      style:
                          GoogleFonts.sacramento(fontWeight: FontWeight.w500),
                    ).pLTRB(MediaQuery.of(context).size.height * 0.1, 0, 0, 0),
                    IconButton(
                        color: Color.fromARGB(255, 187, 159, 236),
                        onPressed: () {
                          Get.defaultDialog(
                              title: 'Add task',
                              content: TextField(
                                style: TextStyle(color: Colors.cyanAccent[200]),
                                onSubmitted: (value) {
                                  t = value;
                                },
                              ),
                              onConfirm: () {
                                task.add(t);
                              });
                        },
                        icon: Icon(CupertinoIcons.add_circled))
                  ],
                ),
                Card(
                    color: Colors.transparent,
                    elevation: 0,
                    child: Obx(
                      () => SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.14,
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: task.list.length,
                                  itemBuilder: ((context, index) {
                                    return ClipRRect(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 20, sigmaY: 20),
                                        child: Container(
                                          height: 50,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              gradient: LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255, 229, 191, 179),
                                                    Color.fromARGB(
                                                        255, 183, 154, 233),
                                                    Color.fromARGB(
                                                        255, 168, 231, 224)
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomLeft),
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 2)),
                                          child: ListTile(
                                            // leading:
                                            onTap: () {
                                              task.list
                                                  .remove(task.list[index]);
                                              task.list.refresh();
                                            },
                                            title: GradientText(
                                              task.list[index],
                                              textScaleFactor: 2,
                                              gradientType: GradientType.linear,
                                              // radius: 200,
                                              colors: [
                                                Color.fromARGB(
                                                    255, 184, 43, 32),
                                                Color.fromARGB(
                                                    255, 81, 47, 138),
                                                Color.fromARGB(
                                                    255, 105, 208, 198)
                                              ],
                                              style: GoogleFonts.sacramento(
                                                  fontWeight: FontWeight.w100),
                                            ),

                                            // .value.text.amber300
                                            // .make()
                                          ),
                                        ).pLTRB(0, 5, 0, 5),
                                      ),
                                    );
                                  })),
                            ),
                          ],
                        ),
                      ),
                    )),
                //-------------graph-------------------for productive time-----------------------------------------
                GradientText(
                  "Time Vs Days",
                  textScaleFactor: 3,
                  gradientType: GradientType.linear,
                  // radius: 200,
                  colors: [
                    Color.fromARGB(255, 213, 85, 46),
                    Color.fromARGB(255, 81, 47, 138),
                    Color.fromARGB(255, 105, 208, 198)
                  ],
                  style: GoogleFonts.sacramento(fontWeight: FontWeight.w500),
                ).pLTRB(MediaQuery.of(context).size.height * 0.0, 0, 0, 0),
                Container(
                  height: 200,
                  width: double.maxFinite,
                  child: BarChart(
                    BarChartData(
                        borderData: FlBorderData(
                            border: const Border(
                          top: BorderSide.none,
                          right: BorderSide.none,
                          left: BorderSide(width: 1),
                          bottom: BorderSide(width: 1),
                        )),
                        groupsSpace: 10,
                        barGroups: [
                          BarChartGroupData(x: 1, barRods: [
                            BarChartRodData(
                                toY: 10,
                                width: 5,
                                color: Color.fromARGB(255, 127, 139, 211)),
                          ]),
                          BarChartGroupData(x: 2, barRods: [
                            BarChartRodData(
                                toY: 9,
                                width: 5,
                                color: Color.fromARGB(255, 127, 139, 211)),
                          ]),
                          BarChartGroupData(x: 3, barRods: [
                            BarChartRodData(
                                toY: 4,
                                width: 5,
                                color: Color.fromARGB(255, 127, 139, 211)),
                          ]),
                          BarChartGroupData(x: 4, barRods: [
                            BarChartRodData(
                                toY: 2,
                                width: 5,
                                color: Color.fromARGB(255, 127, 139, 211)),
                          ]),
                          BarChartGroupData(x: 5, barRods: [
                            BarChartRodData(
                                toY: 13,
                                width: 5,
                                color: Color.fromARGB(255, 127, 139, 211)),
                          ]),
                          BarChartGroupData(x: 6, barRods: [
                            BarChartRodData(
                                toY: 17,
                                width: 5,
                                color: Color.fromARGB(255, 127, 139, 211)),
                          ]),
                          BarChartGroupData(x: 7, barRods: [
                            BarChartRodData(
                                toY: 19,
                                width: 5,
                                color: Color.fromARGB(255, 127, 139, 211)),
                          ]),
                        ]),
                  ),
                ).p(10),
                //-------------graph-------------------money spend -----------------------------------------

                GradientText(
                  "Money VS Days",
                  textScaleFactor: 3,
                  gradientType: GradientType.linear,
                  // radius: 200,
                  colors: [
                    Color.fromARGB(255, 213, 85, 46),
                    Color.fromARGB(255, 81, 47, 138),
                    Color.fromARGB(255, 105, 208, 198)
                  ],
                  style: GoogleFonts.sacramento(fontWeight: FontWeight.w500),
                ).pLTRB(MediaQuery.of(context).size.height * 0.0, 0, 0, 0),
                Container(
                  height: 200,
                  width: double.maxFinite,
                  child: BarChart(
                    BarChartData(
                        borderData: FlBorderData(
                            border: const Border(
                          top: BorderSide.none,
                          right: BorderSide.none,
                          left: BorderSide(width: 1),
                          bottom: BorderSide(width: 1),
                        )),
                        groupsSpace: 10,
                        barGroups: [
                          BarChartGroupData(x: 1, barRods: [
                            BarChartRodData(
                                toY: 10,
                                width: 5,
                                color: Color.fromARGB(255, 127, 139, 211)),
                          ]),
                          BarChartGroupData(x: 2, barRods: [
                            BarChartRodData(
                                toY: 19,
                                width: 5,
                                color: Color.fromARGB(255, 127, 139, 211)),
                          ]),
                          BarChartGroupData(x: 3, barRods: [
                            BarChartRodData(
                                toY: 9,
                                width: 5,
                                color: Color.fromARGB(255, 127, 139, 211)),
                          ]),
                          BarChartGroupData(x: 4, barRods: [
                            BarChartRodData(
                                toY: 12,
                                width: 5,
                                color: Color.fromARGB(255, 127, 139, 211)),
                          ]),
                          BarChartGroupData(x: 5, barRods: [
                            BarChartRodData(
                                toY: 3,
                                width: 5,
                                color: Color.fromARGB(255, 127, 139, 211)),
                          ]),
                          BarChartGroupData(x: 6, barRods: [
                            BarChartRodData(
                                toY: 7,
                                width: 5,
                                color: Color.fromARGB(255, 127, 139, 211)),
                          ]),
                          BarChartGroupData(x: 7, barRods: [
                            BarChartRodData(
                                toY: 19,
                                width: 5,
                                color: Color.fromARGB(255, 127, 139, 211)),
                          ]),
                        ]),
                  ),
                ).p(10),

                //---------------------------------pie chart for task with time-------------------------
                GradientText(
                  "Task with Time",
                  textScaleFactor: 3,
                  gradientType: GradientType.linear,
                  // radius: 200,
                  colors: [
                    Color.fromARGB(255, 213, 85, 46),
                    Color.fromARGB(255, 81, 47, 138),
                    Color.fromARGB(255, 105, 208, 198)
                  ],
                  style: GoogleFonts.sacramento(fontWeight: FontWeight.w500),
                ).pLTRB(MediaQuery.of(context).size.height * 0.0, 0, 0, 0),
                Container(
                  height: 100,
                  width: 100,
                  child: PieChart(PieChartData(
                      // sectionsSpace: 0,
                      centerSpaceRadius: 120,
                      borderData: FlBorderData(
                          show: false,
                          border: Border.all(color: Colors.black, width: 5)),
                      // centerSpaceRadius: 5,
                      sections: <PieChartSectionData>[
                        PieChartSectionData(
                            value: 20,
                            color: Colors.deepOrange,
                            title: "task1"),
                        PieChartSectionData(
                            value: 20,
                            color: Color.fromARGB(255, 172, 117, 214),
                            title: "task2"),
                        PieChartSectionData(
                            value: 20,
                            color: Color.fromARGB(255, 119, 235, 229),
                            title: "task3"),
                        PieChartSectionData(
                            value: 8,
                            color: Color.fromARGB(255, 185, 69, 111),
                            title: "task4"),
                        PieChartSectionData(
                            value: 10,
                            color: Color.fromARGB(255, 186, 211, 98),
                            title: "task5"),
                      ])),
                ).pLTRB(0, 140, 0, 140),
                GradientText(
                  " Money Spent on items",
                  textScaleFactor: 3,
                  gradientType: GradientType.linear,
                  // radius: 200,
                  colors: [
                    Color.fromARGB(255, 213, 85, 46),
                    Color.fromARGB(255, 81, 47, 138),
                    Color.fromARGB(255, 105, 208, 198)
                  ],
                  style: GoogleFonts.sacramento(fontWeight: FontWeight.w500),
                ).pLTRB(MediaQuery.of(context).size.height * 0.0, 0, 0, 0),
                Container(
                  height: 100,
                  width: 100,
                  child: PieChart(PieChartData(
                      // sectionsSpace: 0,
                      centerSpaceRadius: 120,
                      borderData: FlBorderData(
                          show: false,
                          border: Border.all(color: Colors.black, width: 5)),
                      // centerSpaceRadius: 5,
                      sections: <PieChartSectionData>[
                        PieChartSectionData(
                            value: 40,
                            color: Colors.deepOrange,
                            title: "item 1"),
                        PieChartSectionData(
                            value: 20,
                            color: Color.fromARGB(255, 172, 117, 214),
                            title: "item 2"),
                        PieChartSectionData(
                            value: 50,
                            color: Color.fromARGB(255, 119, 235, 229),
                            title: "item 3"),
                        PieChartSectionData(
                            value: 80,
                            color: Color.fromARGB(255, 185, 69, 111),
                            title: "item 4"),
                        PieChartSectionData(
                            value: 100,
                            color: Color.fromARGB(255, 186, 211, 98),
                            title: "item 5"),
                      ])),
                ).pLTRB(0, 140, 0, 0)
              ]),
            ).pLTRB(0, 220, 0, 0),
          ],
        ),
      ]),
    )));
  }
}
