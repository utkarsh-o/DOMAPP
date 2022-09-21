import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../cache/constants.dart';
import '../cache/local_data.dart';

DateTime pickedDate = DateTime.now();

class RegisterPage extends StatelessWidget {
  static const String route = 'RegisterPage';
  @override
  Widget build(BuildContext context) {
    void datePicker() async {
      DateTime? date = await showDatePicker(
        context: context,
        initialDate: pickedDate,
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime(DateTime.now().year + 1),
      );
      if (date != null) {
        // setState(() {
        //   pickedDate = date;
        // });
      }
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: kOuterPadding,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 30),
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(context),
                    child: SvgPicture.asset(
                      'assets/icons/back_button_title_bar.svg',
                      color: kWhite,
                    ),
                  ),
                ),
                Text(
                  'REGISTER',
                  style: TextStyle(
                    color: kWhite,
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: kBlue,
                                  boxShadow: [
                                    BoxShadow(
                                        color: kBlue.withOpacity(0.45),
                                        offset: Offset(0, 4),
                                        blurRadius: 1),
                                  ],
                                ),
                                child: SvgPicture.asset(
                                  'assets/icons/expand_left.svg',
                                  height: 25,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: kBlue,
                                  boxShadow: [
                                    BoxShadow(
                                        color: kBlue.withOpacity(0.45),
                                        offset: Offset(0, 4),
                                        blurRadius: 1),
                                  ],
                                ),
                                child: SvgPicture.asset(
                                  'assets/icons/expand_right.svg',
                                  height: 25,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    constraints: BoxConstraints(
                                        minHeight: size.height * 0.1),
                                    width: 8,
                                    color: kRed,
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Name',
                                        style: TextStyle(
                                          fontFamily: 'Satisfy',
                                          color: kWhite,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Container(
                                        width: size.width * 0.4,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          // color: kWhite,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 1,
                                              color: kWhite.withOpacity(0.45),
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: TextFormField(
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: kColorBackgroundDark,
                                          ),
                                          // controller: emailController,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            fillColor: kWhite,
                                            filled: true,
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide(
                                                color: kWhite,
                                                width: 2.0,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide(
                                                color: kWhite,
                                                width: 2.0,
                                              ),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 15),
                                            hintText: 'Vaani Mishra',
                                            hintStyle: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w600,
                                              color: kColorBackgroundDark
                                                  .withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    constraints: BoxConstraints(
                                        minHeight: size.height * 0.1),
                                    width: 8,
                                    color: kYellow,
                                  ),
                                  // SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Batch',
                                        style: TextStyle(
                                          fontFamily: 'Satisfy',
                                          color: kWhite,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Container(
                                          padding: EdgeInsets.all(6),
                                          // width: size.width * 0.4,
                                          decoration: BoxDecoration(
                                            color: kWhite,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            // color: kWhite,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 1,
                                                color: kWhite.withOpacity(0.45),
                                                offset: Offset(0, 4),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/icons/expand_left.svg',
                                                height: 15,
                                              ),
                                              Text('2019',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: kColorBackgroundDark,
                                                  )),
                                              SvgPicture.asset(
                                                'assets/icons/expand_right.svg',
                                                height: 15,
                                              ),
                                            ],
                                          ))
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Birthday',
                                        style: TextStyle(
                                          fontFamily: 'Satisfy',
                                          color: kWhite,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(6),
                                        // width: size.width * 0.4,
                                        decoration: BoxDecoration(
                                          color: kWhite,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          // color: kWhite,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 1,
                                              color: kWhite.withOpacity(0.45),
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          DateFormat('MMM d yyyy')
                                              .format(pickedDate),
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: kColorBackgroundDark,
                                            // fontFamily: 'Montserrat'),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    constraints: BoxConstraints(
                                        minHeight: size.height * 0.1),
                                    width: 8,
                                    color: kGreen,
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Username',
                                        style: TextStyle(
                                          fontFamily: 'Satisfy',
                                          color: kWhite,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Container(
                                        width: size.width * 0.4,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          // color: kWhite,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 1,
                                              color: kWhite.withOpacity(0.45),
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: TextFormField(
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: kColorBackgroundDark,
                                          ),
                                          // controller: emailController,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            fillColor: kWhite,
                                            filled: true,
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide(
                                                color: kWhite,
                                                width: 2.0,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide(
                                                color: kWhite,
                                                width: 2.0,
                                              ),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 8,
                                                    horizontal: 15),
                                            hintText: 'vmMishra',
                                            hintStyle: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w600,
                                              color: kColorBackgroundDark
                                                  .withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: size.height * 0.04),
                EmailPasswordWrapper(),
                SizedBox(height: size.height * 0.04),
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
    return Center(
      child: SizedBox(
        width: size.width * 0.75,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'forgot password',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kWhite.withOpacity(0.4),
                  fontSize: 16),
            ),
            SizedBox(height: size.height * 0.02),
            InkWell(
              // onTap: () => Navigator.pushNamed(context, HomePage.route),
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
            )
          ],
        ),
      ),
    );
  }
}

class EmailPasswordWrapper extends StatefulWidget {
  @override
  _EmailPasswordWrapperState createState() => _EmailPasswordWrapperState();
}

class _EmailPasswordWrapperState extends State<EmailPasswordWrapper> {
  bool obscureText = true;
  showPasswordCallback() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        width: size.width * 0.75,
        child: Column(
          children: [
            TextFormField(
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0XFF706F75),
              ),
              // controller: emailController,
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
            TextFormField(
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0XFF706F75),
              ),
              // controller: passwordController,
              obscureText: obscureText,
              decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: InkWell(
                      onTap: showPasswordCallback,
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
            ),
          ],
        ),
      ),
    );
  }
}

class DatePickerWrapper extends StatefulWidget {
  @override
  _DatePickerWrapperState createState() => _DatePickerWrapperState();
}

class _DatePickerWrapperState extends State<DatePickerWrapper> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    void datePicker() async {
      DateTime? date = await showDatePicker(
        context: context,
        initialDate: pickedDate,
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime(DateTime.now().year + 1),
      );
      if (date != null) {
        setState(() {
          pickedDate = date;
        });
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: DatePicker(callback: datePicker),
    );
  }
}

class DatePicker extends StatelessWidget {
  final VoidCallback callback;
  DatePicker({required this.callback});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: callback,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 2,
            color: Color(0XFF413F49),
          ),
          color: Color(0XFF1D1C23),
        ),
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          DateFormat('EEE, MMM d').format(pickedDate),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: kWhite,
            // fontFamily: 'Montserrat'),
          ),
        ),
      ),
    );
  }
}
