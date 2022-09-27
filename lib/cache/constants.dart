import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

const int USER_BOX = 1;
const int COURSE_BOX = 2;
const int PROF_BOX = 3;
const int SLIDE_BOX = 4;
const int PAPER_BOX = 5;
const int BRANCH_BOX = 6;
const int CREDITS_BOX = 7;
const int APPROVAL_BOX = 8;
Color kColorBackgroundDark = Color(0XFF18171F);
const Color kWhite = Color(0XFFE3E3E3);
const Color kBlue = Color(0XFF0AAEE6);
const Color kGreen = Color(0XFF9DC78E);
const Color kInactive = Color(0XFF9FADB2);
const Color kYellow = Color(0XFFFED47E);
const Color kInactiveText = Color(0XFF706F75);
const Color KGold = Color(0XFFFFB92B);
const Color kRed = Color(0XFFFF8181);
EdgeInsets kOuterPadding = EdgeInsets.symmetric(horizontal: 30, vertical: 10);
EdgeInsets kInnerPadding = EdgeInsets.symmetric(horizontal: 20);
String kMainFontFamily = 'Montserrat';
String kAccentFontFamily = 'Satisfy';

List<String> courseNames = [
  'Polymer Chemistry',
  'Supramolecular Structures',
  'Organic Chemistry I'
];

String disclaimerText =
    'All the information provided above is true to the best of my knowledge, and I have double checkes for typographical mistakes and other non-intentinal errors.';
String addProfessorWarning =
    'please refer the faculty seciton of institute webite for correct spellings and other information';
String uploadDisclaimer =
    'I have double checked the uploaded file, and all the relevant information provided in the form is true to the best of my knowledge. ';

const String FOLDER_ID = "1ELCztD7t7QFKhdYqwRCwHOjulo6g6B-7";
const String GDRIVE_LINK_PREFIX = "drive.google.com/file/d/";
const String GDRIVE_LINK_POSTFIX = "";
