import 'package:domapp/cache/local_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../cache/constants.dart';
import '../landing_page.dart';
import '../../screens/Login_SignUp/helpers/helper.dart';

class ProfilePage extends StatelessWidget {
  static const String route = "ProfilePage";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TitleBarWrapper(),
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: kWhite,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 1,
                    color: kWhite.withOpacity(0.45),
                  )
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: SvgPicture.asset(
                user.avatar,
                height: size.height * 0.16,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Column(
              children: [
                Text(
                  user.fullName,
                  style: TextStyle(
                      fontFamily: 'Satisfy', fontSize: 36, color: kWhite),
                ),
                Text(
                  '@${user.userName}',
                  style: TextStyle(
                    fontSize: 13,
                    color: kWhite.withOpacity(0.6),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BottomButton(
              title: 'FeedBack',
              color: kGreen,
            ),
            BottomButton(
              title: 'Starred',
              color: kYellow,
            ),
            BottomButton(
              title: 'Activities',
              color: kRed,
            ),
          ],
        ),
      ],
    );
  }
}

class BottomButton extends StatelessWidget {
  String title;
  Color color;
  BottomButton({required this.title, required this.color});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.65),
            offset: Offset(0, 3),
            blurRadius: 1,
          ),
        ],
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: kColorBackgroundDark.withOpacity(0.8),
            fontSize: 18),
      ),
    );
  }
}

class TitleBarWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 30),
          child: InkWell(
            onTap: () => Navigator.of(context).pop,
            child: SvgPicture.asset(
              'assets/icons/options_button_titlebar.svg',
              color: kWhite,
            ),
          ),
        ),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: kBlue,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: kBlue.withOpacity(0.65),
                      offset: Offset(0, 3),
                      blurRadius: 1,
                    ),
                  ]),
              padding: EdgeInsets.all(10),
              child: SvgPicture.asset(
                'assets/icons/edit_profile.svg',
                height: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(width: size.width * 0.05),
            Container(
              decoration: BoxDecoration(
                  color: kRed,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: kRed.withOpacity(0.65),
                      offset: Offset(0, 3),
                      blurRadius: 1,
                    ),
                  ]),
              padding: EdgeInsets.all(10),
              child: InkWell(
                onTap: () async {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  await provider.googleLogout();
                },
                // onTap: () => FirebaseAuth.instance.signOut(),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/logout.svg',
                      height: 20,
                      color: Colors.white,
                    ),
                    SizedBox(width: size.width * 0.015),
                    Text(
                      'Logout',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
