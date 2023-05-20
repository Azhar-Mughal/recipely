import 'package:flutter/material.dart';

import '../extensions/extensions.dart';

class AppSnackBar {
  static showSnackBar(
      {required BuildContext context, required String message}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: HexColor("#000000"),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        closeIconColor: HexColor("#00838f"),
        content: Text(message),
      ),
    );
  }
}
