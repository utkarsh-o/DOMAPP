import 'package:domapp/cache/constants.dart';
import 'package:flutter/material.dart';

import '../components/custom_navigation_bar.dart';
import '../screens/academics_page.dart';
import '../screens/profile_page.dart';
import '../screens/utilities_page.dart';
import 'discussion_forum_page.dart';

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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: kOuterPadding,
          child: buildPage(activeRoute),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        activePage: activeRoute,
        callback: changePage,
      ),
    );
  }
}
