import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../cache/constants.dart';
import '../../cache/local_data.dart';
import '../../cache/models.dart';
import '../../components/indicator.dart';

class SelectedProfessorReviewPage extends StatefulWidget {
  static const String route = 'SelectedProfessorReviewPage';

  @override
  _SelectedProfessorReviewPageState createState() =>
      _SelectedProfessorReviewPageState();
}

class _SelectedProfessorReviewPageState
    extends State<SelectedProfessorReviewPage> {
  Professor? professor = getProfessorByUID('1');

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    pickedTags2.sort((a, b) => b.votes.compareTo(a.votes));
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
                    'assets/icons/back_button_title_bar.svg',
                    color: kWhite,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    professor!.name,
                    style: TextStyle(
                      color: kWhite,
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    professor!.branches.join('  ||  '),
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
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Indicator(
                    color: kRed,
                    text: pickedTags2[0].title,
                    isSquare: false,
                    size: touchedIndex == 0 ? 18 : 16,
                    textColor: touchedIndex == 0 ? Colors.white : kWhite,
                  ),
                  Indicator(
                    color: kYellow,
                    text: pickedTags2[1].title,
                    isSquare: false,
                    size: touchedIndex == 1 ? 18 : 16,
                    textColor: touchedIndex == 1 ? Colors.white : kWhite,
                  ),
                  Indicator(
                    color: kGreen,
                    text: pickedTags2[2].title,
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
              ),
              const SizedBox(height: 18),
              Expanded(
                child: PieChart(
                  PieChartData(
                      pieTouchData:
                          PieTouchData(touchCallback: (_, pieTouchResponse) {
                        setState(() {
                          final desiredTouch = pieTouchResponse!.touchedSection
                                  is! PointerExitEvent &&
                              pieTouchResponse.touchedSection
                                  is! PointerUpEvent;
                          if (desiredTouch &&
                              pieTouchResponse.touchedSection != null) {
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          } else {
                            touchedIndex = -1;
                          }
                        });
                      }),
                      startDegreeOffset: 180,
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 10,
                      centerSpaceRadius: 0,
                      sections: showingSections(pickedTags2),
                      centerSpaceColor: Colors.transparent),
                ),
              ),
              SortStarLikeShareWrapper(),
              SizedBox(height: size.height * 0.02),
              BuildTagsList()
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(List<Tag> pickedTag) {
    int otherTotal = 0;
    for (var x = 3; x < pickedTag.length; x++) {
      otherTotal += pickedTag[x].votes;
    }
    double multiplier = 24;
    List<double> radius = [
      5 * multiplier,
      4 * multiplier,
      3.2 * multiplier,
      2.6 * multiplier,
    ];
    return List.generate(
      4,
      (i) {
        final isTouched = i == touchedIndex;
        final opacity = isTouched ? 1.0 : 0.8;
        switch (i) {
          case 0:
            return PieChartSectionData(
              color: kRed.withOpacity(opacity),
              showTitle: false,
              value: pickedTag[0].votes.toDouble(),
              // radius: 80,
              radius: radius[0],
            );
          case 1:
            return PieChartSectionData(
              color: kYellow.withOpacity(opacity),
              showTitle: false,
              value: pickedTag[1].votes.toDouble(),
              // radius: 40,
              radius: radius[1],
            );
          case 2:
            return PieChartSectionData(
              color: kGreen.withOpacity(opacity),
              showTitle: false,
              value: pickedTag[2].votes.toDouble(),
              // radius: 40,
              radius: radius[2],
            );
          case 3:
            return PieChartSectionData(
              color: kBlue.withOpacity(opacity),
              showTitle: false,
              value: otherTotal.toDouble(),
              // radius: 40,
              radius: radius[3],
            );
          default:
            throw Error();
        }
      },
    );
  }
}

class BuildTagsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            Color color = index < 3 ? colourList[index] : kBlue;
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
                      pickedTags2[index].title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: kColorBackgroundDark.withOpacity(0.8)),
                    ),
                  ),
                  Container(
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
                          'assets/icons/plus_filled.svg',
                          color: kRed,
                          height: 15,
                        ),
                        SizedBox(width: size.width * 0.02),
                        Text(
                          pickedTags2[index].votes.toString(),
                          style: TextStyle(
                              color: kRed,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        )
                      ],
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
          itemCount: pickedTags2.length),
    );
  }
}

class SortStarLikeShareWrapper extends StatefulWidget {
  @override
  _SortStarLikeShareWrapperState createState() =>
      _SortStarLikeShareWrapperState();
}

class _SortStarLikeShareWrapperState extends State<SortStarLikeShareWrapper> {
  @override
  Widget build(BuildContext context) {
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
          Container(
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
              child: Row(
                children: [
                  Text(
                    'Create Tag',
                    style: TextStyle(
                        color: kColorBackgroundDark,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: size.width * 0.02),
                  SvgPicture.asset(
                    'assets/icons/insert.svg',
                    color: kColorBackgroundDark,
                    height: 20,
                  ),
                ],
              )),
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
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(
                          'assets/icons/thumbs_up_filled.svg',
                          color: kRed,
                          height: 20,
                        ),
                      ),
                      SizedBox(width: size.width * 0.02),
                      Text(
                        '41',
                        style: TextStyle(
                            color: kRed,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '96%',
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
