import 'package:domapp/screens/previous_years_papers_page.dart';
import 'package:domapp/screens/slides_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../cache/constants.dart';
import '../components/custom_navigation_bar.dart';

class AcademicsPage extends StatefulWidget {
  static String route = 'AcademicsPage';

  @override
  _AcademicsPageState createState() => _AcademicsPageState();
}

class _AcademicsPageState extends State<AcademicsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: kOuterPadding.add(EdgeInsets.symmetric(horizontal: 20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                child: InkWell(
                  onTap: () => Navigator.of(context).pop,
                  child: SvgPicture.asset(
                    'assets/icons/options_button_titlebar.svg',
                    color: kWhite,
                  ),
                ),
              ),
              SortAddWrapper(),
              SizedBox(height: size.height * 0.03),
              selectedCoursesList(),
              BreakLine(),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      decoration: BoxDecoration(
                          color: kRed,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: kRed.withOpacity(0.65),
                                offset: Offset(0, 3),
                                blurRadius: 3),
                          ]),
                      child: Text(
                        'SG Estimator',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: kDarkBackgroundColour),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: kRed,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: kRed.withOpacity(0.65),
                                offset: Offset(0, 3),
                                blurRadius: 3),
                          ]),
                      child: Row(
                        children: [
                          Text(
                            'Forum',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: kDarkBackgroundColour),
                          ),
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: kWhite,
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        kDarkBackgroundColour.withOpacity(0.45),
                                    offset: Offset(0, 4),
                                    blurRadius: 4),
                              ],
                            ),
                            child:
                                SvgPicture.asset('assets/icons/incognito.svg'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        activePage: AcademicsPage.route,
      ),
    );
  }
}

class selectedCoursesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Expanded(
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 15);
        },
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            // height: 50,
            decoration: BoxDecoration(
              color: listColours[index % 3],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: listColours[index % 3].withOpacity(0.65),
                    offset: Offset(0, 3),
                    blurRadius: 3),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  courseNames[index],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kDarkBackgroundColour.withOpacity(0.8),
                      fontSize: 16),
                ),
                SizedBox(height: size.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, SlidesPage.route),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: kWhite,
                          boxShadow: [
                            BoxShadow(
                                color: kDarkBackgroundColour.withOpacity(0.45),
                                offset: Offset(0, 4),
                                blurRadius: 4),
                          ],
                        ),
                        child: Text(
                          'Slides',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pushNamed(
                          (context), PreviousYearsPapersPage.route),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: kWhite,
                          boxShadow: [
                            BoxShadow(
                                color: kDarkBackgroundColour.withOpacity(0.45),
                                offset: Offset(0, 4),
                                blurRadius: 4),
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
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: kWhite,
                        boxShadow: [
                          BoxShadow(
                              color: kDarkBackgroundColour.withOpacity(0.45),
                              offset: Offset(0, 4),
                              blurRadius: 4),
                        ],
                      ),
                      child: Text(
                        'Related Books',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: kWhite,
                        boxShadow: [
                          BoxShadow(
                              color: kDarkBackgroundColour.withOpacity(0.45),
                              offset: Offset(0, 4),
                              blurRadius: 4),
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
        itemCount: courseNames.length,
      ),
    );
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
                  blurRadius: 3),
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
                      color: kDarkBackgroundColour.withOpacity(0.45),
                      offset: Offset(0, 4),
                      blurRadius: 4),
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
                    print('value is $value');
                    selectedSort = value;
                  });
                },
                underline: Container(
                  height: 0,
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
                      blurRadius: 4),
                ],
              ),
              child: SvgPicture.asset('assets/icons/add_file.svg'),
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
                      blurRadius: 4),
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
            blurRadius: 2,
          ),
        ],
      ),
    );
  }
}
