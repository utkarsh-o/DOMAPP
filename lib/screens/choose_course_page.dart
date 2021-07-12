import 'package:domapp/cache/local_data.dart';
import 'package:domapp/cache/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../cache/constants.dart';

List<String> sortMethods = [
  'Rating',
  'Alphabetically',
  'Joining Year',
];
List<String> branchList = [
  'M.Sc. Math',
  'M.Sc. Chem',
  'CSE',
  'Mechanical',
  'Humanities'
];

String? selectedBranch = branchList.first;
String? selectedSort = sortMethods.first;
TextEditingController filterController = TextEditingController();

enum ButtonType {
  professorReview,
  courseReview,
  pickedCourse,
  unpickedCourse,
}

class ChooseCoursePage extends StatefulWidget {
  static const String route = 'ChooseCoursePage';

  @override
  _ChooseCoursePageState createState() => _ChooseCoursePageState();
}

class _ChooseCoursePageState extends State<ChooseCoursePage> {
  String query = '';
  List<Course> filteredCourses = courseList;

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
                  onTap: () => Navigator.of(context).pop(context),
                  child: SvgPicture.asset(
                    'assets/icons/back_button_titlebar.svg',
                    color: kWhite,
                  ),
                ),
              ),
              Text(
                'Choose Course',
                style: TextStyle(
                  color: kWhite,
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                ),
              ),
              SortFilterWrapper(onChanged: searchCourse),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      Course currentCourse = filteredCourses[index];
                      return Container(
                        decoration: BoxDecoration(
                            color: listColours[index % 3],
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 1,
                                offset: Offset(0, 4),
                                color: listColours[index % 3].withOpacity(0.45),
                              )
                            ]),
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentCourse.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: kDarkBackgroundColour.withOpacity(0.8),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          currentCourse.professor.name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11,
                                            color: kDarkBackgroundColour
                                                .withOpacity(0.6),
                                          ),
                                        ),
                                        Text(
                                          '${currentCourse.getIDName()} F${currentCourse.idNumber}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11,
                                            color: kDarkBackgroundColour
                                                .withOpacity(0.6),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        ListItemBottomButton(
                                          buttonType:
                                              ButtonType.professorReview,
                                        ),
                                        SizedBox(width: size.width * 0.02),
                                        ListItemBottomButton(
                                          buttonType: ButtonType.courseReview,
                                        ),
                                        SizedBox(width: size.width * 0.02),
                                        ListItemBottomButton(
                                          buttonType: pickedCourses
                                                  .contains(currentCourse)
                                              ? ButtonType.pickedCourse
                                              : ButtonType.unpickedCourse,
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
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: size.height * 0.02,
                      );
                    },
                    itemCount: filteredCourses.length),
              )
            ],
          ),
        ),
      ),
    );
  }

  void searchCourse(String query) {
    final result = courseList.where((course) {
      final titleLower = course.title.toLowerCase();
      final professorLower = course.professor.name.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          professorLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.filteredCourses = result;
    });
  }
}

class ListItemBottomButton extends StatelessWidget {
  final ButtonType buttonType;
  Function? callback;
  ListItemBottomButton({required this.buttonType, this.callback});
  getCourseReview() {}
  getProfessorReview() {}
  Function? getOnTap() {
    switch (buttonType) {
      case ButtonType.courseReview:
        return getCourseReview();
      case ButtonType.professorReview:
        return getProfessorReview();
      case ButtonType.pickedCourse:
        return callback;
      case ButtonType.unpickedCourse:
        return callback;
    }
  }

  getIcon() {
    switch (buttonType) {
      case ButtonType.courseReview:
        return 'assets/icons/course.svg';
      case ButtonType.professorReview:
        return 'assets/icons/professor.svg';
      case ButtonType.pickedCourse:
        return 'assets/icons/verify_filled.svg';
      case ButtonType.unpickedCourse:
        return 'assets/icons/verify_hollow.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: getOnTap,
      child: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: kWhite,
          boxShadow: [
            BoxShadow(
                color: kDarkBackgroundColour.withOpacity(0.45),
                offset: Offset(0, 4),
                blurRadius: 1),
          ],
        ),
        child: SvgPicture.asset(
          getIcon(),
          height: 20,
        ),
      ),
    );
  }
}

class SortFilterWrapper extends StatefulWidget {
  final ValueChanged<String> onChanged;
  SortFilterWrapper({required this.onChanged});
  @override
  _SortFilterWrapperState createState() => _SortFilterWrapperState();
}

class _SortFilterWrapperState extends State<SortFilterWrapper> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.025),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
          color: kBlue,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: kBlue.withOpacity(0.65),
                offset: Offset(0, 3),
                blurRadius: 1),
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  // width: size.width * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kWhite,
                    boxShadow: [
                      BoxShadow(
                          color: kDarkBackgroundColour.withOpacity(0.45),
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
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: kDarkBackgroundColour,
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
                    underline: Container(height: 0),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  // width: size.width * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kWhite,
                    boxShadow: [
                      BoxShadow(
                          color: kDarkBackgroundColour.withOpacity(0.45),
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
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: kDarkBackgroundColour,
                        fontFamily: 'Montserrat'),
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
                        selectedBranch = value;
                      });
                    },
                    underline: Container(height: 0),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: kWhite,
                  boxShadow: [
                    BoxShadow(
                        color: kDarkBackgroundColour.withOpacity(0.45),
                        offset: Offset(0, 4),
                        blurRadius: 1),
                  ],
                ),
                child: SvgPicture.asset('assets/icons/insert.svg'),
              ),
            ],
          ),
          Container(
            width: size.width * 0.9,
            margin: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: kDarkBackgroundColour.withOpacity(0.45),
                    blurRadius: 1,
                    offset: Offset(0, 4))
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: filterController,
              decoration: InputDecoration(
                fillColor: kWhite,
                isDense: true,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: kWhite,
                    width: 0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: kWhite,
                    width: 0,
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                prefixIcon: Icon(
                  Icons.search,
                  color: kDarkBackgroundColour,
                ),
                suffixIcon: filterController.text != ''
                    ? GestureDetector(
                        child: Icon(
                          Icons.close,
                          color: kDarkBackgroundColour,
                        ),
                        onTap: () {
                          filterController.clear();
                          widget.onChanged('');
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      )
                    : null,
                hintText: 'Search by name or professor',
                hintStyle: TextStyle(
                  color: kDarkBackgroundColour.withOpacity(0.3),
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              style: TextStyle(
                color: kDarkBackgroundColour.withOpacity(0.7),
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              onChanged: widget.onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
