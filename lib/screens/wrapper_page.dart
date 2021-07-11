import 'package:flutter/material.dart';

import '../components/custom_navigation_bar.dart';
import '../screens/academics_page.dart';
import '../screens/profile_page.dart';
import '../screens/utilities_page.dart';
import 'discussion_forum_page.dart';

class WrapperPage extends StatefulWidget {
  @override
  _WrapperPageState createState() => _WrapperPageState();
  static const String route = 'WrapperPage';
}

class _WrapperPageState extends State<WrapperPage> {
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
      body: buildPage(activeRoute),
      bottomNavigationBar: CustomNavigationBar(
        activePage: activeRoute,
        callback: changePage,
      ),
    );
  }
}
