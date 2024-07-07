import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:littletherapist/controllers/auth_controller.dart';

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
      AuthController().listenAuthState(context);
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
            left: 190,
            child: const CupertinoActivityIndicator(
              color: Colors.black,
            )),
      ],
    ));
  }
}
