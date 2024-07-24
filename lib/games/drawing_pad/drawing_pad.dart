import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';

class DrawingPad extends StatefulWidget {
  const DrawingPad({super.key});

  @override
  State<DrawingPad> createState() => _DrawingPadState();
}

class _DrawingPadState extends State<DrawingPad> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.amber,
      body: DrawingBoard(
        background: Container(
            width: size.width, height: size.height, color: Colors.white),
        showDefaultActions: true,

        /// Enable default action options
        showDefaultTools: true,

        /// Enable default toolbar
      ),
    );
  }
}
