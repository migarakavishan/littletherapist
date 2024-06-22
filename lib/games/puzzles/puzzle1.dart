import 'package:flutter/material.dart';

class Puzzle1 extends StatefulWidget {
  const Puzzle1({super.key});

  @override
  State<Puzzle1> createState() => _Puzzle1State();
}

class _Puzzle1State extends State<Puzzle1> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Puzzle1"),
      ),
    );
  }
}
