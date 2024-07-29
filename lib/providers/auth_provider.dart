import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:littletherapist/models/user_model.dart';
import 'package:logger/logger.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  User? get user => _user;
  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void setUserModel(UserModel model) {
    _userModel = model;
    notifyListeners();
  }

  void fetchAndListenUserData(String uid) {
    FirebaseFirestore.instance.collection('Users').doc(uid).snapshots().listen(
        (snapshot) {
      if (snapshot.exists) {
        UserModel updatedUser =
            UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
        setUserModel(updatedUser);
      }
    }, onError: (error) => Logger().e("Failed to listen to user data: $error"));
  }
}
