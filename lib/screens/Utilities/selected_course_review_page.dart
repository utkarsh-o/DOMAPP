import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domapp/components/indicator.dart';
import 'package:domapp/screens/Utilities/helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hive/hive.dart';
import '../../HiveDB/Course.dart';
import '../../HiveDB/User.dart';
import '../../cache/constants.dart';
import '../../cache/local_data.dart';
import '../../cache/models.dart' as m;

class SelectedCourseReviewPage extends StatefulWidget {
  static const String route = 'SelectedCourseReviewPage';
  final m.Review? review;

  const SelectedCourseReviewPage({Key? key, this.review}) : super(key: key);
  @override
  _SelectedCourseReviewPageState createState() =>
      _SelectedCourseReviewPageState();
}

class _SelectedCourseReviewPageState extends State<SelectedCourseReviewPage> {
  int touchedIndex = -1;
  late Course course;
  late Map<String, dynamic> tags;
  late User user;
  late List<String> allTags;
  final isLoading = ValueNotifier<bool>(true);
  _getData() async {
    allTags = await getTags(instanceType: m.InstanceType.course);
    isLoading.value = false;
  }

  @override
  void initState() {
    course = widget.review!.item as Course;
    tags = widget.review!.tags;
    user = Hive.box('global').get('user');
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pickedTags1.sort((a, b) => b.votes.compareTo(a.votes));
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: isLoading,
            builder: (context, bool loading, _widget) {
              if (loading)
                return Center(
                    child: CircularProgressIndicator(
                  color: kWhite,
                ));
              return StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .doc('Courses/${course.uid}')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: kWhite,
                        ),
                      );
                    }
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;

                    Map<String, List<String>> tags =
                        Map<String, dynamic>.from(data['tags'])
                            .map((String key, dynamic value) {
                      List<String> typeCastedTags = List.from(value)
                          .map((_tag) => _tag as String)
                          .toList();
                      return MapEntry(key, typeCastedTags);
                    })
                          ..removeWhere((key, value) => value.length == 0);
                    List<String> sortedTags = tags.keys.toList(growable: false)
                      ..sort((k1, k2) =>
                          tags[k2]!.length.compareTo(tags[k1]!.length));
                    final List<String> likedBy =
                        data['likedBy'].cast<String>().toList();
                    final List<String> dislikedBy =
                        data['dislikedBy'].cast<String>().toList();
                    return Padding(
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                course.name,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: kWhite,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 30,
                                ),
                              ),
                              Text(
                                course.branch,
                                style: TextStyle(
                                  color: kWhite.withOpacity(0.8),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          SizedBox(
                            width: size.width,
                            height: 30,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Indicator(
                                  color: [kRed, kYellow, kGreen, kBlue][index],
                                  text:
                                      index != 3 ? sortedTags[index] : 'others',
                                  isSquare: false,
                                  size: touchedIndex == index ? 18 : 16,
                                  textColor: touchedIndex == index
                                      ? Colors.white
                                      : kWhite,
                                );
                              },
                              itemCount: min(4, sortedTags.length),
                              separatorBuilder:
                                  (BuildContext context, int index) => SizedBox(
                                width: 15,
                              ),
                            ),
                          ),
                          // ChartIndicatorsWrapper(touchedIndex: touchedIndex),
                          // const SizedBox(height: 10),
                          Expanded(
                            child: PieChart(
                              PieChartData(
                                  pieTouchData: PieTouchData(
                                      touchCallback: (_, pieTouchResponse) {
                                    if (pieTouchResponse == null) return;
                                    setState(() {
                                      final desiredTouch =
                                          pieTouchResponse.touchedSection
                                                  is! PointerExitEvent &&
                                              pieTouchResponse.touchedSection
                                                  is! PointerUpEvent;
                                      if (desiredTouch &&
                                          pieTouchResponse.touchedSection !=
                                              null) {
                                        touchedIndex = pieTouchResponse
                                            .touchedSection!
                                            .touchedSectionIndex;
                                      } else {
                                        touchedIndex = -1;
                                      }
                                    });
                                  }),
                                  startDegreeOffset: 180,
                                  borderData: FlBorderData(show: false),
                                  sectionsSpace: 7,
                                  centerSpaceRadius: 0,
                                  sections: getSections(
                                      tags: tags, sortedTags: sortedTags),
                                  centerSpaceColor: Colors.transparent),
                            ),
                          ),
                          SortStarLikeShareWrapper(
                            allTags: allTags,
                            tags: tags,
                            likedBy: likedBy,
                            dislikedBy: dislikedBy,
                            courseUID: widget.review!.item.uid,
                          ),
                          SizedBox(height: size.height * 0.02),
                          BuildTagsList(
                            tags: tags,
                            sortedTags: sortedTags,
                            profUID: widget.review!.item.uid,
                          )
                        ],
                      ),
                    );
                  });
            }),
      ),
    );
  }

  List<PieChartSectionData> getSections({
    required Map<String, dynamic> tags,
    required List<String> sortedTags,
  }) {
    final values =
        sortedTags.map((tag) => tags[tag].length).cast<int>().toList();
    int otherTotal =
        values.length > 3 ? values.sublist(3).fold(0, (p, c) => p + c) : 0;
    double multiplier = 100.0;
    return List.generate(
      min(4, tags.keys.length),
      (i) {
        final isTouched = i == touchedIndex;
        final opacity = isTouched ? 1.0 : 0.8;
        if (i == 3) {
          return PieChartSectionData(
            color: kBlue.withOpacity(opacity),
            showTitle: false,
            value: otherTotal.toDouble(),
            radius: multiplier,
          );
        }
        return PieChartSectionData(
          color: [kRed, kYellow, kGreen][i].withOpacity(opacity),
          showTitle: false,
          value: values[i].toDouble(),
          radius: multiplier,
        );
      },
    );
  }
}

class BuildTagsList extends StatelessWidget {
  final Map<String, List<String>> tags;
  final List<String> sortedTags;
  final String userUID, profUID;
  BuildTagsList({
    Key? key,
    required this.tags,
    required this.sortedTags,
    required this.profUID,
  })  : userUID = Hive.box('global').get('user').id,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            Color color = index < 3 ? colourList[index] : kBlue;
            String _tag = sortedTags[index];
            int _value = tags[_tag]!.length;
            return Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: color,
                boxShadow: [
                  BoxShadow(
                      color: color.withOpacity(0.45),
                      blurRadius: 1,
                      offset: Offset(0, 4))
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      _tag,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: kColorBackgroundDark.withOpacity(0.8)),
                    ),
                  ),
                  InkWell(
                    onTap: () => updateTag(
                      tags: tags,
                      tag: _tag,
                      path: 'Courses/$profUID',
                    ),
                    child: Container(
                      padding: EdgeInsets.all(5),
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
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            tags[_tag]!.contains(userUID)
                                ? 'assets/icons/plus_filled.svg'
                                : 'assets/icons/plus_hollow.svg',
                            color: kRed,
                            height: 15,
                          ),
                          SizedBox(width: 8),
                          Text(
                            _value.toString(),
                            style: TextStyle(
                                color: kRed,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: size.height * 0.02,
            );
          },
          itemCount: tags.length),
    );
  }
}
// class TagListWrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//
//     return Expanded(
//       child: ListView.separated(
//           physics: BouncingScrollPhysics(),
//           itemBuilder: (context, index) {
//             Color color = index < 3 ? colourList[index] : kBlue;
//             return Container(
//               padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//               decoration: BoxDecoration(
//                 color: color,
//                 boxShadow: [
//                   BoxShadow(
//                       color: color.withOpacity(0.45),
//                       blurRadius: 1,
//                       offset: Offset(0, 4))
//                 ],
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     child: Text(
//                       pickedTags1[index].title,
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15,
//                           color: kColorBackgroundDark.withOpacity(0.8)),
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(7),
//                       color: kWhite,
//                       boxShadow: [
//                         BoxShadow(
//                             color: kColorBackgroundDark.withOpacity(0.45),
//                             offset: Offset(0, 4),
//                             blurRadius: 1),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//                         SvgPicture.asset(
//                           'assets/icons/plus_filled.svg',
//                           color: kRed,
//                           height: 15,
//                         ),
//                         SizedBox(width: size.width * 0.02),
//                         Text(
//                           pickedTags1[index].votes.toString(),
//                           style: TextStyle(
//                               color: kRed,
//                               fontWeight: FontWeight.w600,
//                               fontSize: 14),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//           separatorBuilder: (BuildContext context, int index) {
//             return SizedBox(
//               height: size.height * 0.02,
//             );
//           },
//           itemCount: pickedTags1.length),
//     );
//   }
// }

class ChartIndicatorsWrapper extends StatelessWidget {
  const ChartIndicatorsWrapper({
    Key? key,
    required this.touchedIndex,
  }) : super(key: key);

  final int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Indicator(
          color: kRed,
          text: 'Interesting',
          isSquare: false,
          size: touchedIndex == 0 ? 18 : 16,
          textColor: touchedIndex == 0 ? Colors.white : kWhite,
        ),
        Indicator(
          color: kYellow,
          text: 'Scoring',
          isSquare: false,
          size: touchedIndex == 1 ? 18 : 16,
          textColor: touchedIndex == 1 ? Colors.white : kWhite,
        ),
        Indicator(
          color: kGreen,
          text: 'Useful',
          isSquare: false,
          size: touchedIndex == 2 ? 18 : 16,
          textColor: touchedIndex == 2 ? Colors.white : kWhite,
        ),
        Indicator(
          color: kBlue,
          text: 'Others',
          isSquare: false,
          size: touchedIndex == 3 ? 18 : 16,
          textColor: touchedIndex == 3 ? Colors.white : kWhite,
        ),
      ],
    );
  }
}

class SortStarLikeShareWrapper extends StatelessWidget {
  final Map<String, List<String>> tags;
  final List<String> likedBy, dislikedBy, allTags;
  int likes, dislikes;
  late double percentage;
  late User user;
  final String courseUID;
  late String path;
  SortStarLikeShareWrapper({
    Key? key,
    required this.tags,
    required this.likedBy,
    required this.dislikedBy,
    required this.courseUID,
    required this.allTags,
  })  : likes = likedBy.length,
        dislikes = dislikedBy.length {
    percentage = (likes + dislikes) > 0 ? likes / (likes + dislikes) * 100 : 0;
    user = Hive.box('global').get('user');
    path = 'Courses/$courseUID';
  }
  @override
  Widget build(BuildContext context) {
    final List<String> tagsToDisplay =
        allTags.toSet().difference(tags.keys.toSet()).toList();
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
                      color: kRed, fontWeight: FontWeight.w600, fontSize: 14),
                )
              ],
            ),
          ),
          if (tagsToDisplay.length > 0)
            Container(
              width: 120,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: kWhite,
                boxShadow: [
                  BoxShadow(
                      color: kColorBackgroundDark.withOpacity(0.45),
                      offset: Offset(0, 4),
                      blurRadius: 1),
                ],
              ),
              // child: Row(
              //   children: [
              //     Text(
              //       'Browse Tags',
              //       style: TextStyle(
              //           color: kColorBackgroundDark, fontWeight: FontWeight.bold),
              //     ),
              //     SizedBox(width: size.width * 0.02),
              //     SvgPicture.asset(
              //       'assets/icons/insert.svg',
              //       color: kColorBackgroundDark,
              //       height: 20,
              //     ),
              //   ],
              // ),
              child: Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  Text(
                    'Create Tag',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: kColorBackgroundDark,
                        fontFamily: 'Montserrat'),
                  ),
                  DropdownButton<String?>(
                    dropdownColor: kWhite,
                    icon: SvgPicture.asset(
                      'assets/icons/add_file.svg',
                    ),
                    iconSize: 20,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: kColorBackgroundDark,
                        fontFamily: 'Montserrat'),
                    isExpanded: true,
                    isDense: true,
                    value: null,
                    items: tagsToDisplay.map(
                      (String key) {
                        return DropdownMenuItem<String>(
                          child: Text(key),
                          value: key,
                        );
                      },
                    ).toList(),
                    onChanged: (String? value) async {
                      if (value == null) return;
                      await addTag(tag: value, path: path);
                    },
                    underline: Container(
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                  child: InkWell(
                    onTap: () => updateLikes(
                        likedBy: likedBy, path: 'Courses/$courseUID'),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          likedBy.contains(user.id)
                              ? 'assets/icons/thumbs_up_filled.svg'
                              : 'assets/icons/thumbs_up_hollow.svg',
                          color: kRed,
                          height: 20,
                        ),
                        SizedBox(width: size.width * 0.02),
                        Text(
                          likedBy.length.toString(),
                          style: TextStyle(
                              color: kRed,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    percentage.toStringAsFixed(2) + '%',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
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
                  child: SvgPicture.asset(
                    'assets/icons/thumbs_down_hollow.svg',
                    color: Color(0XFF9FADB2),
                    height: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
