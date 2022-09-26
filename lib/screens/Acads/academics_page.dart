import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../HiveDB/Course.dart';
import '../../cache/local_data.dart';
import 'choose_course_page.dart';
import 'helper/helper.dart';
import 'previous_years_papers_page.dart';
import '../slides_page.dart';
import '../../cache/constants.dart';

class AcademicsPage extends StatefulWidget {
  static const String route = 'AcademicsPage';
  @override
  _AcademicsPageState createState() => _AcademicsPageState();
}

class _AcademicsPageState extends State<AcademicsPage> {
  @override
  initState() {
    super.initState();
    getAllCourses();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 30),
          child: InkWell(
            onTap: () async {
              Hive.box('papers').delete('LLo9Uq3r2D8yNobxCwEu');
              Hive.box('papers').delete('yWzScYHOTVlBAc8CTNAs');
            },
            child: SvgPicture.asset(
              'assets/icons/options_button_titlebar.svg',
              color: kWhite,
            ),
          ),
        ),
        SortAddWrapper(),
        SizedBox(height: size.height * 0.03),
        SelectedCoursesList(),
        // BreakLine(),
      ],
    );
  }
}

class SelectedCoursesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ValueListenableBuilder(
        valueListenable:
            Hive.box('userData').listenable(keys: ['pickedCourses']),
        builder: (context, Box box, widget) {
          final List<Course> pickedCourses =
              box.get('pickedCourses', defaultValue: <Course>[]).cast<Course>();
          return Expanded(
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 15);
              },
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                  // height: 50,
                  decoration: BoxDecoration(
                    color: colourList[index % 3],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: colourList[index % 3].withOpacity(0.65),
                          offset: Offset(0, 3),
                          blurRadius: 1),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pickedCourses[index].name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kColorBackgroundDark.withOpacity(0.8),
                            fontSize: 16),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SlidesPage(
                                  course: pickedCourses[index],
                                ),
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: kWhite,
                                boxShadow: [
                                  BoxShadow(
                                      color: kColorBackgroundDark
                                          .withOpacity(0.45),
                                      offset: Offset(0, 4),
                                      blurRadius: 1),
                                ],
                              ),
                              child: Text(
                                'Slides',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PreviousYearsPapersPage(
                                      course: pickedCourses[index]),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: kWhite,
                                boxShadow: [
                                  BoxShadow(
                                      color: kColorBackgroundDark
                                          .withOpacity(0.45),
                                      offset: Offset(0, 4),
                                      blurRadius: 1),
                                ],
                              ),
                              child: Text(
                                'Previous Year Papers',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: kWhite,
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        kColorBackgroundDark.withOpacity(0.45),
                                    offset: Offset(0, 4),
                                    blurRadius: 1),
                              ],
                            ),
                            child: Text(
                              'Related Books',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: kWhite,
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        kColorBackgroundDark.withOpacity(0.45),
                                    offset: Offset(0, 4),
                                    blurRadius: 1),
                              ],
                            ),
                            child: Text(
                              'Notes & more',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              itemCount: pickedCourses.length,
            ),
          );
        });
  }
}

class SortAddWrapper extends StatefulWidget {
  @override
  _SortAddWrapperState createState() => _SortAddWrapperState();
}

List<String> sortMethods = ['Alphabetically', 'Last Used', 'Last Added'];
String? selectedSort = sortMethods.first;

class _SortAddWrapperState extends State<SortAddWrapper> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: size.width * 0.75,
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            color: kBlue,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: kBlue.withOpacity(0.65),
                  offset: Offset(0, 3),
                  blurRadius: 1),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              width: size.width * 0.4,
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
              child: DropdownButton(
                icon: SvgPicture.asset(
                  'assets/icons/expand_down.svg',
                ),
                iconSize: 20,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: kColorBackgroundDark,
                    fontFamily: 'Montserrat'),
                isExpanded: true,
                isDense: true,
                value: selectedSort,
                items: sortMethods.map((value) {
                  return DropdownMenuItem<String>(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedSort = value;
                  });
                },
                underline: Container(
                  height: 0,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.pushNamed(context, ChooseCoursePage.route),
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
      ),
    );
  }
}

class BreakLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 1,
      width: size.width,
      decoration: BoxDecoration(
        color: Color(0XFF706F75),
        borderRadius: BorderRadius.circular(3),
        boxShadow: [
          BoxShadow(
            color: Color(0XFF706F75),
            blurRadius: 1,
          ),
        ],
      ),
    );
  }
}
