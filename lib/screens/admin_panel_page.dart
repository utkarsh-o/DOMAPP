import 'package:domapp/screens/add_course_page.dart';
import 'package:domapp/screens/add_professor_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../cache/constants.dart';
import '../cache/models.dart';
import '../cache/local_data.dart';
import 'course_review_page.dart';

class AdminPanelPage extends StatelessWidget {
  static const String route = 'AdminPanelPage';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: kOuterPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                child: InkWell(
                  onTap: () => Navigator.of(context).pop,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(context),
                    child: SvgPicture.asset(
                      'assets/icons/back_button_titlebar.svg',
                      color: kWhite,
                    ),
                  ),
                ),
              ),
              Text(
                'Admin Panel',
                style: TextStyle(
                  color: kWhite,
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, AddProfessorPage.route),
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
                      SvgPicture.asset('assets/icons/professor.svg'),
                      SizedBox(width: size.width * 0.06),
                      Text(
                        'Add Professor',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: kDarkBackgroundColour.withOpacity(0.7)),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.pushNamed(context, AddCoursePage.route),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
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
                      SvgPicture.asset('assets/icons/course.svg'),
                      SizedBox(width: size.width * 0.06),
                      Text(
                        'Add Course',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: kDarkBackgroundColour.withOpacity(0.7)),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, CourseReviewPage.route),
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
                      SvgPicture.asset('assets/icons/timetable.svg'),
                      SizedBox(width: size.width * 0.06),
                      Text(
                        'Raise a Ticket',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: kDarkBackgroundColour.withOpacity(0.7)),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Approve Actions ',
                style: TextStyle(
                  color: kWhite,
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return AdminActionsListBuilder(
                        currentAction: adminActionsList[index],
                        index: index,
                      );
                    },
                    itemCount: adminActionsList.length),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AdminActionsListBuilder extends StatelessWidget {
  final AdminAction currentAction;
  final int index;
  AdminActionsListBuilder({required this.currentAction, required this.index});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      // onTap: () => Navigator.pushNamed(context, SelectedCourseReviewPage.route),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(minHeight: size.height * 0.1),
                width: 10,
                color: colourList[index % 3],
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentAction.title,
                      style: TextStyle(
                          fontFamily: 'Satisfy', fontSize: 18, color: kWhite),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        currentAction.user.type == 'admin'
                            ? SvgPicture.asset('assets/icons/admin.svg',
                                height: 15)
                            : SvgPicture.asset('assets/icons/member.svg',
                                height: 15),
                        SizedBox(width: 8),
                        Text(
                          currentAction.user.fullName,
                          style: TextStyle(fontSize: 12, color: kWhite),
                        ),
                      ],
                    ),
                  ],
                ),
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
                            color: kWhite.withOpacity(0.45),
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
                          currentAction.reports.toString(),
                          style: TextStyle(
                              color: kRed,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: kWhite,
                      boxShadow: [
                        BoxShadow(
                            color: kWhite.withOpacity(0.45),
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
                          currentAction.approvals.toString(),
                          style: TextStyle(
                              color: kGreen,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
