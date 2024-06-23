import 'package:flutter/material.dart';

class Outline1 extends StatefulWidget {
  const Outline1({super.key});

  @override
  State<Outline1> createState() => _Outline1State();
}

class _Outline1State extends State<Outline1> {
  bool isDropped = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Drag and drop to correct shadow",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 50,
            right: 100,
            child: Draggable<String>(
              data: "apple",
              onDraggableCanceled: (velocity, offset) {},
              feedback: Image.asset(
                "assets/images/appleright.png",
                height: 200,
                opacity: const AlwaysStoppedAnimation(0.5),
              ),
              childWhenDragging: Container(),
              child: Image.asset(
                "assets/images/appleright.png",
                height: 200,
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 100,
            child: DragTarget<String>(
              onAcceptWithDetails: (data) {
                setState(() {
                  isDropped = true;
                });
              },
              builder: (context, candidateData, rejectedData) {
                return isDropped
                    ? Image.asset(
                        "assets/images/appleright.png",
                        height: 200,
                      )
                    : Image.asset(
                        "assets/images/appledarkright.png",
                        height: 200,
                      );
              },
            ),
          )
        ],
      ),
    );
  }
}
