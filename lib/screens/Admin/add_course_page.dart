import '../../cache/constants.dart';
import '../../cache/local_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:domapp/cache/models.dart';

final courseTitleController = TextEditingController();
final courseIDController = TextEditingController();

String selectedBranch = branchList.first;
String selectedProfessor = professorList.first.name;

class AddCoursePage extends StatelessWidget {
  static const String route = 'AddCoursePage';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: kOuterPadding,
              child: Column(
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
                    'Add Course',
                    style: TextStyle(
                      color: kWhite,
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 10),
                  CourseTitleWrapper(),
                  SizedBox(height: 10),
                  DepartmentCourseIDWrapper(),
                  SizedBox(height: 10),
                  ProfessorWrapper(),
                  SizedBox(height: size.height * 0.15),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                              color: kWhite.withOpacity(0.2),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10))),
                          child: Row(
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
                                child: SvgPicture.asset(
                                  'assets/icons/verify_filled.svg',
                                  color: kColorBackgroundDark.withOpacity(0.8),
                                  height: 20,
                                ),
                              ),
                              SizedBox(width: 16),
                              Container(
                                child: Flexible(
                                  child: Text(
                                    disclaimerText,
                                    style:
                                        TextStyle(fontSize: 11, color: kWhite),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          // onTap: () => Navigator.pushNamed(context, HomePage.route),
                          child: Container(
                            // margin: EdgeInsets.only(bottom: size.height * 0.1),
                            padding: EdgeInsets.symmetric(vertical: 20),
                            alignment: Alignment.center,
                            width: size.width * 0.8,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: kWhite.withOpacity(0.55),
                                  blurRadius: 1,
                                  offset: Offset(0, 4),
                                )
                              ],
                              color: kWhite,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)),
                            ),
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                  color: kColorBackgroundDark,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfessorWrapper extends StatefulWidget {
  @override
  _ProfessorWrapperState createState() => _ProfessorWrapperState();
}

class _ProfessorWrapperState extends State<ProfessorWrapper> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Professor',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: kInactiveText,
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: size.width * 0.9,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 2,
                color: Color(0XFF413F49),
              ),
              color: Color(0XFF1D1C23),
            ),
            margin: EdgeInsets.symmetric(vertical: 8),
            child: DropdownButton(
              dropdownColor: kColorBackgroundDark,
              icon: SvgPicture.asset(
                'assets/icons/expand_down.svg',
                color: kWhite,
              ),
              iconSize: 20,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: kWhite,
              ),
              isExpanded: true,
              isDense: true,
              value: selectedProfessor,
              items: professorList.map((Professor value) {
                return DropdownMenuItem<String>(
                  child: Text(
                    value.name,
                  ),
                  value: value.name,
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedProfessor = value.toString();
                });
              },
              underline: Container(
                height: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DepartmentCourseIDWrapper extends StatefulWidget {
  @override
  _DepartmentCourseIDWrapperState createState() =>
      _DepartmentCourseIDWrapperState();
}

class _DepartmentCourseIDWrapperState extends State<DepartmentCourseIDWrapper> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Department',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                color: kInactiveText,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: size.width * 0.6,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  width: 2,
                  color: Color(0XFF413F49),
                ),
                color: Color(0XFF1D1C23),
              ),
              margin: EdgeInsets.symmetric(vertical: 8),
              child: DropdownButton(
                dropdownColor: kColorBackgroundDark,
                icon: SvgPicture.asset(
                  'assets/icons/expand_down.svg',
                  color: kWhite,
                ),
                iconSize: 20,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: kWhite,
                ),
                isExpanded: true,
                isDense: true,
                value: selectedBranch,
                items: branchList.map((value) {
                  return DropdownMenuItem<String>(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedBranch = value.toString();
                  });
                },
                underline: Container(
                  height: 0,
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Course ID',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                color: kInactiveText,
              ),
            ),
            Container(
              width: size.width * 0.2,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: kWhite,
                ),
                controller: courseIDController,
                maxLength: 4,
                decoration: InputDecoration(
                    counterText: '',
                    fillColor: Color(0XFF1D1C23),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Color(0XFF413F49),
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Color(0XFF413F49),
                        width: 2.0,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(10),
                    hintText: '213',
                    hintStyle: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: kInactiveText,
                    )),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CourseTitleWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Course Title',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
            color: kInactiveText,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          child: TextFormField(
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: kWhite,
            ),
            controller: courseTitleController,
            decoration: InputDecoration(
                fillColor: Color(0XFF1D1C23),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0XFF413F49),
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0XFF413F49),
                    width: 2.0,
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                hintText: 'Dynamics of Social Change',
                hintStyle: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                  color: kInactiveText,
                )),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: size.width * 0.6,
            child: Text(
              'please input the full course name, as mentioned in the handout',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
                color: kInactiveText,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
