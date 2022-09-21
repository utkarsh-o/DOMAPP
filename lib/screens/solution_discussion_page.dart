import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import '../cache/constants.dart';
import '../cache/local_data.dart';
import '../cache/models.dart';

List<String> sortMethods = ['Chronologically', 'Relevance'];
String? selectedSort = sortMethods.first;
List<DiscussionReply> replies = replyList;
final replyController = TextEditingController();
final tagController = TextEditingController();
final ImagePicker picker = ImagePicker();

class SolutionDiscussionThread extends StatelessWidget {
  static const String route = 'SolutionDiscussionThreadPage';
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleBar(),
                  HeaderWrapper(),
                  SizedBox(height: 20),
                  ReplyWrapper(),
                  SizedBox(height: 10),
                  SortStarLikeShareWrapper(),
                  SizedBox(height: 20),
                  ReplyBuilder(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ReplyWrapper extends StatefulWidget {
  @override
  _ReplyWrapperState createState() => _ReplyWrapperState();
}

class _ReplyWrapperState extends State<ReplyWrapper> {
  bool _showTagEditor = false;
  bool _imagePicked = false;
  PickedFile? pickedFile;
  pickImage() async {
    pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null)
      setState(() {
        _imagePicked = true;
      });
    else
      _imagePicked = false;
  }

  // Image.file(File(pickedFile!.path)
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool _topBanner = _imagePicked || _showTagEditor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _imagePicked
                ? Expanded(
                    child: Container(
                      constraints: BoxConstraints(
                          maxHeight: size.height * 0.2, minHeight: 30),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.45),
                              offset: Offset(0, 3),
                              blurRadius: 1),
                        ],
                        color: kBlue,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        ),
                      ),
                      child: Image.file(
                        File(pickedFile!.path),
                      ),
                    ),
                  )
                : Container(),
            _showTagEditor
                ? Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: size.width * 0.35,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                          color: kBlue,
                          borderRadius: BorderRadius.only(
                            topLeft: _imagePicked
                                ? Radius.zero
                                : Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: kBlue.withOpacity(0.65),
                                offset: Offset(0, 3),
                                blurRadius: 1),
                          ]),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.45),
                                offset: Offset(0, 3),
                                blurRadius: 1),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          maxLength: 10,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp('[ ]')),
                          ],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0XFF706F75),
                          ),
                          controller: tagController,
                          decoration: InputDecoration(
                            counterText: '',
                            fillColor: kWhite,
                            filled: true,
                            isDense: true,
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
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 5),
                            hintText: 'add a tag!',
                            hintStyle: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              color: Color(0XFF706F75),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
              color: kBlue,
              borderRadius: _topBanner
                  ? BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))
                  : BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: kBlue.withOpacity(0.65),
                    offset: Offset(0, 3),
                    blurRadius: 1),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                // width: size.width * 0.6,
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 6,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0XFF706F75),
                  ),
                  controller: replyController,
                  decoration: InputDecoration(
                    fillColor: kWhite,
                    filled: true,
                    isDense: true,
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
                    contentPadding: EdgeInsets.all(8),
                    hintText: 'Type your reply',
                    hintStyle: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0XFF706F75),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _showTagEditor = !_showTagEditor;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(left: 7),
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  // width: size.width * 0.4,
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
                  child: SvgPicture.asset('assets/icons/tag.svg'),
                ),
              ),
              InkWell(
                onTap: _imagePicked
                    ? () {
                        setState(() {
                          _imagePicked = false;
                        });
                      }
                    : pickImage,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                  child: SvgPicture.asset(_imagePicked
                      ? 'assets/icons/cross.svg'
                      : 'assets/icons/picture.svg'),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                // width: size.width * 0.4,
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
                child: SvgPicture.asset('assets/icons/expand_right.svg'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ReplyBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var selectedReply = replies[index];
          return Container(
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      selectedReply.user.avatar,
                      height: 30,
                    ),
                    SizedBox(width: size.width * 0.02),
                    Text(
                      selectedReply.user.fullName,
                      style:
                          TextStyle(color: kWhite, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: size.width * 0.02),
                    Text(
                      selectedReply.user.userName,
                      style: TextStyle(
                          color: kWhite.withOpacity(0.6),
                          fontSize: 11,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: size.width * 0.02),
                    Text(
                      selectedReply.tag,
                      style: TextStyle(
                          color: kWhite.withOpacity(0.6),
                          fontSize: 11,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                SizedBox(height: size.height * 0.005),
                Text(
                  selectedReply.text,
                  style: TextStyle(
                      color: kWhite, fontWeight: FontWeight.w600, fontSize: 13),
                ),
                SizedBox(height: size.height * 0.01),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/thumbs_up_filled.svg',
                      color: kGreen,
                      height: 15,
                    ),
                    Text(
                      '  ${selectedReply.thumbsUP}',
                      style: TextStyle(color: kGreen, fontSize: 11),
                    ),
                    SizedBox(width: 10),
                    SvgPicture.asset(
                      'assets/icons/thumbs_down_hollow.svg',
                      color: kInactive,
                      height: 15,
                    ),
                    Text(
                      '  ${selectedReply.thumbsDown}',
                      style: TextStyle(color: kRed, fontSize: 11),
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
        itemCount: replies.length);
  }
}

class HeaderWrapper extends StatelessWidget {
  const HeaderWrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: kRed,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Supra Molecular Structures',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: kWhite, fontSize: 20),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  QuestionPaperSolutionButton(
                    heading: 'Question Paper',
                  ),
                  QuestionPaperSolutionButton(
                    heading: 'Solution',
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            color: kYellow,
            boxShadow: [
              BoxShadow(
                color: kYellow.withOpacity(0.45),
                offset: Offset(0, 4),
                spreadRadius: 1,
              )
            ],
          ),
          child: Text(
            'CHEM F110   Compre   2020-21   May 12 2020   ATH: 33/60/31',
            style: TextStyle(
              color: kColorBackgroundDark.withOpacity(0.6),
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class TitleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 30),
        child: SvgPicture.asset(
          'assets/icons/back_button_title_bar.svg',
          color: kWhite,
        ),
      ),
    );
  }
}

class Tags extends StatelessWidget {
  final String heading;
  Tags({required this.heading});
  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: TextStyle(
        color: kColorBackgroundDark.withOpacity(0.6),
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class QuestionPaperSolutionButton extends StatelessWidget {
  final String heading;
  QuestionPaperSolutionButton({required this.heading});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 6),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: kWhite,
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 4),
              color: kColorBackgroundDark.withOpacity(0.45),
              blurRadius: 1)
        ],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          SvgPicture.asset('assets/icons/pdf.svg'),
          SizedBox(width: 8),
          Text(
            heading,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: kColorBackgroundDark.withOpacity(0.8),
                fontSize: 16),
          ),
        ],
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
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 0),
            width: size.width * 0.30,
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
            child: DropdownButton(
              dropdownColor: kWhite,
              icon: SvgPicture.asset(
                'assets/icons/expand_down.svg',
                width: 15,
              ),
              iconSize: 20,
              style: TextStyle(
                  fontSize: 11,
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
            // width: size.width * 0.4,
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
            child: Text(
              'Update ATH',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: kColorBackgroundDark,
                  fontFamily: 'Montserrat'),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            // width: size.width * 0.4,
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
            child: Text(
              'Upload Solutions',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: kColorBackgroundDark,
                  fontFamily: 'Montserrat'),
            ),
          )
        ],
      ),
    );
  }
}
