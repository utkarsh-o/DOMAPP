import '../screens/academics_page.dart';
import '../screens/discussion_forum_page.dart';
import '../screens/utilities_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../cache/constants.dart';

class CustomNavigationBar extends StatelessWidget {
  Map<String, Widget> chosenPage = {
    AcademicsPage.route: AcadsWrapper(),
    UtilitiesPage.route: UtilitiesWrapper(),
    DiscussionForumPage.route: ForumsWrapper(),
  };
  String activePage;
  CustomNavigationBar({required this.activePage});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: chosenPage[activePage],
    );
  }
}

class AcadsWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () =>
              Navigator.pushReplacementNamed(context, AcademicsPage.route),
          child: Container(
            decoration: BoxDecoration(
                color: kBlue,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                      color: kBlue.withOpacity(0.65),
                      offset: Offset(0, 3),
                      blurRadius: 3),
                ]),
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/acads_bnb.svg',
                  height: 20,
                ),
                SizedBox(width: size.width * 0.015),
                Text(
                  'Acads',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ),
        SizedBox(width: size.width * 0.06),
        InkWell(
          onTap: () => Navigator.pushNamed(context, UtilitiesPage.route),
          child: SvgPicture.asset(
            'assets/icons/utilities_bnb.svg',
            height: 20,
            color: Color(0XFF9FADB2),
          ),
        ),
        SizedBox(width: size.width * 0.06),
        InkWell(
          onTap: () => Navigator.pushReplacementNamed(
              context, DiscussionForumPage.route),
          child: SvgPicture.asset(
            'assets/icons/forum_bnb.svg',
            height: 20,
            color: Color(0XFF9FADB2),
          ),
        ),
        SizedBox(width: size.width * 0.06),
        SvgPicture.asset(
          'assets/icons/profile_bnb.svg',
          height: 20,
          color: Color(0XFF9FADB2),
        ),
      ],
    );
  }
}

class UtilitiesWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => Navigator.pushNamed(context, AcademicsPage.route),
          child: SvgPicture.asset(
            'assets/icons/acads_bnb.svg',
            height: 20,
            color: Color(0XFF9FADB2),
          ),
        ),
        SizedBox(width: size.width * 0.06),
        Container(
          decoration: BoxDecoration(
              color: kBlue,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                    color: kBlue.withOpacity(0.65),
                    offset: Offset(0, 3),
                    blurRadius: 3),
              ]),
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/utilities_bnb.svg',
                height: 20,
                color: Colors.white,
              ),
              SizedBox(width: size.width * 0.015),
              Text(
                'Utilities',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
        SizedBox(width: size.width * 0.06),
        InkWell(
          onTap: () => Navigator.pushNamed(context, DiscussionForumPage.route),
          child: SvgPicture.asset(
            'assets/icons/forum_bnb.svg',
            height: 20,
            color: Color(0XFF9FADB2),
          ),
        ),
        SizedBox(width: size.width * 0.06),
        SvgPicture.asset(
          'assets/icons/profile_bnb.svg',
          height: 20,
          color: Color(0XFF9FADB2),
        ),
      ],
    );
  }
}

class ForumsWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => Navigator.pushNamed((context), AcademicsPage.route),
          child: SvgPicture.asset(
            'assets/icons/acads_bnb.svg',
            height: 20,
            color: Color(0XFF9FADB2),
          ),
        ),
        SizedBox(width: size.width * 0.06),
        InkWell(
          onTap: () => Navigator.pushNamed(context, UtilitiesPage.route),
          child: SvgPicture.asset(
            'assets/icons/utilities_bnb.svg',
            height: 20,
            color: Color(0XFF9FADB2),
          ),
        ),
        SizedBox(width: size.width * 0.06),
        Container(
          decoration: BoxDecoration(
              color: kBlue,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                    color: kBlue.withOpacity(0.65),
                    offset: Offset(0, 3),
                    blurRadius: 3),
              ]),
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/forum_bnb.svg',
                height: 20,
                color: Colors.white,
              ),
              SizedBox(width: size.width * 0.015),
              Text(
                'Forums',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
        SizedBox(width: size.width * 0.06),
        SvgPicture.asset(
          'assets/icons/profile_bnb.svg',
          height: 20,
          color: Color(0XFF9FADB2),
        ),
      ],
    );
  }
}

class ProfileWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/acads_bnb.svg',
          height: 20,
          color: Color(0XFF9FADB2),
        ),
        SizedBox(width: size.width * 0.06),
        SvgPicture.asset(
          'assets/icons/utilities_bnb.svg',
          height: 20,
          color: Color(0XFF9FADB2),
        ),
        SizedBox(width: size.width * 0.06),
        SvgPicture.asset(
          'assets/icons/forum_bnb.svg',
          height: 20,
          color: Color(0XFF9FADB2),
        ),
        SizedBox(width: size.width * 0.06),
        Container(
          decoration: BoxDecoration(
              color: kBlue,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                    color: kBlue.withOpacity(0.65),
                    offset: Offset(0, 3),
                    blurRadius: 3),
              ]),
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/profile_bnb.svg',
                height: 20,
                color: Colors.white,
              ),
              SizedBox(width: size.width * 0.015),
              Text(
                'Profile',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ],
    );
  }
}
