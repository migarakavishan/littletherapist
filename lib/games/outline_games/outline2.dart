import 'package:flutter/material.dart';
import 'package:littletherapist/utils/navigation/custom_navigation.dart';

class Outline2 extends StatefulWidget {
  const Outline2({super.key});

  @override
  State<Outline2> createState() => _Outline2State();
}

class _Outline2State extends State<Outline2> {
  bool isSmallAppleDropped = false;
  bool isLargeAppleDropped = false;
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
                "Level 2",
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
                      left: 40,
                      child: DragTarget<String>(
                        onWillAccept: (data) => data == "small_apple",
                        onAccept: (data) {
                          setState(() {
                            isSmallAppleDropped = true;
                          });
                        },
                        builder: (context, candidateData, rejectedData) {
                          return isSmallAppleDropped
                              ? Image.asset(
                                  "assets/images/appleright.png",
                                  height: 100,
                                )
                              : Image.asset(
                                  "assets/images/appledarkright.png",
                                  height: 100,
                                );
                        },
                      ),
                    ),
                    Positioned(
                      top: 50,
                      right: 40,
                      child: DragTarget<String>(
                        onWillAccept: (data) => data == "large_apple",
                        onAccept: (data) {
                          setState(() {
                            isLargeAppleDropped = true;
                          });
                        },
                        builder: (context, candidateData, rejectedData) {
                          return isLargeAppleDropped
                              ? Image.asset(
                                  "assets/images/apple.png",
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
              ),
              Container(
                height: 300,
                decoration: const BoxDecoration(color: Color(0xFFFFA7A7)),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 40,
                      left: 40,
                      child: Draggable<String>(
                          data: "small_apple",
                          feedback: Image.asset(
                            "assets/images/appleright.png",
                            height: 100,
                            opacity: const AlwaysStoppedAnimation(0.5),
                          ),
                          childWhenDragging: Container(),
                          child: Image.asset(
                            "assets/images/appleright.png",
                            height: 100,
                          )),
                    ),
                    Positioned(
                      bottom: 40,
                      right: 40,
                      child: Draggable<String>(
                          data: "large_apple",
                          feedback: Image.asset(
                            "assets/images/appleright.png",
                            height: 200,
                            opacity: const AlwaysStoppedAnimation(0.5),
                          ),
                          childWhenDragging: Container(),
                          child: Image.asset(
                            "assets/images/appleright.png",
                            height: 200,
                          )),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  CustomNavigation2.nextPage2(context, const Outline2());
                },
                child: const CircleAvatar(
                  child: Icon(Icons.arrow_right_alt_rounded),
                ),
              )
            ],
          ),
        ));
  }
}
