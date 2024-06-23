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
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color(0xFF4CA5C1),
          title: const Text(
            "Drag and drop to correct shadow",
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Level 1",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                height: 300,
                decoration: const BoxDecoration(color: Color(0xFFAEAEAE)),
                child: Stack(
                  children: [
                    Positioned(
                        top: 50,
                        left: 80,
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
                        ))
                  ],
                ),
              ),
              Container(
                height: 300,
                decoration: const BoxDecoration(color: Color(0xFFFFA7A7)),
                child: Stack(
                  children: [
                    Positioned(
                        bottom: 40,
                        left: 80,
                        child: Draggable<String>(
                            data: "apple",
                            feedback: Image.asset(
                              "assets/images/appleright.png",
                              height: 200,
                              opacity: const AlwaysStoppedAnimation(0.5),
                            ),
                            childWhenDragging: Container(),
                            child: Image.asset(
                              "assets/images/appleright.png",
                              height: 200,
                            )))
                  ],
                ),
              ),
              const CircleAvatar(
                child: Icon(Icons.arrow_right_alt_rounded),
              )
            ],
          ),
        ));
  }
}
