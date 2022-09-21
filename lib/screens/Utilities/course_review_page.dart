import 'package:domapp/screens/Acads/academics_page.dart';
import 'package:domapp/screens/Utilities/selected_course_review_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../cache/constants.dart';
import '../../cache/local_data.dart';
import '../../cache/models.dart';

List<String> sortMethods = [
  'Rating',
  'Alphabetically',
  'Joining Year',
];
String? selectedSort = sortMethods.first;
TextEditingController filterController = TextEditingController();
List<String> timeFrames = ['Today', 'This Week', 'This Month', 'All Time'];
String? selectedTimeFrame = timeFrames.first;

class CourseReviewPage extends StatefulWidget {
  static const String route = 'CourseReviewPage';

  @override
  _CourseReviewPageState createState() => _CourseReviewPageState();
}

class _CourseReviewPageState extends State<CourseReviewPage> {
  String query = '';
  List<Course> filteredCourses = courseList;

  @override
  Widget build(BuildContext context) {
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
                    'assets/icons/back_button_title_bar.svg',
                    color: kWhite,
                  ),
                ),
              ),
              Text(
                'Course Reviews',
                style: TextStyle(
                  color: kWhite,
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                ),
              ),
              SortFilterWrapper(onChanged: searchCourses),
              Expanded(
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CourseListBuilder(
                        currentCourse: filteredCourses[index],
                        index: index,
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

  void searchCourses(String query) {
    final result = courseList.where((course) {
      final titleLower = course.title.toLowerCase();
      final branchLower = getBranchName(course.branch).toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          branchLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.filteredCourses = result;
    });
  }
}

class CourseListBuilder extends StatelessWidget {
  final Course currentCourse;
  final int index;
  CourseListBuilder({required this.currentCourse, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, SelectedCourseReviewPage.route),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 10,
                color: colourList[index % 3],
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      currentCourse.title,
                      style: TextStyle(
                          fontFamily: 'Satisfy', fontSize: 18, color: kWhite),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${currentCourse.branch} || ${currentCourse.type}',
                      style: TextStyle(fontSize: 12, color: kWhite),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: SvgPicture.asset(
                          'assets/icons/thumbs_up_filled.svg',
                          color: colourList[index % 3],
                        ),
                      ),
                      Text(
                        ' 41',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: colourList[index % 3]),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      '96 %',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child:
                        SvgPicture.asset('assets/icons/thumbs_down_hollow.svg'),
                  )
                ],
              )
            ],
          ),
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
                  underline: Container(height: 0),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: size.width * 0.35,
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
                  value: selectedTimeFrame,
                  items: timeFrames.map((value) {
                    return DropdownMenuItem<String>(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedTimeFrame = value;
                    });
                  },
                  underline: Container(height: 0),
                ),
              ),
            ],
          ),
          Container(
            width: size.width * 0.9,
            margin: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: kColorBackgroundDark.withOpacity(0.45),
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
                  color: kColorBackgroundDark,
                ),
                suffixIcon: filterController.text != ''
                    ? GestureDetector(
                        child: Icon(
                          Icons.close,
                          color: kColorBackgroundDark,
                        ),
                        onTap: () {
                          filterController.clear();
                          widget.onChanged('');
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      )
                    : null,
                hintText: 'Search by name or branch',
                hintStyle: TextStyle(
                  color: kColorBackgroundDark.withOpacity(0.3),
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              style: TextStyle(
                color: kColorBackgroundDark.withOpacity(0.7),
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              onChanged: widget.onChanged,
            ),
          )
        ],
      ),
    );
  }
}
