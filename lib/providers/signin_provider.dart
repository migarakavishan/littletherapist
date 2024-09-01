import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:littletherapist/controllers/auth_controller.dart';
import 'package:logger/logger.dart';

class SigninProvider extends ChangeNotifier {
  AuthController authController = AuthController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _restEmail = TextEditingController();

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get resetEmail => _restEmail;

  Future<void> startSignIn(BuildContext context) async {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      Logger().e("Invalid data");
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Column(
              children: [
                Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                Text("Oops...")
              ],
            ),
            content: const Text("Please enter both email and password."),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    } else {
      bool isSuccess = await authController.signInWithPassword(
          email: _emailController.text,
          password: _passwordController.text,
          context: context);
      if (isSuccess) {
        clearTextField();
      }
    }
  }

  Future<void> sendResetEmail(BuildContext context) async {
    if (_restEmail.text.trim().isEmpty) {
      Logger().e("Please enter your email");
      if (context.mounted) {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: const Column(
                children: [
                  Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                  Text("Oops...")
                ],
              ),
              content: const Text("Please enter your email"),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: const Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          },
        );
      }
    } else {
      authController.sendpasswordResetEmail(_restEmail.text).then((value) {
        Logger().f("Check your Emails");
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: const Column(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.red,
                  ),
                  Text("Sending...")
                ],
              ),
              content: const Text("Check your Emails"),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: const Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          },
        );
        clearTextField();
      });
    }
  }

  void clearTextField() {
    _emailController.clear();
    _passwordController.clear();
    _restEmail.clear();
    notifyListeners();
  }
}
