import 'dart:async';

import 'package:flutter/material.dart';
import 'package:littletherapist/games/math_games/math2.dart';
import 'package:littletherapist/games/outline_games/outline3.dart';
import 'package:littletherapist/providers/math_score_provide.dart';
import 'package:littletherapist/utils/navigation/custom_navigation.dart';
import 'package:provider/provider.dart';

class Math1 extends StatefulWidget {
  const Math1({super.key});

  @override
  State<Math1> createState() => _Math1State();
}

class _Math1State extends State<Math1> {
  bool isNum1Dropped = false;
  bool isNum2Dropped = false;
  bool isNum3Dropped = false;
  bool isNum4Dropped = false;

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
          if (isNum1Dropped &&
              isNum2Dropped &&
              isNum3Dropped &&
              isNum4Dropped) {
            completeMath();
          } else {
            // Handle what happens if the time runs out without both items correctly placed
          }
        }
      });
    });
  }

  void completeMath() {
    if (_start > 0) {
      Provider.of<MathScoreProvider>(context, listen: false).addScore(10);
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
            "Give Correct Ansewer",
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
                      "Level 1",
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
                                '${Provider.of<MathScoreProvider>(context).score}',
                                style: const TextStyle(color: Colors.white)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 500,
                height: 400,
                decoration: BoxDecoration(
                    color: const Color(0xff9CBD3B),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      )
                    ]),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/images/appleright.png",
                            height: 70,
                          ),
                          const SizedBox(
                            width: 200,
                          ),
                          const Text("="),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(10)),
                            child: DragTarget<String>(
                              onWillAccept: (data) => data == "number1",
                              onAccept: (data) {
                                setState(() {
                                  isNum1Dropped = true;
                                });
                              },
                              builder: (context, candidateData, rejectedData) {
                                return isNum1Dropped
                                    ? Image.asset(
                                        "assets/images/number1.png",
                                        height: 100,
                                      )
                                    : const SizedBox(
                                        height: 90,
                                        width: 90,
                                      );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/appleright.png",
                                height: 70,
                              ),
                              Image.asset(
                                "assets/images/appleright.png",
                                height: 70,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 130,
                          ),
                          const Text("="),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(10)),
                            child: DragTarget<String>(
                              onWillAccept: (data) => data == "number2",
                              onAccept: (data) {
                                setState(() {
                                  isNum2Dropped = true;
                                });
                              },
                              builder: (context, candidateData, rejectedData) {
                                return isNum2Dropped
                                    ? Image.asset(
                                        "assets/images/number2.png",
                                        height: 100,
                                      )
                                    : const SizedBox(
                                        height: 90,
                                        width: 90,
                                      );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/appleright.png",
                                height: 70,
                              ),
                              Image.asset(
                                "assets/images/appleright.png",
                                height: 70,
                              ),
                              Image.asset(
                                "assets/images/appleright.png",
                                height: 70,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          const Text("="),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(10)),
                            child: DragTarget<String>(
                              onWillAccept: (data) => data == "number3",
                              onAccept: (data) {
                                setState(() {
                                  isNum3Dropped = true;
                                });
                              },
                              builder: (context, candidateData, rejectedData) {
                                return isNum3Dropped
                                    ? Image.asset(
                                        "assets/images/number3.png",
                                        height: 100,
                                      )
                                    : const SizedBox(
                                        height: 90,
                                        width: 90,
                                      );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/appleright.png",
                                height: 70,
                              ),
                              Image.asset(
                                "assets/images/appleright.png",
                                height: 70,
                              ),
                              Image.asset(
                                "assets/images/appleright.png",
                                height: 70,
                              ),
                              Image.asset(
                                "assets/images/appleright.png",
                                height: 70,
                              ),
                            ],
                          ),
                          const Text("="),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(10)),
                            child: DragTarget<String>(
                              onWillAccept: (data) => data == "number4",
                              onAccept: (data) {
                                setState(() {
                                  isNum4Dropped = true;
                                  if (isNum1Dropped &&
                                      isNum2Dropped &&
                                      isNum3Dropped &&
                                      isNum4Dropped) {
                                    completeMath();
                                  }
                                });
                              },
                              builder: (context, candidateData, rejectedData) {
                                return isNum4Dropped
                                    ? Image.asset(
                                        "assets/images/number4.png",
                                        height: 100,
                                      )
                                    : const SizedBox(
                                        height: 90,
                                        width: 90,
                                      );
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 200,
                width: 500,
                decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      )
                    ]),
                child: Row(
                  children: [
                    Draggable<String>(
                        data: "number1",
                        feedback: Image.asset(
                          "assets/images/number1.png",
                          height: 90,
                          width: 90,
                          opacity: const AlwaysStoppedAnimation(0.5),
                        ),
                        childWhenDragging: const SizedBox(
                          height: 90,
                          width: 90,
                        ),
                        child: Image.asset(
                          "assets/images/number1.png",
                          height: 90,
                          width: 90,
                        )),
                    Draggable<String>(
                        data: "number2",
                        feedback: Image.asset(
                          "assets/images/number2.png",
                          height: 90,
                          width: 90,
                          opacity: const AlwaysStoppedAnimation(0.5),
                        ),
                        childWhenDragging: const SizedBox(
                          height: 90,
                          width: 90,
                        ),
                        child: Image.asset(
                          "assets/images/number2.png",
                          height: 90,
                          width: 90,
                        )),
                    Draggable<String>(
                        data: "number3",
                        feedback: Image.asset(
                          "assets/images/number3.png",
                          height: 90,
                          width: 90,
                          opacity: const AlwaysStoppedAnimation(0.5),
                        ),
                        childWhenDragging: const SizedBox(
                          height: 90,
                          width: 90,
                        ),
                        child: Image.asset(
                          "assets/images/number3.png",
                          height: 90,
                          width: 90,
                        )),
                    Draggable<String>(
                        data: "number4",
                        feedback: Image.asset(
                          "assets/images/number4.png",
                          height: 90,
                          width: 90,
                          opacity: const AlwaysStoppedAnimation(0.5),
                        ),
                        childWhenDragging: const SizedBox(
                          height: 90,
                          width: 90,
                        ),
                        child: Image.asset(
                          "assets/images/number4.png",
                          height: 90,
                          width: 90,
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  CustomNavigation2.nextPage2(context, const Math2());
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
