import 'package:domapp/cache/constants.dart';
import 'package:domapp/cache/local_data.dart';
import 'package:domapp/screens/selected_course_review_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

final professorNameController = TextEditingController();

List<String> prefixList = ['Dr.', 'Mr.', 'Ms.'];
String selectedPrefix = prefixList.first;
List<String> departmentList = [
  'Mathematics',
  'Physics',
  'Economics',
  'Computer Science'
];

class AddProfessorPage extends StatelessWidget {
  static const String route = 'AddProfessorPage';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: kOuterPadding,
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop,
                      child: SvgPicture.asset(
                        'assets/icons/back_button_titlebar.svg',
                        color: kWhite,
                      ),
                    ),
                  ),
                  Text(
                    'Add Professor',
                    style: TextStyle(
                      color: kWhite,
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 20),
                  ProfessorNameWrapper(),
                  SizedBox(height: 10),
                  Text(
                    'Department(s)',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: kInactiveText,
                    ),
                  ),
                  SizedBox(height: 20),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return DepartmentListBuilder(
                          department: departmentList[index],
                          index: index,
                        );
                      },
                      itemCount: adminActionsList.length),
                  SizedBox(height: 30),
                  AddProfessorWrapper(size: size),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AddProfessorWrapper extends StatelessWidget {
  const AddProfessorWrapper({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                    color: kDarkBackgroundColour.withOpacity(0.8),
                    height: 20,
                  ),
                ),
                SizedBox(width: 16),
                Container(
                  child: Flexible(
                    child: Text(
                      disclaimerText,
                      style: TextStyle(fontSize: 11, color: kWhite),
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
                'Add Professor',
                style: TextStyle(
                    color: kDarkBackgroundColour,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DepartmentListBuilder extends StatelessWidget {
  String department;
  final int index;
  DepartmentListBuilder({required this.index, required this.department});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      // onTap: () => Navigator.pushNamed(context, SelectedCourseReviewPage.route),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: IntrinsicHeight(
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(minHeight: size.height * 0.07),
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
                      department,
                      style: TextStyle(
                          fontFamily: 'Satisfy', fontSize: 18, color: kWhite),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
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
                  color: kGreen,
                  height: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfessorNameWrapper extends StatefulWidget {
  @override
  _ProfessorNameWrapperState createState() => _ProfessorNameWrapperState();
}

class _ProfessorNameWrapperState extends State<ProfessorNameWrapper> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Prefix',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: kInactiveText,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: size.width * 0.2,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                    dropdownColor: Color(0XFF1D1C23),
                    icon: SvgPicture.asset(
                      'assets/icons/expand_down.svg',
                      width: 15,
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
                    value: selectedPrefix,
                    items: prefixList.map((value) {
                      return DropdownMenuItem<String>(
                        child: Text(value),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedPrefix = value.toString();
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
                  'Professor Name',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: kInactiveText,
                  ),
                ),
                Container(
                  width: size.width * 0.6,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: kWhite,
                    ),
                    // controller: courseTitleController,
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
                        hintText: 'Tarkeshwar Singh',
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
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: size.width * 0.7,
            child: Text(
              addProfessorWarning,
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
