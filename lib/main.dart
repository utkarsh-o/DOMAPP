import 'package:domapp/screens/Login_SignUp/helpers/helper.dart';
import 'package:domapp/screens/Utilities/selected_professor_review_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'screens/register_page.dart';
import 'screens/upload_question_paper_page.dart';
import 'screens/upload_slide_page.dart';
import 'screens/Admin/add_course_page.dart';
import 'screens/Admin/add_professor_page.dart';
import 'screens/solution_discussion_page.dart';
import 'screens/Acads/choose_course_page.dart';
import 'screens/Utilities/course_review_page.dart';
import 'screens/Admin/admin_panel_page.dart';
import 'screens/Utilities/selected_course_review_page.dart';
import 'screens/home_page.dart';
import 'screens/Acads/previous_years_papers_page.dart';
import 'screens/Utilities/professor_opinions_page.dart';
import 'screens/Login_SignUp/sign_in_page.dart';
import 'screens/slides_page.dart';
import 'cache/constants.dart';
import 'screens/landing_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  await Firebase.initializeApp();
  runApp(Domapp());
}

class Domapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: snackbarKey,
        theme: ThemeData(
          scaffoldBackgroundColor: kColorBackgroundDark,
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
          SelectedCourseReviewPage.route: (context) =>
              SelectedCourseReviewPage(),
          SelectedProfessorReviewPage.route: (context) =>
              SelectedProfessorReviewPage(),
          SolutionDiscussionThread.route: (context) =>
              SolutionDiscussionThread(),
          AdminPanelPage.route: (context) => AdminPanelPage(),
          AddCoursePage.route: (context) => AddCoursePage(),
          AddProfessorPage.route: (context) => AddProfessorPage(),
          UploadQuestionPaperPage.route: (context) => UploadQuestionPaperPage(),
          UploadSlidePage.route: (context) => UploadSlidePage(),
          RegisterPage.route: (context) => RegisterPage(),
        },
        // initialRoute: RegisterPage.route,
      ),
    );
  }
}
