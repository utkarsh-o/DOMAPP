import 'package:flutter/material.dart';

import '../screens/discussion_thread_page.dart';
import '../screens/discussion_forum_page.dart';
import '../screens/previous_years_papers_page.dart';
import '../screens/professor_opinions_page.dart';
import '../screens/utilities_page.dart';
import '../screens/academics_page.dart';
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
        LandingPage.route: (context) => LandingPage(),
        '/': (context) => LandingPage(),
        SignInPage.route: (context) => SignInPage(),
        AcademicsPage.route: (context) => AcademicsPage(),
        SlidesPage.route: (context) => SlidesPage(),
        PreviousYearsPapersPage.route: (context) => PreviousYearsPapersPage(),
        UtilitiesPage.route: (context) => UtilitiesPage(),
        ProfessorOpinionsPage.route: (context) => ProfessorOpinionsPage(),
        DiscussionForumPage.route: (context) => DiscussionForumPage(),
      },
      initialRoute: AcademicsPage.route,
    );
  }
}
