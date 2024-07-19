import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:littletherapist/models/user_model.dart';
import 'package:littletherapist/providers/auth_provider.dart' as auth_provider;
import 'package:littletherapist/screens/auth_screen/login_screen.dart';
import 'package:littletherapist/screens/home_page/home_page.dart';
import 'package:littletherapist/utils/navigation/custom_navigation.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class AuthController {
  CollectionReference users = FirebaseFirestore.instance.collection("Users");
  Future<void> listenAuthState(BuildContext context) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Logger().e('User is currently signed out!');
        CustomNavigation.nextPage(context, const LoginScreen());
      } else {
        Provider.of<auth_provider.AuthProvider>(context, listen: false)
            .setUser(user);
        Logger().e('User is signed in!');
        fetchUserData(user.uid).then((value) {
          if (value != null) {
            Provider.of<auth_provider.AuthProvider>(context, listen: false)
                .setUserModel(value);
            CustomNavigation.nextPage(context, const HomePage());
          } else {
            Provider.of<auth_provider.AuthProvider>(context, listen: false)
                .setUserModel(UserModel(name: "", image: "https://i.sstatic.net/l60Hf.png", email: user.uid, uid: user.uid));
            CustomNavigation.nextPage(context, const HomePage());
          }
        });
      }
    });
  }

  Future<bool> createAccount(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        UserModel model = UserModel(
            name: name,
            image: "https://i.sstatic.net/l60Hf.png",
            email: email,
            uid: credential.user!.uid);
        addUserData(model);
      }
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Logger().e('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Logger().e('The account already exists for that email.');
      }
      return false;
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }

  Future<void> signOutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<bool> signInWithPassword(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Logger().e('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Logger().e('Wrong password provided for that user.');
      }
      return false;
    }
  }

  Future<void> sendpasswordResetEmail(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future<void> addUserData(UserModel user) async {
    try {
      await users.doc(user.uid).set(user.toJson());
      Logger().f("user Data Added");
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<UserModel?> fetchUserData(String uid) async {
    try {
      DocumentSnapshot snapshot = await users.doc(uid).get();
      return UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
