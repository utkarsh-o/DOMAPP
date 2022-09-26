import 'package:domapp/screens/home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:domapp/cache/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'helpers/helper.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class SignInPage extends StatelessWidget {
  static const String route = 'SignInPage';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: kInnerPadding.add(EdgeInsets.symmetric(horizontal: 20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 50),
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop,
                    child: SvgPicture.asset(
                      'assets/icons/back_button_title_bar.svg',
                      color: kWhite,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SIGN IN',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kWhite,
                          fontSize: 35),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      'just stfu and sign in bitch',
                      style: TextStyle(
                          fontFamily: kAccentFontFamily,
                          color: kWhite,
                          fontSize: 20),
                    )
                  ],
                ),
                SizedBox(height: size.height * 0.08),
                EmailPasswordWrapper(),
                SizedBox(height: size.height * 0.18),
                SigninWrapper()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SigninWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {},
          child: Text(
            'forgot password',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kWhite.withOpacity(0.4),
                fontSize: 16),
          ),
        ),
        SizedBox(height: size.height * 0.02),
        InkWell(
          onTap: () async {
            await signInWithEmail(
                email: emailController.text, password: passwordController.text);
          },
          child: Container(
            // margin: EdgeInsets.only(bottom: size.height * 0.1),
            padding: EdgeInsets.symmetric(vertical: 20),
            alignment: Alignment.center,
            width: size.width * 0.9,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: kWhite.withOpacity(0.55),
                  blurRadius: 1,
                  offset: Offset(0, 4),
                )
              ],
              color: kWhite,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              'Sign In',
              style: TextStyle(
                  color: kColorBackgroundDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
        InkWell(
          onTap: () async {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            await provider.googleLogin();
          },
          child: Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(vertical: 20),
            alignment: Alignment.center,
            width: size.width * 0.9,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: kWhite.withOpacity(0.55),
                  blurRadius: 1,
                  offset: Offset(0, 4),
                )
              ],
              color: kWhite,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.google,
                ),
                SizedBox(width: 15),
                Text(
                  'Sign In with Google',
                  style: TextStyle(
                    color: kColorBackgroundDark,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class EmailPasswordWrapper extends StatefulWidget {
  @override
  _EmailPasswordWrapperState createState() => _EmailPasswordWrapperState();
}

class _EmailPasswordWrapperState extends State<EmailPasswordWrapper> {
  final obscureText = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        TextFormField(
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0XFF706F75),
          ),
          controller: emailController,
          decoration: InputDecoration(
              fillColor: Color(0XFF1D1C23),
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Color(0XFF413F49),
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Color(0XFF413F49),
                  width: 2.0,
                ),
              ),
              contentPadding: EdgeInsets.all(20),
              hintText: 'Email, username',
              hintStyle: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                color: Color(0XFF706F75),
              )),
        ),
        SizedBox(height: size.height * 0.04),
        ValueListenableBuilder(
          valueListenable: obscureText,
          builder: (BuildContext context, bool value, Widget? child) {
            return TextFormField(
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0XFF706F75),
              ),
              controller: passwordController,
              obscureText: obscureText.value,
              decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: InkWell(
                      onTap: () => obscureText.value = !value,
                      child: SvgPicture.asset(
                        'assets/icons/show_password.svg',
                      ),
                    ),
                  ),
                  suffixIconConstraints: BoxConstraints(maxHeight: 40),
                  fillColor: Color(0XFF1D1C23),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Color(0XFF413F49),
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Color(0XFF413F49),
                      width: 2.0,
                    ),
                  ),
                  contentPadding: EdgeInsets.all(20),
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0XFF706F75),
                  )),
            );
          },
        ),
      ],
    );
  }
}
