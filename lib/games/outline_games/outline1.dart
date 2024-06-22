import 'package:flutter/material.dart';

class Outline1 extends StatefulWidget {
  const Outline1({super.key});

  @override
  State<Outline1> createState() => _Outline1State();
}

class _Outline1State extends State<Outline1> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Outline 1")),
    );
  }
}
