import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/core/notifications/firebase.dart';

import '../../constants.dart';
import '../../features/auth/login.dart';
import '../../features/home/home.dart';
import '../../widgets/action_dialog.dart';
import '../../widgets/loading_dialog.dart';
import '../router/router.dart';
import 'home_provider.dart';

class AuthProvider extends ChangeNotifier {
  static AuthProvider get(context) => Provider.of<AuthProvider>(context);

  static AuthProvider listenFalse(context) =>
      Provider.of<AuthProvider>(context, listen: false);

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController regEmailController = TextEditingController();
  TextEditingController regUsernameController = TextEditingController();
  TextEditingController regPasswordController = TextEditingController();
  TextEditingController regConfirmPasswordController = TextEditingController();

  Future<void> login() async {
    try {
      showDialog(
          context: navigatorKey.currentContext!,
          builder: (_) => LoadingDialog());
      await firebaseAuth.signInWithEmailAndPassword(
          email: loginEmailController.text,
          password: loginPasswordController.text);
      loginEmailController.clear();
      loginPasswordController.clear();
      MagicRouter.pop();
      MagicRouter.navigateAndPopAll(Home());
    } on FirebaseAuthException catch (e) {
      MagicRouter.pop();
      showDialog(
          context: navigatorKey.currentContext!,
          builder: (_) => ActionDialog(
                content: e.message,
                onApproveClick: () {
                  MagicRouter.pop();
                },
                approveAction: 'Okay',
              ));
    }
  }

  Future<void> logout() async {
    await firebaseAuth.signOut();
    MagicRouter.navigateAndPopAll(Login());
  }

  Future<void> registration() async {
    try {
      showDialog(
          context: navigatorKey.currentContext!,
          builder: (_) => LoadingDialog());
      await firebaseAuth.createUserWithEmailAndPassword(
          email: regEmailController.text, password: regPasswordController.text);
      if (firebaseAuth.currentUser != null) {
        await firebaseAuth.currentUser!
            .updateDisplayName(regUsernameController.text);
      }
      MagicRouter.pop();
      MagicRouter.navigateAndPopAll(Login());
      regUsernameController.clear();
      regPasswordController.clear();
      regConfirmPasswordController.clear();
      regEmailController.clear();
    } on FirebaseAuthException catch (e) {
      MagicRouter.pop();
      showDialog(
          context: navigatorKey.currentContext!,
          builder: (_) => ActionDialog(
                content: e.message,
                onApproveClick: () {
                  MagicRouter.pop();
                },
                approveAction: 'Okay',
              ));
    }
  }
}
