import 'package:domapp/cache/constants.dart';
import 'package:domapp/components/custom_snack_bar.dart';
import 'package:domapp/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future signInWithEmail(
    {required String email, required String password}) async {
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  if (!emailValid) {
    showCustomSnackBar(text: 'Please enter a valid email and try again!');
    return;
  }
  if (password == '' || password.length < 6) {
    showCustomSnackBar(text: 'Please enter a valid password and try again');
    return;
  }
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(), password: password.trim());
    navigatorKey.currentState!.pop();
    showCustomSnackBar(text: 'SignIn Successful', color: kGreen);
  } on FirebaseAuthException catch (e) {
    showCustomSnackBar(text: e.message.toString());
  }
}

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;
  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      // navigatorKey.currentState!.pop();
      notifyListeners();
    } catch (e) {
      showCustomSnackBar(text: e.toString());
    }
  }

  Future googleLogout() async {
    await googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
  }
}
