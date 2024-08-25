import 'dart:async';

import 'package:flutter/material.dart';
import 'package:littletherapist/games/outline_games/outline3.dart';
import 'package:littletherapist/providers/outline_score_provider.dart';
import 'package:littletherapist/utils/navigation/custom_navigation.dart';
import 'package:provider/provider.dart';

class Outline2 extends StatefulWidget {
  const Outline2({super.key});

  @override
  State<Outline2> createState() => _Outline2State();
}

class _Outline2State extends State<Outline2> {
  bool isSmallAppleDropped = false;
  bool isLargeAppleDropped = false;

  late Timer _timer;
  int _start = 60;
  double _progress = 1.0;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
          _progress = _start / 60.0;
        } else {
          _timer.cancel();
          if (isSmallAppleDropped && isLargeAppleDropped) {
            completeOutline();
          } else {
            // Handle what happens if the time runs out without both items correctly placed
          }
        }
      });
    });
  }

  void completeOutline() {
    if (_start > 0) {
      Provider.of<OutlineScoreProvider>(context, listen: false).addScore(20);
      navigateToNextOutline();
    }
    _timer.cancel();
    navigateToNextOutline();
  }

  void navigateToNextOutline() {
    CustomNavigation2.nextPage2(
        context, const Outline3()); // Assuming there's another level
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            value: _progress,
                            backgroundColor: Colors.grey[300],
                            color: Colors.blue,
                            strokeWidth: 6,
                          ),
                        ),
                        Text("${_start}s"),
                      ],
                    ),
                    const Text(
                      "Level 2",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 45,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.blue.shade500,
                              borderRadius: const BorderRadiusDirectional.only(
                                  topStart: Radius.circular(10),
                                  bottomStart: Radius.circular(10))),
                          child: const Center(
                              child: Text(
                            "Score",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                        Container(
                          width: 45,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.blue.shade400,
                              borderRadius: const BorderRadiusDirectional.only(
                                  topEnd: Radius.circular(10),
                                  bottomEnd: Radius.circular(10))),
                          child: Center(
                            child: Text(
                                '${Provider.of<OutlineScoreProvider>(context).score}',
                                style: const TextStyle(color: Colors.white)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
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
                            if (isSmallAppleDropped && isLargeAppleDropped) {
                              completeOutline();
                            }
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
                            if (isSmallAppleDropped && isLargeAppleDropped) {
                              completeOutline();
                            }
                          });
                        },
                        builder: (context, candidateData, rejectedData) {
                          return isLargeAppleDropped
                              ? Image.asset("assets/images/appleright.png",
                                  height: 200)
                              : Image.asset("assets/images/appledarkright.png",
                                  height: 200);
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
                  CustomNavigation2.nextPage2(context, const Outline3());
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
