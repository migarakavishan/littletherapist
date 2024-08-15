import 'package:flutter/material.dart';

class Outline4 extends StatefulWidget {
  const Outline4({super.key});

  @override
  State<Outline4> createState() => _Outline4State();
}

class _Outline4State extends State<Outline4> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color(0xFF4CA5C1),
          title: const Text(
            "Drag and drop to correct shadow",
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
    );
  }
}
