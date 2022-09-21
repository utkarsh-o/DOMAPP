import 'package:domapp/cache/constants.dart';
import 'package:domapp/screens/Login_SignUp/sign_in_page.dart';
import 'package:domapp/screens/landing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/custom_navigation_bar.dart';
import 'Acads/academics_page.dart';
import 'Profile/profile_page.dart';
import 'Utilities/utilities_page.dart';
import 'Forum/discussion_forum_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
  static const String route = 'HomePage';
}

class _HomePageState extends State<HomePage> {
  String activeRoute = AcademicsPage.route;

  Widget buildPage(String route) {
    switch (route) {
      case AcademicsPage.route:
        return AcademicsPage();
      case UtilitiesPage.route:
        return UtilitiesPage();
      case DiscussionForumPage.route:
        return DiscussionForumPage();
      case ProfilePage.route:
        return ProfilePage();
      default:
        return AcademicsPage();
    }
  }

  changePage(String newRoute) {
    setState(() {
      activeRoute = newRoute;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        return Scaffold(
          body: SafeArea(
            child: snapshot.hasData
                ? Padding(
                    padding: kOuterPadding,
                    child: buildPage(activeRoute),
                  )
                : LandingPage(),
          ),
          bottomNavigationBar: snapshot.hasData
              ? CustomNavigationBar(
                  activePage: activeRoute,
                  callback: changePage,
                )
              : null,
        );
      },
    );
  }
}
