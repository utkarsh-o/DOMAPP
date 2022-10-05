import 'package:domapp/cache/constants.dart';
import 'package:domapp/screens/Acads/helper/helper.dart';
import 'package:domapp/screens/Approvals/upload_question_paper_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../HiveDB/Course.dart';
import '../../HiveDB/Paper.dart';
import '../../cache/models.dart' as m;

class PreviousYearsPapersPage extends StatefulWidget {
  final Course? course;
  PreviousYearsPapersPage({this.course});
  static const String route = 'PreviousYearsPage';

  @override
  State<PreviousYearsPapersPage> createState() =>
      _PreviousYearsPapersPageState();
}

class _PreviousYearsPapersPageState extends State<PreviousYearsPapersPage> {
  late List<Paper> papers;
  late ValueNotifier<List<Paper>> filteredPapers;
  @override
  void initState() {
    super.initState();
    getPapersFromCourse(courseID: widget.course!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: kOuterPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(context),
                      child: SvgPicture.asset(
                        'assets/icons/back_button_title_bar.svg',
                        color: kWhite,
                      ),
                    ),
                  ),
                  Text(
                    'Previous Years Papers',
                    style: TextStyle(
                      color: kWhite,
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 30),
                  ValueListenableBuilder(
                    valueListenable: Hive.box('papers')
                        .listenable(keys: [widget.course!.uid]),
                    builder: (context, Box box, _widget) {
                      final List<Paper> papers = box.get(widget.course!.uid,
                          defaultValue: <Paper>[]).cast<Paper>();
                      final ValueNotifier<List<Paper>> filteredPapers =
                          ValueNotifier(papers
                            ..sort((Paper a, Paper b) => b.date.year
                                .toString()
                                .compareTo(a.date.year.toString())));
                      final List<String> evaluativeList = ['all'] +
                          papers.map((Paper p) => p.paperType).toSet().toList();
                      final List<String> sessionList = papers
                          .map((Paper p) => p.date.year.toString())
                          .toSet()
                          .toList();
                      if (papers.length == 0) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: kWhite,
                        ));
                      }
                      return Column(
                        children: [
                          GreenContainer(
                            course: widget.course!,
                            papers: papers,
                            filteredPapers: filteredPapers,
                            yearList: sessionList,
                            evaluativesList: evaluativeList,
                          ),
                          ValueListenableBuilder(
                              valueListenable: filteredPapers,
                              builder: (context, List<Paper> filteredPapers,
                                  widget) {
                                return ListView.separated(
                                  itemCount: filteredPapers.length,
                                  shrinkWrap: true,
                                  separatorBuilder: (context, int) => Container(
                                    color: kColorBackgroundDark,
                                    width: 100,
                                    height: 1,
                                  ),
                                  itemBuilder: (BuildContext context, int i) {
                                    return InkWell(
                                      onTap: () async {
                                        print(filteredPapers[i].paperUrl);
                                        await launchUrlString(
                                          filteredPapers[i].paperUrl,
                                          mode: LaunchMode.externalApplication,
                                        );
                                      },
                                      child: YellowContainer(
                                        index: i % 3,
                                        paper: filteredPapers[i],
                                      ),
                                    );
                                  },
                                );
                              }),
                          // for (int i = 0; i < papers.length; i++)
                          //   // Positioned(
                          //   //   bottom: -50 - i * 50,
                          //   //   width: size.width * 0.845,
                          //   //   child:
                          //   InkWell(
                          //     onTap: () async {
                          //       await launchUrlString(
                          //         papers[i].paperUrl,
                          //         mode: LaunchMode.externalApplication,
                          //       );
                          //     },
                          //     child: YellowContainer(
                          //       index: i % 3,
                          //       paper: papers[i],
                          //     ),
                          //   ),
                          // ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              // Center(
              //   child: Container(
              //     margin: EdgeInsets.symmetric(vertical: 20),
              //     width: size.width * 0.6,
              //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              //     decoration: BoxDecoration(
              //         color: kRed,
              //         borderRadius: BorderRadius.circular(10),
              //         boxShadow: [
              //           BoxShadow(
              //               color: kRed.withOpacity(0.65),
              //               offset: Offset(0, 3),
              //               blurRadius: 1),
              //         ]),
              //     child: InkWell(
              //       onTap: () => Navigator.pushNamed(
              //           context, SolutionDiscussionThread.route),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Text(
              //             'Solution Discussion',
              //             style: TextStyle(
              //                 fontWeight: FontWeight.w600,
              //                 fontSize: 16,
              //                 color: kColorBackgroundDark),
              //           ),
              //           SizedBox(
              //             width: size.width * 0.03,
              //           ),
              //           Container(
              //             padding: EdgeInsets.all(6),
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(7),
              //               color: kWhite,
              //               boxShadow: [
              //                 BoxShadow(
              //                     color: kColorBackgroundDark.withOpacity(0.45),
              //                     offset: Offset(0, 4),
              //                     blurRadius: 1),
              //               ],
              //             ),
              //             child:
              //                 SvgPicture.asset('assets/icons/expand_right.svg'),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class YellowContainer extends StatelessWidget {
  final int index;
  final Paper paper;
  YellowContainer({required this.index, required this.paper});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: kYellow,
        boxShadow: [
          BoxShadow(
            color: index == 0
                ? kColorBackgroundDark.withOpacity(0.35)
                : kYellow.withOpacity(0.35),
            blurRadius: 1,
            offset: Offset(0, 4),
          )
        ],
        // borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          // SizedBox(height: size.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                paper.professor.name,
                style: TextStyle(
                    color: kColorBackgroundDark.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              Row(
                children: [
                  Text(
                    DateFormat.y().format(paper.date) +
                        ' (${paper.sem == 1 ? 'I' : 'II'})',
                    style: TextStyle(
                        color: kColorBackgroundDark.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  SizedBox(width: size.width * 0.04),
                  InkWell(
                    onTap: () async {
                      await launchUrlString(
                        paper.paperUrl,
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: kWhite,
                        boxShadow: [
                          BoxShadow(
                              color: kColorBackgroundDark.withOpacity(0.45),
                              offset: Offset(0, 4),
                              blurRadius: 1),
                        ],
                      ),
                      child: SvgPicture.asset('assets/icons/expand_right.svg'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GreenContainer extends StatelessWidget {
  GreenContainer({
    Key? key,
    required this.course,
    required this.filteredPapers,
    required this.yearList,
    required this.evaluativesList,
    required this.papers,
  })  : selectedEvaluative = ValueNotifier(evaluativesList.first),
        selectedYear = ValueNotifier(yearList.first);
  final Course course;
  final List<Paper> papers;
  final ValueNotifier<List<Paper>> filteredPapers;
  final List<String> yearList;
  final List<String> evaluativesList;
  ValueNotifier<String?> selectedYear;
  ValueNotifier<String?> selectedEvaluative;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: 500,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: kGreen,
        boxShadow: [
          BoxShadow(
            color: kGreen.withOpacity(0.65),
            blurRadius: 1,
            offset: Offset(0, 4),
          )
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            course.name,
            style: TextStyle(
                color: kColorBackgroundDark.withOpacity(0.8),
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          SizedBox(height: size.height * 0.015),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              //   width: size.width * 0.25,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     color: kWhite,
              //     boxShadow: [
              //       BoxShadow(
              //           color: kColorBackgroundDark.withOpacity(0.45),
              //           offset: Offset(0, 4),
              //           blurRadius: 1),
              //     ],
              //   ),
              //   child: ValueListenableBuilder(
              //       valueListenable: selectedYear,
              //       builder: (context, String? value, child) {
              //         return DropdownButton(
              //           icon: SvgPicture.asset(
              //             'assets/icons/expand_down.svg',
              //           ),
              //           iconSize: 20,
              //           style: TextStyle(
              //               fontSize: 14,
              //               fontWeight: FontWeight.w600,
              //               color: kColorBackgroundDark,
              //               fontFamily: 'Montserrat'),
              //           isExpanded: true,
              //           isDense: true,
              //           value: value,
              //           items: yearList.map((value) {
              //             return DropdownMenuItem<String>(
              //               child: Text(value),
              //               value: value,
              //             );
              //           }).toList(),
              //           onChanged: (String? year) {
              //             selectedYear.value = year;
              //             filteredPapers.value = papers.where((Paper ppr) {
              //               return ppr.date.year.toString() == year &&
              //                   ppr.paperType == selectedEvaluative.value;
              //             }).toList();
              //           },
              //           underline: Container(height: 0),
              //         );
              //       }),
              // ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kWhite,
                  boxShadow: [
                    BoxShadow(
                        color: kColorBackgroundDark.withOpacity(0.45),
                        offset: Offset(0, 4),
                        blurRadius: 1),
                  ],
                ),
                child: ValueListenableBuilder(
                    valueListenable: selectedEvaluative,
                    builder: (context, value, widget) {
                      return DropdownButton(
                        icon: SvgPicture.asset(
                          'assets/icons/expand_down.svg',
                        ),
                        iconSize: 20,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: kColorBackgroundDark,
                            fontFamily: 'Montserrat'),
                        isExpanded: true,
                        isDense: true,
                        value: selectedEvaluative.value,
                        items: evaluativesList.map((value) {
                          return DropdownMenuItem<String>(
                            child: Text(value),
                            value: value,
                          );
                        }).toList(),
                        onChanged: (String? paperType) {
                          selectedEvaluative.value = paperType;
                          if (paperType == m.PaperType.all)
                            filteredPapers.value = papers
                              ..sort((Paper a, Paper b) => b.date.year
                                  .toString()
                                  .compareTo(a.date.year.toString()));
                          else {
                            filteredPapers.value = papers
                                .where((Paper ppr) => ppr.paperType == paperType
                                    //     &&
                                    // ppr.date.year.toString() ==
                                    //     selectedYear.value
                                    )
                                .toList()
                              ..sort((Paper a, Paper b) => b.date.year
                                  .toString()
                                  .compareTo(a.date.year.toString()));
                          }
                        },
                        underline: Container(height: 0),
                      );
                    }),
              ),
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: kWhite,
                  boxShadow: [
                    BoxShadow(
                        color: kColorBackgroundDark.withOpacity(0.45),
                        offset: Offset(0, 4),
                        blurRadius: 1),
                  ],
                ),
                child: SvgPicture.asset('assets/icons/expand_right.svg'),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
                bottom: size.height * 0.01, top: size.height * 0.025),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: kWhite,
                          boxShadow: [
                            BoxShadow(
                                color: kColorBackgroundDark.withOpacity(0.45),
                                offset: Offset(0, 4),
                                blurRadius: 1),
                          ],
                        ),
                        child: SvgPicture.asset('assets/icons/star_filled.svg'),
                      ),
                      SizedBox(width: size.width * 0.04),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UploadQuestionPaperPage(
                                course: course,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: kWhite,
                            boxShadow: [
                              BoxShadow(
                                  color: kColorBackgroundDark.withOpacity(0.45),
                                  offset: Offset(0, 4),
                                  blurRadius: 1),
                            ],
                          ),
                          child: SvgPicture.asset('assets/icons/add_file.svg'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: kWhite,
                          boxShadow: [
                            BoxShadow(
                                color: kColorBackgroundDark.withOpacity(0.45),
                                offset: Offset(0, 4),
                                blurRadius: 1),
                          ],
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/report_filled.svg',
                              color: kRed,
                              height: 20,
                            ),
                            SizedBox(width: size.width * 0.02),
                            Text(
                              '4',
                              style: TextStyle(
                                  color: kRed,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: size.width * 0.04),
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: kWhite,
                          boxShadow: [
                            BoxShadow(
                                color: kColorBackgroundDark.withOpacity(0.45),
                                offset: Offset(0, 4),
                                blurRadius: 1),
                          ],
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/verify_filled.svg',
                              color: kGreen,
                              height: 20,
                            ),
                            SizedBox(width: size.width * 0.02),
                            Text(
                              '71',
                              style: TextStyle(
                                  color: kGreen,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
