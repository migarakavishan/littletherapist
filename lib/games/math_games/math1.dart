import 'package:flutter/material.dart';

class Math1 extends StatefulWidget {
  const Math1({super.key});

  @override
  State<Math1> createState() => _Math1State();
}

class _Math1State extends State<Math1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF4CA5C1),
        title: const Text(
          "Give Correct Ansewer",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
