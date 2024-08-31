import 'package:flutter/material.dart';
import 'package:littletherapist/controllers/auth_controller.dart';
import 'package:littletherapist/providers/auth_provider.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class ProfileProvider extends ChangeNotifier {
  AuthController authController = AuthController();
  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  void setUserName(String name) {
    _nameController.text = name;
    notifyListeners();
  }

  Future<void> updateUserData(BuildContext context) async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    if (_nameController.text.trim().isNotEmpty) {
      Map<String, dynamic> data = {
        "name": _nameController.text,
      };
      authController.updateUser(data, auth.user!.uid, context);
    } else {
      Logger().e("Please enter your name");
    }
  }

  void loadUserData(AuthProvider auth) {
    if (auth.userModel != null) {
      _nameController.text = auth.userModel!.name;
    }
  }
}
