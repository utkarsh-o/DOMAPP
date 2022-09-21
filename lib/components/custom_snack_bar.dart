import 'package:domapp/cache/constants.dart';
import 'package:flutter/material.dart';

showCustomSnackBar({
  required String text,
  Color color = kRed,
  EdgeInsets? margin,
}) {
  snackbarKey.currentState?.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: margin ?? const EdgeInsets.all(30),
      backgroundColor: color,
      content: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
  );
}
