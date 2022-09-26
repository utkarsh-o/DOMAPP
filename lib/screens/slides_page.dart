import 'package:domapp/screens/Acads/helper/helper.dart';
import 'package:domapp/screens/upload_slide_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../HiveDB/Course.dart';
import '../HiveDB/Slide.dart';
import '../cache/constants.dart';

List<String> lessonNames = [
  'Lt-1\tIntroduction to life',
  'Lt-2\tHow to not wet the bed',
  'Lt-3\t101 ways to kill yourself',
  'Lt-4\tpick a way from Lt-3 ',
];

class SlidesPage extends StatefulWidget {
  static const String route = 'SlidesPage';
  final Course? course;
  SlidesPage({this.course});
  @override
  State<SlidesPage> createState() => _SlidesPageState();
}

class _SlidesPageState extends State<SlidesPage> {
  @override
  initState() {
    getSlidesFromCourse(courseID: widget.course!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: kOuterPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                widget.course!.name,
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
              SortFavouriteAddWrapper(course: widget.course),
              ValueListenableBuilder(
                  valueListenable:
                      Hive.box('slides').listenable(keys: [widget.course!.uid]),
                  builder: (context, Box box, _widget) {
                    final List<Slide> slides = box.get(widget.course!.uid,
                        defaultValue: <Slide>[]).cast<Slide>();
                    return Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: slides.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: size.height * 0.03,
                            );
                          },
                          itemBuilder: (context, index) {
                            final slide = slides[index];
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                color: kYellow,
                                boxShadow: [
                                  BoxShadow(
                                    color: kYellow.withOpacity(0.65),
                                    blurRadius: 1,
                                    offset: Offset(0, 4),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Lt-${slide.number}',
                                              // overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: kColorBackgroundDark
                                                      .withOpacity(0.8),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: size.width * 0.04),
                                      InkWell(
                                        onTap: () async {
                                          await launchUrlString(
                                            slide.url,
                                            mode:
                                                LaunchMode.externalApplication,
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            color: kWhite,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: kColorBackgroundDark
                                                      .withOpacity(0.45),
                                                  offset: Offset(0, 4),
                                                  blurRadius: 1),
                                            ],
                                          ),
                                          child: SvgPicture.asset(
                                              'assets/icons/expand_right.svg'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.02),
                                  IntrinsicHeight(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Prof. ${slide.professor.name}',
                                          style: TextStyle(
                                              color: kColorBackgroundDark
                                                  .withOpacity(0.5),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11),
                                        ),
                                        SizedBox(width: size.width * 0.03),
                                        Text(
                                          slide.date.year.toString(),
                                          style: TextStyle(
                                              color: kColorBackgroundDark
                                                  .withOpacity(0.5),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11),
                                        ),
                                        SizedBox(width: size.width * 0.04),
                                        Container(
                                          padding: EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            color: kWhite,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: kColorBackgroundDark
                                                      .withOpacity(0.45),
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
                                              SizedBox(
                                                  width: size.width * 0.02),
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
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            color: kWhite,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: kColorBackgroundDark
                                                      .withOpacity(0.45),
                                                  offset: Offset(0, 4),
                                                  blurRadius: 1),
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
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class SortFavouriteAddWrapper extends StatefulWidget {
  const SortFavouriteAddWrapper({Key? key, required this.course})
      : super(key: key);

  @override
  _SortFavouriteAddWrapperState createState() =>
      _SortFavouriteAddWrapperState();
  final course;
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
              child: SvgPicture.asset('assets/icons/star_filled.svg'),
            ),
            InkWell(
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return UploadSlidePage(
                  course: widget.course,
                );
              })),
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
          ],
        ),
      ),
    );
  }
}
