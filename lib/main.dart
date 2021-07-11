import 'package:flutter/material.dart';

import '../screens/wrapper_page.dart';
import '../screens/previous_years_papers_page.dart';
import '../screens/professor_opinions_page.dart';
import '../screens/sign_in_page.dart';
import '../screens/slides_page.dart';
import '../cache/constants.dart';
import '../screens/landing_page.dart';

void main() {
  runApp(Domapp());
}

class Domapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: kDarkBackgroundColour,
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat',
      ),
      routes: {
        '/': (context) => WrapperPage(),
        WrapperPage.route: (context) => WrapperPage(),
        LandingPage.route: (context) => LandingPage(),
        SignInPage.route: (context) => SignInPage(),
        SlidesPage.route: (context) => SlidesPage(),
        PreviousYearsPapersPage.route: (context) => PreviousYearsPapersPage(),
        ProfessorOpinionsPage.route: (context) => ProfessorOpinionsPage(),
      },
      initialRoute: '/',
    );
  }
}
