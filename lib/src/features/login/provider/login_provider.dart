import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recipely/src/features/login/models/login_request.dart';
import 'package:recipely/src/utils/app_snackbars.dart';

import '../../../constants/constants.dart';
import '../../home/home.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();
  bool obscurePassword = true;

  FirebaseAuth auth = FirebaseAuth.instance;

  doLogin(BuildContext context, LoginRequest loginRequest) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginRequest.email,
        password: loginRequest.password,
      );

      if (userCredential.user != null) {
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const HomeScreen();
              },
            ),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        debugPrint("Exception >>>>> ${e.code}");
      }
      if (e.code == 'user-not-found') {
        AppSnackBar.showSnackBar(context: context, message: userNotFoundText);
      } else if (e.code == 'wrong-password') {
        AppSnackBar.showSnackBar(
            context: context, message: passwordInvalidText);
      } else if (e.code == 'invalid-email') {
        AppSnackBar.showSnackBar(context: context, message: emailInvalidText);
      }
    }
  }
}
