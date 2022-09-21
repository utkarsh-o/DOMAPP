import 'package:flutter/material.dart';

import 'screens/register_page.dart';
import 'screens/upload_question_paper_page.dart';
import 'screens/upload_slide_page.dart';
import 'screens/add_course_page.dart';
import 'screens/add_professor_page.dart';
import 'screens/solution_discussion_page.dart';
import 'screens/choose_course_page.dart';
import 'screens/course_review_page.dart';
import 'screens/admin_panel_page.dart';
import 'screens/selected_course_review_page.dart';
import 'screens/selected_professor_review_page.dart';
import 'screens/home_page.dart';
import 'screens/previous_years_papers_page.dart';
import 'screens/professor_opinions_page.dart';
import 'screens/sign_in_page.dart';
import 'screens/slides_page.dart';
import 'cache/constants.dart';
import 'screens/landing_page.dart';

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
        '/': (context) => HomePage(),
        HomePage.route: (context) => HomePage(),
        LandingPage.route: (context) => LandingPage(),
        SignInPage.route: (context) => SignInPage(),
        SlidesPage.route: (context) => SlidesPage(),
        PreviousYearsPapersPage.route: (context) => PreviousYearsPapersPage(),
        ProfessorOpinionsPage.route: (context) => ProfessorOpinionsPage(),
        ChooseCoursePage.route: (context) => ChooseCoursePage(),
        CourseReviewPage.route: (context) => CourseReviewPage(),
        SelectedCourseReviewPage.route: (context) => SelectedCourseReviewPage(),
        SelectedProfessorReviewPage.route: (context) =>
            SelectedProfessorReviewPage(),
        SolutionDiscussionThread.route: (context) => SolutionDiscussionThread(),
        AdminPanelPage.route: (context) => AdminPanelPage(),
        AddCoursePage.route: (context) => AddCoursePage(),
        AddProfessorPage.route: (context) => AddProfessorPage(),
        UploadQuestionPaperPage.route: (context) => UploadQuestionPaperPage(),
        UploadSlidePage.route: (context) => UploadSlidePage(),
        RegisterPage.route: (context) => RegisterPage(),
      },
      initialRoute: RegisterPage.route,
    );
  }
}
