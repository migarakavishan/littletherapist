import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Animate(
            effects: const [FadeEffect(), SlideEffect()],
            child: Container(
              height: 100,
              width: 200,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/Logo.png'))),
            )
            .animate()
            .fade(duration: 1000.ms)
            .slideY(curve: Curves.easeIn),
          ),
          Animate(
            effects: const [FadeEffect(), SlideEffect()],
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: size.width * 0.7,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 3))
                      ]),
                  child: const Center(
                      child: Text(
                    "GET START",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: size.width * 0.7,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 3))
                      ]),
                  child: const Center(
                      child: Text(
                    "ALREADY HAVE ACCOUNT",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
                ),
              ],
            )
            .animate()
            .fade(duration: 1000.ms)
            .slideY(begin: 4 , end: 1)
          ),
        ],
      ),
    ));
  }
}
