import 'package:flutter/material.dart';
import 'package:littletherapist/controllers/auth_controller.dart';
import 'package:logger/logger.dart';

class SignupProvider extends ChangeNotifier {
  AuthController authController = AuthController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  Future<void> startSignUp() async {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty ||
        _passwordController.text != _confirmPasswordController.text) {
      Logger().e("Invalid data");
    } else {
      authController
          .createAccount(
              email: emailController.text, password: passwordController.text)
          .then((value) {
        if (value) {
          clearTextField();
        }
      });
    }
  }

  void clearTextField() {
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    notifyListeners();
  }
}
