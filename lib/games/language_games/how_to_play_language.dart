import 'package:flutter/material.dart';
import 'package:littletherapist/games/language_games/language1.dart';
import 'package:littletherapist/utils/navigation/custom_navigation.dart';

class HowToPlayLanguageGames extends StatelessWidget {
  const HowToPlayLanguageGames({super.key});

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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Learn to Play!',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent),
              ),
              const SizedBox(height: 20),
              const Text(
                '1. Listen to the word spoken aloud.',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                '2. Look at the options on the screen.',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                '3. Select the picture that matches the word you heard.',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                '4. Click the "Check" button to see if you are correct.',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              const Text(
                'Tips:',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange),
              ),
              const SizedBox(height: 10),
              const Text(
                '• Take your time to listen carefully.',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                '• Try to associate the word with the picture to remember better.',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    CustomNavigation.nextPage(context,
                        const Language1()); // Go back to the previous screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                  ),
                  child: const Text('Start Playing',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
