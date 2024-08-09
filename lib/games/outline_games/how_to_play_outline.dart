import 'package:flutter/material.dart';
import 'package:littletherapist/games/outline_games/outline1.dart';
import 'package:littletherapist/utils/navigation/custom_navigation.dart';

class HowToPlayOutline extends StatelessWidget {
  const HowToPlayOutline({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF4CA5C1),
        title: const Text(
          "How to Play",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to Outline Games!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Outline games challenge your precision and attention to detail. Follow these steps to master the game.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'Game Instructions',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              '1. Start with a basic outline displayed on your screen.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            const Text(
              '2. Drag and drop each items into correct shadow.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Center(
                child: FilledButton(
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.blue),
                    ),
                    onPressed: () {
                      CustomNavigation2.nextPage2(context, const Outline1());
                    },
                    child: const Text(
                      "Start Playing",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ))),
          ],
        ),
      ),
    );
  }
}
