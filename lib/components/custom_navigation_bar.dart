import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../cache/constants.dart';
import '../screens/profile_page.dart';
import '../screens/academics_page.dart';
import '../screens/discussion_forum_page.dart';
import '../screens/utilities_page.dart';

class CustomNavigationBar extends StatelessWidget {
  Function callback;
  String activePage;
  CustomNavigationBar({required this.activePage, required this.callback});

  Map<String, Widget> getPage = {
    AcademicsPage.route: AcademicsPage(),
    UtilitiesPage.route: UtilitiesPage(),
    DiscussionForumPage.route: DiscussionForumPage(),
    ProfilePage.route: ProfilePage(),
  };
  @override
  void changePage(String pageRoute, BuildContext context) {
    callback(pageRoute);
  }

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: NavigationButtons(
        activeRoute: activePage,
        callback: changePage,
      ),
    );
  }
}

class NavigationButtons extends StatelessWidget {
  final String activeRoute;
  Function callback;
  NavigationButtons({required this.activeRoute, required this.callback});

  Map<String, String> iconLocation = {
    AcademicsPage.route: 'assets/icons/acads_bnb.svg',
    UtilitiesPage.route: 'assets/icons/utilities_bnb.svg',
    DiscussionForumPage.route: 'assets/icons/forum_bnb.svg',
    ProfilePage.route: 'assets/icons/profile_bnb.svg',
  };
  Map<String, String> title = {
    AcademicsPage.route: 'Acads',
    UtilitiesPage.route: 'Utilities',
    DiscussionForumPage.route: 'Forum',
    ProfilePage.route: 'Profile',
  };

  Widget getNavigationButton(
      String buttonRoute, String activeRoute, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return activeRoute != buttonRoute
        ? InkWell(
            onTap: () => callback(buttonRoute, context),
            child: SvgPicture.asset(
              iconLocation[buttonRoute]!,
              height: 20,
              color: Color(0XFF9FADB2),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              color: kBlue,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: kBlue.withOpacity(0.65),
                  offset: Offset(0, 3),
                  blurRadius: 1,
                ),
              ],
            ),
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                SvgPicture.asset(
                  iconLocation[buttonRoute]!,
                  height: 20,
                  color: Colors.white,
                ),
                SizedBox(
                  width: size.width * 0.015,
                ),
                Text(
                  title[buttonRoute]!,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getNavigationButton(AcademicsPage.route, activeRoute, context),
        SizedBox(width: size.width * 0.06),
        getNavigationButton(UtilitiesPage.route, activeRoute, context),
        SizedBox(width: size.width * 0.06),
        getNavigationButton(DiscussionForumPage.route, activeRoute, context),
        SizedBox(width: size.width * 0.06),
        getNavigationButton(ProfilePage.route, activeRoute, context),
      ],
    );
  }
}
