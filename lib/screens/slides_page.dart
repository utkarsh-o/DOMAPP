import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../cache/constants.dart';

List<String> lessonNames = [
  'Lt-1\tIntroduction to life',
  'Lt-2\tHow to not wet the bed',
  'Lt-3\t101 ways to kill yourself',
  'Lt-4\tpick a way from Lt-3 ',
];

class SlidesPage extends StatelessWidget {
  static String route = 'SlidesPage';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: kOuterPadding.add(EdgeInsets.symmetric(horizontal: 20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                'Supra Molecular Structures',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: kWhite,
                  fontWeight: FontWeight.w800,
                  fontSize: 26,
                ),
              ),
              Text(
                'Slides',
                style: TextStyle(
                  color: kWhite,
                  fontWeight: FontWeight.w800,
                  fontSize: 26,
                ),
              ),
              SortFavouriteAddWrapper(),
              Expanded(
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: lessonNames.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: size.height * 0.03,
                      );
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: kYellow,
                          boxShadow: [
                            BoxShadow(
                              color: kYellow.withOpacity(0.65),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            )
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        lessonNames[index],
                                        // overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: kDarkBackgroundColour
                                                .withOpacity(0.8),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
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
                                          color: kDarkBackgroundColour
                                              .withOpacity(0.45),
                                          offset: Offset(0, 4),
                                          blurRadius: 4),
                                    ],
                                  ),
                                  child: SvgPicture.asset(
                                      'assets/icons/expand_right.svg'),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.02),
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Prof. Mudrankit Pandey',
                                    style: TextStyle(
                                        color: kDarkBackgroundColour
                                            .withOpacity(0.5),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11),
                                  ),
                                  SizedBox(width: size.width * 0.03),
                                  Text(
                                    '2021',
                                    style: TextStyle(
                                        color: kDarkBackgroundColour
                                            .withOpacity(0.5),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11),
                                  ),
                                  SizedBox(width: size.width * 0.04),
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: kWhite,
                                      boxShadow: [
                                        BoxShadow(
                                            color: kDarkBackgroundColour
                                                .withOpacity(0.45),
                                            offset: Offset(0, 4),
                                            blurRadius: 4),
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
                                            color: kDarkBackgroundColour
                                                .withOpacity(0.45),
                                            offset: Offset(0, 4),
                                            blurRadius: 4),
                                      ],
                                    ),
                                    child: SvgPicture.asset(
                                        'assets/icons/star_filled.svg'),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SortFavouriteAddWrapper extends StatefulWidget {
  @override
  _SortFavouriteAddWrapperState createState() =>
      _SortFavouriteAddWrapperState();
}

List<String> sortMethods = ['Alphabetically', 'Last Used', 'Last Added'];

String? selectedSort = sortMethods.first;

class _SortFavouriteAddWrapperState extends State<SortFavouriteAddWrapper> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: size.height * 0.025),
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
              child: SvgPicture.asset('assets/icons/star_filled.svg'),
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
          ],
        ),
      ),
    );
  }
}
