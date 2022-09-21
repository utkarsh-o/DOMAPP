import 'package:domapp/cache/local_data.dart';
import 'package:domapp/cache/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../cache/constants.dart';

String selectedProfessor = 'Basavadatta Mitra';
String selectedSession = sessionList.last;

class UploadSlidePage extends StatelessWidget {
  static const String route = 'UploadSlidePage';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: kOuterPadding,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 30),
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      'assets/icons/back_button_title_bar.svg',
                      color: kWhite,
                    ),
                  ),
                ),
                Text(
                  'Upload Slide',
                  style: TextStyle(
                    color: kWhite,
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Course Title',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        color: kInactiveText,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Technical Report Writing',
                      style: TextStyle(
                          fontSize: 30,
                          color: kWhite.withOpacity(0.8),
                          fontFamily: 'Satisfy'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Slide Title',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        color: kInactiveText,
                      ),
                    ),
                    Container(
                      width: size.width * 0.9,
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
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          hintText: 'Tarkeshwar Singh',
                          hintStyle: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                            color: kInactiveText,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ProfessorWrapper(),
                SizedBox(height: 10),
                SessionUploadButtonWrapper(),
                SizedBox(height: 20),
                PickedFileProgressBarWrapper(progress: 0.4),
                ConfirmButtonWrapper(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PickedFileProgressBarWrapper extends StatelessWidget {
  const PickedFileProgressBarWrapper({
    Key? key,
    required this.progress,
  }) : super(key: key);

  final double progress;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final progressBarWidth = size.width * 0.5;

    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SvgPicture.asset(
              'assets/icons/pdf.svg',
              color: kWhite,
              height: 40,
            ),
            SizedBox(width: 20),
            SizedBox(
              width: progressBarWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MidSemDysoc.pdf',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: kWhite,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Visibility(
                        visible: progress < 1,
                        child: Positioned(
                          right: -60,
                          top: -7,
                          child: Text(
                            '${(progress * 100).toStringAsFixed(1)}%',
                            style: TextStyle(
                              color: kWhite,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: progressBarWidth * progress,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: progress == 1 ? kGreen : kWhite,
                                width: 2),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      SizedBox(width: 5),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PickPDFButton extends StatelessWidget {
  VoidCallback callback;
  PickPDFButton({required this.callback});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: callback,
        child: Container(
          decoration: BoxDecoration(
              color: kBlue,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: kBlue.withOpacity(0.65),
                    offset: Offset(0, 3),
                    blurRadius: 1),
              ]),
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/icons/upload.svg',
                height: 20,
                color: Colors.white,
              ),
              SizedBox(width: size.width * 0.015),
              Text(
                'Pick PDF',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SessionUploadButtonWrapper extends StatefulWidget {
  @override
  _SessionUploadButtonWrapperState createState() =>
      _SessionUploadButtonWrapperState();
}

class _SessionUploadButtonWrapperState
    extends State<SessionUploadButtonWrapper> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Professor',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: kInactiveText,
            ),
          ),
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: size.width * 0.4,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                  dropdownColor: kColorBackgroundDark,
                  icon: SvgPicture.asset(
                    'assets/icons/expand_down.svg',
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
                  value: selectedSession,
                  items: sessionList.map((String value) {
                    return DropdownMenuItem<String>(
                      child: Text(
                        value,
                      ),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedSession = value.toString();
                    });
                  },
                  underline: Container(
                    height: 0,
                  ),
                ),
              ),
              SizedBox(width: size.width * 0.1),
              PickPDFButton(callback: () {}),
            ],
          ),
        ],
      ),
    );
  }
}

class ConfirmButtonWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                    color: kColorBackgroundDark.withOpacity(0.8),
                    height: 20,
                  ),
                ),
                SizedBox(width: 16),
                Container(
                  child: Flexible(
                    child: Text(
                      uploadDisclaimer,
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
                'Confirm',
                style: TextStyle(
                    color: kColorBackgroundDark,
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

class ProfessorWrapper extends StatefulWidget {
  @override
  _ProfessorWrapperState createState() => _ProfessorWrapperState();
}

class _ProfessorWrapperState extends State<ProfessorWrapper> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Professor',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: kInactiveText,
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: size.width * 0.9,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
              dropdownColor: kColorBackgroundDark,
              icon: SvgPicture.asset(
                'assets/icons/expand_down.svg',
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
              value: selectedProfessor,
              items: professorList.map((Professor value) {
                return DropdownMenuItem<String>(
                  child: Text(
                    value.name,
                  ),
                  value: value.name,
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedProfessor = value.toString();
                });
              },
              underline: Container(
                height: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
