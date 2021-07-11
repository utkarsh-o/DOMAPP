import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../cache/constants.dart';
import '../cache/local_data.dart';

List<String> sortMethods = ['Chronologically', 'Popularity'];
String? selectedSort = sortMethods.first;
List<Comment> comments = commentList;

class DiscussionThreadPage extends StatelessWidget {
  static String route = 'DiscussionThreadPage';
  Post post;
  DiscussionThreadPage({required this.post});
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Container(
                    decoration: BoxDecoration(
                        color: kBlue,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                              color: kBlue.withOpacity(0.65),
                              offset: Offset(0, 3),
                              blurRadius: 3),
                        ]),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/create_post.svg',
                          height: 20,
                          color: Colors.white,
                        ),
                        SizedBox(width: size.width * 0.015),
                        Text(
                          'Create Post',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              PostInfoWrapper(post: post),
              SizedBox(height: size.height * 0.03),
              Text(
                post.title,
                style: TextStyle(
                    fontFamily: 'Satisfy', fontSize: 24, color: kWhite),
              ),
              SizedBox(height: size.height * 0.01),
              PostWrapper(),
              SizedBox(height: size.height * 0.065),
              SortStarLikeShareWrapper(),
              SizedBox(height: size.height * 0.020),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      var selectedComment = comments[index];
                      return Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  selectedComment.authorGender == 'male'
                                      ? 'assets/avatars/male2.svg'
                                      : 'assets/avatars/female1.svg',
                                  height: 30,
                                ),
                                SizedBox(width: size.width * 0.02),
                                Text(
                                  selectedComment.authorName,
                                  style: TextStyle(
                                      color: kWhite,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: size.width * 0.02),
                                Text(
                                  selectedComment.authorUsername,
                                  style: TextStyle(
                                      color: kWhite.withOpacity(0.6),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            SizedBox(height: size.height * 0.005),
                            Text(
                              selectedComment.text,
                              style: TextStyle(
                                  color: kWhite,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/heart_hollow.svg',
                                  color: kRed,
                                  height: 15,
                                ),
                                Text(
                                  '  ${selectedComment.likes}',
                                  style: TextStyle(color: kRed, fontSize: 11),
                                ),
                                SizedBox(width: 10),
                                SvgPicture.asset(
                                  'assets/icons/share.svg',
                                  color: kGreen,
                                  height: 15,
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 15);
                    },
                    itemCount: comments.length),
              )
            ],
          ),
        ),
      ),
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
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
                  selectedSort = value;
                });
              },
              underline: Container(
                height: 0,
              ),
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
                          color: kDarkBackgroundColour.withOpacity(0.45),
                          offset: Offset(0, 4),
                          blurRadius: 4),
                    ],
                  ),
                  child: SvgPicture.asset('assets/icons/star_filled.svg'),
                ),
                SizedBox(width: size.width * 0.02),
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
                  child: SvgPicture.asset('assets/icons/heart_filled.svg'),
                ),
                SizedBox(width: size.width * 0.02),
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
                  child: SvgPicture.asset('assets/icons/share.svg'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PostWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          bottom: -size.height * 0.045,
          child: Container(
            width: size.width * 0.854,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: kYellow,
              boxShadow: [
                BoxShadow(
                  color: kYellow,
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.03),
                Text(
                  '#E.C.E.  #comSys  #brainDead  #obamaCare',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kDarkBackgroundColour.withOpacity(0.6)),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: size.width * 0.854,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            color: kRed,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: kRed,
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            'I’m not trying to be judgemental but it’s so unsanitary (dirt from outside could come into the house if you just worked outside or if you step on something) and frankly in my opinion disrespectful to the main person of the house (my widowed grandma)',
            style: TextStyle(color: kWhite, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class PostInfoWrapper extends StatelessWidget {
  Post post;
  PostInfoWrapper({required this.post});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SvgPicture.asset(
              'assets/avatars/male1.svg',
              height: 40,
            ),
            SizedBox(width: size.width * 0.03),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            post.authorName,
                            style: TextStyle(
                              color: kWhite,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: size.width * 0.02),
                          Text(
                            '@${post.authorName}',
                            style: TextStyle(
                              fontSize: 12,
                              color: kWhite.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        DateFormat('MMM dd yyy').format(post.dateCreated),
                        style: TextStyle(
                            color: kWhite.withOpacity(0.6), fontSize: 11),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/heart_hollow.svg',
                                color: kRed,
                                height: 15,
                              ),
                              Text(
                                '  ${post.likes}',
                                style: TextStyle(
                                  color: kRed,
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                          SizedBox(width: 10),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/message.svg',
                                color: kRed,
                                height: 15,
                              ),
                              Text(
                                '  4',
                                style: TextStyle(
                                  color: kRed,
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Text(
                        '${post.dateCreated.difference(DateTime.now()).inHours % 24} hours ago',
                        style: TextStyle(
                            color: kWhite.withOpacity(0.6), fontSize: 11),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
