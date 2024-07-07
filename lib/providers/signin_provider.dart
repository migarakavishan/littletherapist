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

  Future<void> startSignUp() async {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      Logger().e("Invalid data");
    } else {
      bool isSuccess = await authController.signInWithPassword(
          email: _emailController.text, password: _passwordController.text);
      if (isSuccess) {
        clearTextField();
      }
    }
  }

  Future<void> sendResetEmail() async {
    if (_restEmail.text.trim().isEmpty) {
      Logger().e("Please enter your email");
    } else {
      authController.sendpasswordResetEmail(_restEmail.text).then((value) {
        Logger().f("Check your Emails");
      });
    }
  }

  void clearTextField() {
    _emailController.clear();
    _passwordController.clear();
    notifyListeners();
  }
}
