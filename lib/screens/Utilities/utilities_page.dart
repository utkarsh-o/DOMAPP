import 'package:domapp/screens/Admin/admin_panel_page.dart';
import 'package:domapp/screens/Utilities/course_review_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../cache/constants.dart';
import 'professor_review_page.dart';

class UtilitiesPage extends StatelessWidget {
  static const String route = 'UtilitiesPage';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: InkWell(
                onTap: () => Navigator.of(context).pop,
                child: SvgPicture.asset(
                  'assets/icons/options_button_titlebar.svg',
                  color: kWhite,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.pushNamed(context, AdminPanelPage.route),
              child: Container(
                decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                          color: kWhite.withOpacity(0.65),
                          offset: Offset(0, 3),
                          blurRadius: 1),
                    ]),
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/admin.svg',
                      height: 20,
                      color: kColorBackgroundDark,
                    ),
                    SizedBox(width: size.width * 0.015),
                    Text(
                      'Admin Panel',
                      style: TextStyle(
                          color: kColorBackgroundDark,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        InkWell(
          onTap: () => Navigator.pushNamed(context, ProfessorReviewPage.route),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
                color: kGreen,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: kGreen.withOpacity(0.65),
                      blurRadius: 1,
                      offset: Offset(0, 4))
                ]),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/professor.svg',
                  width: 40,
                ),
                SizedBox(width: size.width * 0.06),
                Text(
                  'Professor Review',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: kColorBackgroundDark.withOpacity(0.7)),
                )
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
              color: kYellow,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: kYellow.withOpacity(0.65),
                    blurRadius: 1,
                    offset: Offset(0, 4))
              ]),
          child: Row(
            children: [
              SvgPicture.asset('assets/icons/timetable.svg', width: 40),
              SizedBox(width: size.width * 0.06),
              Text(
                'Time Table Checker',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: kColorBackgroundDark.withOpacity(0.7)),
              )
            ],
          ),
        ),
        InkWell(
          onTap: () => Navigator.pushNamed(context, CourseReviewPage.route),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
                color: kRed,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: kRed.withOpacity(0.65),
                      blurRadius: 1,
                      offset: Offset(0, 4))
                ]),
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/course.svg', width: 40),
                SizedBox(width: size.width * 0.06),
                Text(
                  'Course Review',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: kColorBackgroundDark.withOpacity(0.7)),
                )
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
              color: kGreen,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: kGreen.withOpacity(0.65),
                    blurRadius: 1,
                    offset: Offset(0, 4))
              ]),
          child: Row(
            children: [
              SvgPicture.asset('assets/icons/areaChart.svg', width: 40),
              SizedBox(width: size.width * 0.06),
              Text(
                'SG / CG Estimator',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: kColorBackgroundDark.withOpacity(0.7)),
              )
            ],
          ),
        ),
        BreakLine(),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 80,
                margin: EdgeInsets.symmetric(vertical: 15),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                decoration: BoxDecoration(
                    color: kGreen,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: kGreen.withOpacity(0.65),
                          blurRadius: 1,
                          offset: Offset(0, 4))
                    ]),
                child: Column(
                  children: [
                    SvgPicture.asset('assets/icons/eatery.svg', width: 32),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      'Menus',
                      style: TextStyle(
                        color: kColorBackgroundDark.withOpacity(0.7),
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: size.width * 0.2,
                margin: EdgeInsets.symmetric(vertical: 15),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: BoxDecoration(
                    color: kYellow,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: kYellow.withOpacity(0.65),
                          blurRadius: 1,
                          offset: Offset(0, 4))
                    ]),
                child: Column(
                  children: [
                    SvgPicture.asset('assets/icons/polls.svg', height: 40),
                    SizedBox(height: size.height * 0.01),
                    Text('Polls',
                        style: TextStyle(
                          color: kColorBackgroundDark.withOpacity(0.7),
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ))
                  ],
                ),
              ),
              Container(
                width: size.width * 0.2,
                margin: EdgeInsets.symmetric(vertical: 15),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: BoxDecoration(
                    color: kRed,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: kRed.withOpacity(0.65),
                          blurRadius: 1,
                          offset: Offset(0, 4))
                    ]),
                child: Column(
                  children: [
                    SvgPicture.asset('assets/icons/tests.svg', height: 40),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      'Tests',
                      style: TextStyle(
                          color: kColorBackgroundDark.withOpacity(0.7),
                          fontWeight: FontWeight.w800,
                          fontSize: 14),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
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
