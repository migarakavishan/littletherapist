import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:littletherapist/screens/auth_screen/login_screen/login_screen.dart';
import 'package:littletherapist/screens/home_page/home_page.dart';
import 'package:littletherapist/screens/splash_screen/widgets/button_get_start.dart';
import 'package:littletherapist/screens/splash_screen/widgets/button_have_account.dart';
import 'package:littletherapist/utils/navigation/custom_navigation.dart';
import 'package:logger/logger.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          Logger().e('User is currently signed out!');
          CustomNavigation.nextPage(context, const LoginScreen());
        } else {
          Logger().e('User is signed in!');
          CustomNavigation.nextPage(context, const HomePage());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
            top: 100,
            left: size.width * 0.25,
            child: Container(
              height: 100,
              width: size.width * 0.5,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/Logo.png'))),
            ).animate().fade(duration: 1000.ms).slideY(curve: Curves.easeIn)),
        Positioned(
            top: size.height * 0.5,
            right: 20,
            child: Container(
              height: 100,
              width: size.width * 0.5,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/cloud.png'))),
            ).animate().fade(duration: 1000.ms).slideX(begin: 3, end: 0)),
        Positioned(
            top: size.height * 0.3,
            right: 20,
            child: Container(
              height: 100,
              width: size.width * 0.5,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/cloud2.png'))),
            ).animate().fade(duration: 1000.ms).slideX(begin: 3, end: 0)),
        Positioned(
            top: size.height * 0.25,
            left: 20,
            child: Container(
              height: 300,
              width: size.width * 0.5,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/cloud2.png'))),
            ).animate().fade(duration: 1000.ms).slideX(begin: -3, end: 0)),
        Positioned(
            top: size.height * 0.3,
            child: Container(
              height: 200,
              width: size.width * 0.5,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/cat.png'))),
            ).animate().fade(duration: 1000.ms).slideY(curve: Curves.easeIn)),
        Positioned(
            top: size.height * 0.35,
            right: 20,
            child: Container(
              height: 200,
              width: size.width * 0.5,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/dog.png'))),
            ).animate().fade(duration: 1200.ms).slideY(curve: Curves.easeIn)),
        Positioned(
            top: size.height * 0.72,
            left: 60,
            child: GetStartButton(size: size)
                .animate()
                .fade(duration: 1000.ms)
                .slideY(begin: 4, end: 1)),
        Positioned(
            top: size.height * 0.8,
            left: 60,
            child: HaveAccountButton(size: size)
                .animate()
                .fade(duration: 1000.ms)
                .slideY(begin: 4, end: 1))
      ],
    ));
  }
}
