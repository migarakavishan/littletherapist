import 'package:flutter/material.dart';
import 'package:littletherapist/games/puzzles/puzzle1.dart';
import 'package:littletherapist/utils/navigation/custom_navigation.dart';

class HowToPlayPuzzle extends StatelessWidget {
  const HowToPlayPuzzle({super.key});

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
          children: <Widget>[
            const Text(
              'Getting Started',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Learn the basics of how to play the puzzle games and get ready to challenge your kid problem-solving skills.',
              style: TextStyle(fontSize: 18),
            ),
            const Text(
              'These games also help children improve their memory, spatial awareness, and color recognition.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'Step-by-Step Instructions',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              '1. Begin with easy puzzles to understand the game layout and mechanics.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            const Text(
              '2. Drag and drop the puzzle pieces to their correct positions to form a complete picture.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            const Text(
              '3. Use the image preview as a guide to know what the completed puzzle should look like.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            const Text(
              '4. Try to complete the puzzle in the shortest time possible to increase your score.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Center(
                child: FilledButton(
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.blue),
                    ),
                    onPressed: () {
                      CustomNavigation2.nextPage2(context, const Puzzle1());
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
