import 'package:domapp/cache/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PreviousYearsPapersPage extends StatelessWidget {
  static const String route = 'PreviousYearsPage';
  @override
  Widget build(BuildContext context) {
    List<String> yearList = [
      '2018-19',
      '2019-20',
      '2020-21',
      '2021-22',
      '2022-23',
    ];
    List<String> evaluativesList = ['Compre', 'Mid-Sem', 'Test-1', 'Test-2'];
    String? selectedEvaluative = evaluativesList.first;
    String? selectedYear = yearList.first;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: kOuterPadding.add(EdgeInsets.symmetric(horizontal: 20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                'Previous Years Papers',
                style: TextStyle(
                  color: kWhite,
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                ),
              ),
              Stack(
                alignment: Alignment.bottomLeft,
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                      bottom: -100,
                      width: size.width * 0.845,
                      child: YellowContainer(index: 1)),
                  Positioned(
                      bottom: -50,
                      width: size.width * 0.845,
                      child: YellowContainer(index: 0)),
                  GreenContainer(
                      selectedYear: selectedYear,
                      yearList: yearList,
                      selectedEvaluative: selectedEvaluative,
                      evaluativesList: evaluativesList),
                ],
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                      bottom: size.height * 0.1, top: size.height * 0.3),
                  width: size.width * 0.6,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      color: kRed,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: kRed.withOpacity(0.65),
                            offset: Offset(0, 3),
                            blurRadius: 1),
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Solution Discussion',
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
                                color: kDarkBackgroundColour.withOpacity(0.45),
                                offset: Offset(0, 4),
                                blurRadius: 1),
                          ],
                        ),
                        child:
                            SvgPicture.asset('assets/icons/expand_right.svg'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class YellowContainer extends StatelessWidget {
  final int index;
  YellowContainer({required this.index});
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
                ? kDarkBackgroundColour.withOpacity(0.35)
                : kYellow.withOpacity(0.35),
            blurRadius: 1,
            offset: Offset(0, 4),
          )
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          SizedBox(height: size.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                index == 1 ? 'Test - 1' : 'Mid - Sem',
                style: TextStyle(
                    color: kDarkBackgroundColour.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              Row(
                children: [
                  Text(
                    index == 1 ? 'Feburary 2,2021' : 'March 7, 2021',
                    style: TextStyle(
                        color: kDarkBackgroundColour.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  SizedBox(width: size.width * 0.04),
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
                    child: SvgPicture.asset('assets/icons/expand_right.svg'),
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
  const GreenContainer({
    Key? key,
    required this.selectedYear,
    required this.yearList,
    required this.selectedEvaluative,
    required this.evaluativesList,
  }) : super(key: key);

  final String? selectedYear;
  final List<String> yearList;
  final String? selectedEvaluative;
  final List<String> evaluativesList;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.845,
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
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Supra Molecular Structures',
            style: TextStyle(
                color: kDarkBackgroundColour.withOpacity(0.8),
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          SizedBox(height: size.height * 0.015),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: size.width * 0.25,
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
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: kDarkBackgroundColour,
                      fontFamily: 'Montserrat'),
                  isExpanded: true,
                  isDense: true,
                  value: selectedYear,
                  items: yearList.map((value) {
                    return DropdownMenuItem<String>(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    // setState(() {
                    //   print('value is $value');
                    //   selectedYear = value;
                    // });
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
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: kDarkBackgroundColour,
                      fontFamily: 'Montserrat'),
                  isExpanded: true,
                  isDense: true,
                  value: selectedEvaluative,
                  items: evaluativesList.map((value) {
                    return DropdownMenuItem<String>(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    // setState(() {
                    //   print('value is $value');
                    //   selectedYear = value;
                    // });
                  },
                  underline: Container(height: 0),
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
                                color: kDarkBackgroundColour.withOpacity(0.45),
                                offset: Offset(0, 4),
                                blurRadius: 1),
                          ],
                        ),
                        child: SvgPicture.asset('assets/icons/star_filled.svg'),
                      ),
                      SizedBox(width: size.width * 0.04),
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
                        child: SvgPicture.asset('assets/icons/add_file.svg'),
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
                                color: kDarkBackgroundColour.withOpacity(0.45),
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
                                color: kDarkBackgroundColour.withOpacity(0.45),
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
